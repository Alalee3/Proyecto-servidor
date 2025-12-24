<?php

namespace App\Livewire\Forms\Planificacion;

use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Livewire\Attributes\Validate;
use Livewire\Form;
use Illuminate\Validation\Rule;


class CreatePlanificacionForm extends Form
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        // Verificar si el usuario está autenticado y tiene el rol de profesor (rol_id = 2)
        if (Auth::check()) {
            $userId = Auth::id();
            $hasProfessorRole = DB::table('usuario_rol')
                ->where('id_users', $userId)
                ->where('id_rol', 2) // Asumiendo que 2 es el rol de profesor
                ->exists();

            return $hasProfessorRole;
        }
        return false; // No autorizado si no hay usuario o no tiene el rol
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, mixed>
     */
    public function rules()
    {
        $rules = [
            'proyecto_planificacion_id' => 'required|exists:proyecto_planificacion,id', // O la PK real de tu tabla
            'docente_id' => 'required|exists:users,id', // 'users' es la tabla por defecto para Auth::id()
            'seccion_id' => 'required|exists:secciones,seccion_id',
            'lapso_academico_id' => 'required|exists:lapso_academico,lapso_id',
            'fecha_asignacion' => 'nullable|date',

            'selectedUnidadCurricularId' => 'required|string|max:7|exists:unidades_curriculares,codigo', // <-- Validación completa para codigo

            'selectedBibliografiasIds.*' => 'nullable|exists:bibliografias,id', // Asumiendo 'id' es PK de bibliografias
            'newBibliografias.*.titulo' => 'nullable|string|max:255',
            'newBibliografias.*.autor' => 'nullable|string|max:255',
            'newBibliografias.*.anio' => 'nullable|integer|digits:4',
            'newBibliografias.*' => [
                function ($attribute, $value, $fail) {
                    $index = explode('.', $attribute)[1];
                    $data = $this->all();
                    $newBibData = $data['newBibliografias'][$index];
                    if (empty($newBibData['titulo']) && empty($newBibData['autor']) && empty($newBibData['anio'])) {
                        $fail("Debe proporcionar al menos un título o autor para la bibliografía #" . ($index + 1) . " o eliminarla.");
                    }
                }
            ],

            // Validaciones para los "cortes" anidados
            'cortes' => 'required|array|size:4', // Debe haber exactamente 4 cortes
            'cortes.*.detalle_actividades' => 'required|array|size:2', // Cada corte debe tener exactamente 2 actividades/contenidos

            'cortes.*.detalle_actividades.*.contenido_id' => [
                'required',
                'exists:contenidos,id',
                // Validación para que el contenido sea único en la unidad curricular seleccionada
                // Esto es complejo sin Eloquent y una Planificación ID global. La validación actual
                // se asegura que sea único en todos los contenidos de esta submission.
            ],
            'cortes.*.detalle_actividades.*.selectedRecursosIds.*' => 'nullable|exists:recursos,recurso_id',
            'cortes.*.detalle_actividades.*.newRecursos' => 'nullable|string',
            'cortes.*.detalle_actividades.*.selectedEstrategiasIds.*' => 'nullable|exists:estrategias_pedagogicas,estrategia_id',
            'cortes.*.detalle_actividades.*.newEstrategias' => 'nullable|string',

            // Validación de una sola evaluación por actividad
            'cortes.*.detalle_actividades.*.evaluacion.evaluacion_id' => 'nullable|exists:evaluaciones,evaluacion_id',
            'cortes.*.detalle_actividades.*.evaluacion.tecnica_id' => 'nullable|exists:tecnicas,tecnica_id',
            'cortes.*.detalle_actividades.*.evaluacion.ponderacion' => 'required|numeric|min:0',
            'cortes.*.detalle_actividades.*.evaluacion.forma_de_participacion' => 'required|string|max:255',
            'cortes.*.detalle_actividades.*.evaluacion.new_evaluacion' => 'nullable|string|max:255',
            'cortes.*.detalle_actividades.*.evaluacion.new_tecnica' => 'nullable|string|max:255',
            'cortes.*.detalle_actividades.*.evaluacion' => [
                function ($attribute, $value, $fail) {
                    $corteIndex = explode('.', $attribute)[1];
                    $actIndex = explode('.', $attribute)[3];
                    $data = $this->all();
                    $evaluacionData = $data['cortes'][$corteIndex]['detalle_actividades'][$actIndex]['evaluacion'];

                    if (empty($evaluacionData['evaluacion_id']) && empty($evaluacionData['new_evaluacion'])) {
                        $fail("Debe seleccionar una evaluación existente o proporcionar una nueva para la actividad #" . ($actIndex + 1) . " del corte #" . ($corteIndex + 1));
                    }
                    if (empty($evaluacionData['tecnica_id']) && empty($evaluacionData['new_tecnica'])) {
                        $fail("Debe seleccionar una técnica existente o proporcionar una nueva para la actividad #" . ($actIndex + 1) . " del corte #" . ($corteIndex + 1));
                    }
                }
            ],
        ];

        // Reglas de validación personalizadas para "cortes"
        $rules['cortes'][] = function ($attribute, $value, $fail) {
            $allContentsUsed = []; // Para verificar contenidos únicos en toda la planificación

            foreach ($value as $corteIndex => $corte) {
                // Validación para que los contenidos sean únicos dentro del mismo corte
                $contenidosInCorte = [];
                foreach ($corte['detalle_actividades'] as $actividad) {
                    $contenidosInCorte[] = $actividad['contenido_id'];
                }

                if (count(array_unique($contenidosInCorte)) !== 2) {
                    $fail("El corte #" . ($corteIndex + 1) . " debe tener 2 contenidos únicos.");
                }

                // Validación para que los contenidos no se repitan entre cortes
                foreach ($contenidosInCorte as $contenidoId) {
                    if (in_array($contenidoId, $allContentsUsed)) {
                        $fail("El contenido '{$contenidoId}' (ID) ya ha sido seleccionado en otro corte.");
                    }
                    $allContentsUsed[] = $contenidoId;
                }

                // Suma de ponderaciones para este corte
                $ponderacionCorte = 0;
                foreach ($corte['detalle_actividades'] as $actividad) {
                    $ponderacionCorte += $actividad['evaluacion']['ponderacion'];
                }

                // Validación de suma de ponderaciones por corte
                if ($ponderacionCorte != 25) {
                    $fail("La suma de las ponderaciones para el corte #" . ($corteIndex + 1) . " debe ser 25%. Suma actual: " . $ponderacionCorte . "%");
                }
            }

            // Validación de que la suma total de ponderaciones es un múltiplo de 25
            // Se asume que siempre habrá 4 cortes, sumando 100% en total
            $totalPonderacionGeneral = 0;
            foreach ($value as $corte) {
                foreach ($corte['detalle_actividades'] as $actividad) {
                    $totalPonderacionGeneral += $actividad['evaluacion']['ponderacion'];
                }
            }

            if (count($value) == 4 && $totalPonderacionGeneral != 100) {
                $fail("La suma total de las ponderaciones de los 4 cortes debe ser 100%. Suma actual: " . $totalPonderacionGeneral . "%");
            }
        };

        return $rules;
    }

    /**
     * Get custom messages for validation errors.
     *
     * @return array
     */
    public function messages()
    {
        return [
            'selectedUnidadCurricularId.required' => 'La Unidad Curricular es obligatoria.',
            'selectedUnidadCurricularId.exists' => 'La Unidad Curricular seleccionada no es válida.',
            'selectedUnidadCurricularId.string' => 'El código de la Unidad Curricular debe ser texto.',
            'selectedUnidadCurricularId.max' => 'El código de la Unidad Curricular no debe exceder los :max caracteres.',
            'cortes.size' => 'Debe haber exactamente :size cortes en la planificación.',
            'cortes.*.detalle_actividades.size' => 'Cada corte debe tener exactamente :size actividades.',
            'cortes.*.detalle_actividades.*.contenido_id.unique' => 'Este contenido ya ha sido seleccionado en otra actividad de este corte o en otro corte.',
            // ... otros mensajes personalizados
        ];
    }
}
