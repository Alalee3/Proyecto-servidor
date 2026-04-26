<?php

namespace App\Livewire\Forms\Planificacion;

use Livewire\Form;

class UpdatePlanificacionForm extends Form
{
    public $unidades = [];
    public $lapso_fecha_inicio;
    public $lapso_fecha_fin;
    public $id_lapso_academico;

    public function getTotalPonderacionForUnidad($unidadIndex)
    {
        return collect($this->unidades[$unidadIndex]['evaluaciones'])
            ->sum(fn($e) => (float) ($e['ponderacion'] ?? 0));
    }

    public function rules()
    {
        $rules = [
            'unidades' => 'required|array|min:1',
        ];

        foreach ($this->unidades as $index => $unidad) {
            // Validación para estrategias
            foreach ($unidad['estrategias'] as $estIndex => $estrategia) {
                $rules["unidades.$index.estrategias.$estIndex.tema_id"] = 'nullable|exists:tema_unidad,id_tema_unidad'; // Ajustado porque esquema db usa tecnica_actividad
                $rules["unidades.$index.estrategias.$estIndex.tecnica_actividad_id"] = 'required|exists:tecnica_actividad,id_tecnica_actividad';
                $rules["unidades.$index.estrategias.$estIndex.actividad"] = 'nullable|string|min:5';

                foreach ($estrategia['recursos'] as $recIndex => $recurso) {
                    $rules["unidades.$index.estrategias.$estIndex.recursos.$recIndex.recurso_id"] = 'required|exists:recurso,id_recurso';
                }
            }

            // Validación para objetivos y contenidos
            $contenidoIds = [];
            foreach ($unidad['objetivos'] as $obj) {
                foreach ($obj['contenidos'] as $cont) {
                    $contenidoIds[] = $cont['contenido_id'];
                }
            }

            foreach ($unidad['objetivos'] as $objIndex => $objetivo) {
                $rules["unidades.$index.objetivos.$objIndex.tema_id"] = 'required|exists:tema_unidad,id_tema_unidad';
                $rules["unidades.$index.objetivos.$objIndex.objetivo_id"] = 'required|exists:objetivo,id_objetivo';

                foreach ($objetivo['contenidos'] as $contIndex => $contenido) {
                    $rules["unidades.$index.objetivos.$objIndex.contenidos.$contIndex.contenido_id"] = [
                        'required',
                        'exists:contenido,id_contenido',
                        function ($attribute, $value, $fail) use ($contenidoIds) {
                            if (count(array_keys($contenidoIds, $value)) > 1) {
                                $fail('Este contenido ya fue seleccionado.');
                            }
                        }
                    ];
                }
            }

            // Validación para evaluaciones
            foreach ($unidad['evaluaciones'] as $evaluacionIndex => $evaluacion) {
                $fechaEvaluacionRules = [
                    'required',
                    'date',
                    function ($attribute, $value, $fail) {
                        if ($this->lapso_fecha_inicio && $this->lapso_fecha_fin) {
                            if ($value < $this->lapso_fecha_inicio || $value > $this->lapso_fecha_fin) {
                                $fail("La fecha de evaluación debe estar dentro del lapso académico ({$this->lapso_fecha_inicio} al {$this->lapso_fecha_fin}).");
                            }
                        }

                        if ($this->id_lapso_academico) {
                            $evento = \Illuminate\Support\Facades\DB::table('evento as e')
                                ->where('e.estatus', '!=', '3')
                                ->where(function ($q) use ($value) {
                                    $q->whereDate('e.dia_inicio_evento', '<=', $value)
                                        ->whereDate('e.dia_fin_evento', '>=', $value);
                                })
                                ->select('e.descripcion_evento')
                                ->first();

                            if ($evento) {
                                $fail("No se puede asignar una evaluación en esta fecha debido al evento: {$evento->descripcion_evento}.");
                            }
                        }
                    }
                ];
                $rules["unidades.$index.evaluaciones.$evaluacionIndex.fecha_evaluacion"] = $fechaEvaluacionRules;
                $rules["unidades.$index.evaluaciones.$evaluacionIndex.evaluacion_id"] = 'required|exists:tipo_evaluacion,id_tipo_evaluacion';
                $rules["unidades.$index.evaluaciones.$evaluacionIndex.tecnica_id"] = 'required|exists:tecnica_evaluacion,id_tecnica_evaluacion';
                $rules["unidades.$index.evaluaciones.$evaluacionIndex.ponderacion"] = [
                    'bail',
                    'required',
                    'integer',
                    'min:5',
                    'max:25',
                    function ($attribute, $value, $fail) use ($index, $unidad, $evaluacionIndex) {
                        $totalEvaluaciones = count($unidad['evaluaciones']);
                        if ($totalEvaluaciones === 1 && (int) $value !== 25) {
                            $fail('La única evaluación debe tener exactamente 25% de ponderación.');
                        }
                    },
                    function ($attribute, $value, $fail) use ($index) {
                        $total = $this->getTotalPonderacionForUnidad($index);
                        if ($total > 25) {
                            $fail("La suma total de ponderaciones en la Unidad " . ($index + 1) . " no puede superar el 25% (actual: {$total}%)");
                        }
                    }
                ];

                $rules["unidades.$index.evaluaciones.$evaluacionIndex.forma_participacion"] = 'required|in:1,2';

                if (isset($evaluacion['forma_participacion']) && $evaluacion['forma_participacion'] == '2') {
                    $rules["unidades.$index.evaluaciones.$evaluacionIndex.integrantes"] = 'required|integer|min:2|max:10';
                }
            }

            // Validación para bibliografías
            foreach ($unidad['bibliografias'] as $bibIndex => $biblio) {
                $rules["unidades.$index.bibliografias.$bibIndex.bibliografia_id"] = 'required|exists:bibliografia,id_bibliografia';
            }

            $rules["unidades.$index.indicadores_logro"] = 'nullable|string|min:5';

            if (!empty($unidad['evaluaciones'])) {
                $rules["unidades.$index.total_ponderacion_check"] = [
                    function ($attribute, $value, $fail) use ($index) {
                        $total = $this->getTotalPonderacionForUnidad($index);
                        if ($total != 25) {
                            $fail("La suma total de ponderaciones en la Unidad " . ($index + 1) . " debe ser exactamente 25% (actual: {$total}%)");
                        }
                    }
                ];
            }
        }
        return $rules;
    }

    public function messages()
    {
        return [
            'unidades.required' => 'La planificación debe tener al menos una unidad.',
            'unidades.min' => 'La planificación debe tener al menos una unidad.',
            'unidades.*.estrategias.*.tecnica_actividad_id.required' => 'Debe seleccionar una estrategia.',
            'unidades.*.estrategias.*.recursos.*.recurso_id.required' => 'El recurso es obligatorio.',
            'unidades.*.objetivos.*.tema_id.required' => 'El tema es obligatorio.',
            'unidades.*.objetivos.*.objetivo_id.required' => 'El objetivo es obligatorio.',
            'unidades.*.objetivos.*.contenidos.*.contenido_id.required' => 'El contenido es obligatorio.',
            'unidades.*.evaluaciones.*.fecha_evaluacion.required' => 'La fecha de evaluación es obligatoria.',
            'unidades.*.evaluaciones.*.fecha_evaluacion.date' => 'La fecha de evaluación no es válida.',
            'unidades.*.evaluaciones.*.evaluacion_id.required' => 'El tipo de evaluación es obligatorio.',
            'unidades.*.evaluaciones.*.tecnica_id.required' => 'La técnica de evaluación es obligatoria.',
            'unidades.*.evaluaciones.*.ponderacion.required' => 'La ponderación es obligatoria.',
            'unidades.*.evaluaciones.*.ponderacion.min' => 'La ponderación debe ser al menos 5%.',
            'unidades.*.evaluaciones.*.ponderacion.max' => 'La ponderación máxima es 25%.',
            'unidades.*.evaluaciones.*.forma_participacion.required' => 'La forma de participación es obligatoria.',
            'unidades.*.evaluaciones.*.integrantes.required' => 'Debe indicar el número de integrantes.',
            'unidades.*.bibliografias.*.bibliografia_id.required' => 'La referencia bibliográfica es obligatoria.',
            'unidades.*.indicadores_logro.min' => 'Mínimo 5 caracteres.',
        ];
    }
}
