<?php

namespace App\Livewire\Planificacion;

use App\Repositories\Planificacion\PlanificacionCreateRepo;
use Illuminate\Support\{Collection, Facades\Auth, Facades\DB, Facades\Gate, Str};
use Livewire\Component;
use Carbon\Carbon;

class CreatePlanificacion extends Component
{
    public $docente_id, $docenteNombre, $id_profesor_asignado, $proposito;
    public Collection $tecnica, $recursosMaestros, $evaluaciones, $bibliografiasMaestras, $asignaciones;
    public array $unidades = [];
    public array $temasPorUnidad = [];
    protected $planificacionRepository;

    // public array $bibliografias = [['bibliografia_id' => '']]; // Moved to unit level

    public Collection $contenidosPorTema;
    public Collection $todosLosContenidos;
    public Collection $todosLosObjetivos;
    
    public $formasParticipacion = [];
    
    // Modal properties
    public $showObjetivoModal = false;
    public $newObjetivoNombre = '';
    public $selectedTemaIdForObjetivo = null;

    protected $listeners = [
        'itemCreated' => 'refreshMasterLists',
    ];

    public function __construct()
    {
        $this->planificacionRepository = new PlanificacionCreateRepo();
    }

    public function mount()
    {
        $this->docente_id = Auth::id();
        // Inicializar colecciones vacías para evitar errores de null
        $this->asignaciones = collect();
        $this->temasPorUnidad = [];
        $this->contenidosPorTema = collect();
        $this->todosLosContenidos = collect();
        $this->todosLosObjetivos = collect();

        $this->loadInitialData();
        $this->verifyDocenteRole();
        $this->inicializarUnidades();
    }

    public function updatedIdProfesorAsignado($value)
    {
        if ($value) {
            // Buscar la asignación seleccionada para obtener el ID de la unidad curricular
            $asignacion = $this->asignaciones->firstWhere('id_detalle_profesor_asignado', $value);

            if ($asignacion) {
                // Obtener ID de unidad y sección desde la base de datos para asegurar integridad
                $detalle = DB::table('detalle_profesor_asignado')->where('id_detalle_profesor_asignado', $value)->first();
                if ($detalle) {
                    // 1. Cargar TEMAS agrupados por unidad_tema (1, 2, 3, 4)
                    $todosLosTemas = $this->planificacionRepository->select_temas_por_unidad($detalle->id_unidad_curricular);

                    $this->temasPorUnidad = [];
                    foreach (range(1, 4) as $num) {
                        $this->temasPorUnidad[$num] = $todosLosTemas->where('unidad_tema', (string) $num)->values();
                    }

                    // 2. Cargar TODOS los CONTENIDOS de la unidad curricular
                    // Se usarán para filtrar opciones cuando se seleccione un tema
                    $this->todosLosContenidos = $this->planificacionRepository->select_contenidos($detalle->id_unidad_curricular);

                    // 3. Cargar TODOS los OBJETIVOS de la unidad curricular
                    $this->todosLosObjetivos = $this->planificacionRepository->select_objetivos($detalle->id_unidad_curricular);

                    // Obtener propósito de la unidad curricular
                    $unidad = DB::table('unidad_curricular')->where('id_unidad_curricular', $detalle->id_unidad_curricular)->first();
                    if ($unidad) {
                        $this->proposito = $unidad->proposito_unidad_curricular;
                    }
                }
            }
        } else {
            $this->temasPorUnidad = [];
            $this->todosLosContenidos = collect();
            $this->todosLosObjetivos = collect();
            $this->proposito = '';
        }

        // Reiniciar los contenidos seleccionados en las unidades porque cambiaron las opciones disponibles
        $this->inicializarUnidades();
    }

    protected function loadInitialData()
    {
        $this->tecnica = $this->planificacionRepository->select_tecnica();
        $this->evaluaciones = $this->planificacionRepository->select_evaluaciones();
        $this->recursosMaestros = $this->planificacionRepository->select_recursos();
        $this->bibliografiasMaestras = $this->planificacionRepository->select_bibliografias();

        // Cargar asignaciones: Si es coordinador ve todas, si es docente solo las suyas
        if (Gate::allows('is-coordinador')) {
            $this->asignaciones = $this->planificacionRepository->getAsignacionesDocente();
        } else {
            $this->asignaciones = $this->planificacionRepository->getAsignacionesDocente($this->docente_id);
        }
    }

    public function refreshMasterLists($data)
    {
        switch ($data['tableName']) {
            case 'recurso':
                $this->recursosMaestros = $this->planificacionRepository->select_recursos();
                break;
            case 'tecnica':
                $this->tecnica = $this->planificacionRepository->select_tecnica();
                break;
            case 'evaluacion':
                $this->evaluaciones = $this->planificacionRepository->select_evaluaciones();
                break;
            case 'bibliografia':
                $this->bibliografiasMaestras = $this->planificacionRepository->select_bibliografias();
                break;
        }
    }

    protected function verifyDocenteRole()
    {
        // Allow both Coordinador (1) and Docente (2)
        if (
            Auth::check() && (
                DB::table('usuario_rol')->where('id_users', Auth::id())->where('id_rol', 1)->exists() ||
                DB::table('usuario_rol')->where('id_users', Auth::id())->where('id_rol', 2)->exists()
            )
        ) {
            $this->docenteNombre = Auth::user()->name . ' ' . Auth::user()->apellido;
        } else {
            $this->dispatch('mostrar-mensaje', ['tipo' => 'error', 'mensaje' => 'Acceso denegado.']);
        }
    }

    protected function inicializarUnidades()
    {
        foreach (range(0, 3) as $index) {
            $this->unidades[$index] = $this->createUnidadTemplate($index + 1);
        }
    }

    public function rules()
    {
        $rules = [
            'id_profesor_asignado' => 'required|exists:detalle_profesor_asignado,id_detalle_profesor_asignado',
        ];



        foreach ($this->unidades as $index => $unidad) {
            // Validación para estrategias
            foreach ($unidad['estrategias'] as $estIndex => $estrategia) {
                $rules["unidades.$index.estrategias.$estIndex.tema_id"] = 'required|exists:tema_unidad,id_tema_unidad';
                $rules["unidades.$index.estrategias.$estIndex.actividad"] = 'required|string|min:5';
                
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
                $fechaEvaluacionRules = ['required', 'date'];

                $rules["unidades.$index.evaluaciones.$evaluacionIndex.fecha_evaluacion"] = $fechaEvaluacionRules;
                $rules["unidades.$index.evaluaciones.$evaluacionIndex.evaluacion_id"] = 'required|exists:evaluacion,id_evaluacion';
                $rules["unidades.$index.evaluaciones.$evaluacionIndex.tecnica_id"] = 'required|exists:tecnica_evaluacion,id_tecnica';
                $rules["unidades.$index.evaluaciones.$evaluacionIndex.ponderacion"] = [
                    'bail',
                    'required',
                    'integer',
                    'min:5',
                    'max:25',
                    function ($attribute, $value, $fail) use ($index, $unidad, $evaluacionIndex) {
                        $totalEvaluaciones = count($unidad['evaluaciones']);
                        if ($totalEvaluaciones === 1 && (int)$value !== 25) {
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
                
                // Validate 'integrantes' only if forma_participacion is GRUPAL (2)
                if (isset($evaluacion['forma_participacion']) && $evaluacion['forma_participacion'] == '2') {
                    $rules["unidades.$index.evaluaciones.$evaluacionIndex.integrantes"] = 'required|integer|min:2|max:10';
                }
            }
            
            // Validación para bibliografías
            foreach ($unidad['bibliografias'] as $bibIndex => $biblio) {
                $rules["unidades.$index.bibliografias.$bibIndex.bibliografia_id"] = 'required|exists:bibliografia,id_bibliografia';
            }

            $rules["unidades.$index.indicadores_logro"] = 'required|string|min:5';


            $rules["unidades.$index.total_ponderacion_check"] = [
                function ($attribute, $value, $fail) use ($index) {
                    $total = $this->getTotalPonderacionForUnidad($index);
                    if ($total != 25) {
                        $fail("La suma total de ponderaciones en la Unidad " . ($index + 1) . " debe ser exactamente 25% (actual: {$total}%)");
                    }
                }
            ];
        }

        return $rules;
    }

    public function messages()
    {
        $messages = [
            'unidades.*.indicadores_logro.required' => 'Los indicadores de logro son obligatorios.',
            'unidades.*.indicadores_logro.min' => 'Los indicadores de logro deben tener al menos 5 caracteres.',
        ];

        $messages['id_profesor_asignado.required'] = 'Debe seleccionar una Unidad Curricular.';
        $messages['id_profesor_asignado.exists'] = 'La asignación seleccionada no es válida.';

        // Mensajes personalizados para arrays anidados
        $messages['unidades.*.recursos.*.recurso_id.required'] = 'Debe seleccionar un recurso.';

        $messages['unidades.*.objetivos.*.objetivo_id.required'] = 'Debe seleccionar un objetivo.';
        $messages['unidades.*.objetivos.*.contenidos.*.contenido_id.required'] = 'Debe seleccionar un contenido.';

        $messages['unidades.*.estrategias.*.tema_id.required'] = 'Debe seleccionar un tema para la estrategia.';
        $messages['unidades.*.estrategias.*.actividad.required'] = 'La descripción de la actividad es obligatoria.';
        $messages['unidades.*.estrategias.*.actividad.min'] = 'La actividad debe tener al menos 5 caracteres.';
        $messages['unidades.*.estrategias.*.recursos.*.recurso_id.required'] = 'Debe seleccionar un recurso.';

        $messages['unidades.*.evaluaciones.*.fecha_evaluacion.required'] = 'La fecha de evaluación es obligatoria.';
        $messages['unidades.*.evaluaciones.*.fecha_evaluacion.date'] = 'La fecha de evaluación no es válida.';
        $messages['unidades.*.evaluaciones.*.evaluacion_id.required'] = 'Debe seleccionar el tipo de evaluación.';
        $messages['unidades.*.evaluaciones.*.tecnica_id.required'] = 'Debe seleccionar una técnica de evaluación.';
        $messages['unidades.*.evaluaciones.*.ponderacion.required'] = 'La ponderación es obligatoria.';
        $messages['unidades.*.evaluaciones.*.ponderacion.integer'] = 'La ponderación debe ser un número entero.';
        $messages['unidades.*.evaluaciones.*.ponderacion.min'] = 'La ponderación mínima es 5%.';
        $messages['unidades.*.evaluaciones.*.ponderacion.max'] = 'La ponderación máxima es 25%.';
        $messages['unidades.*.evaluaciones.*.integrantes.required'] = 'Debe indicar el número de integrantes para evaluaciones grupales.';
        $messages['unidades.*.evaluaciones.*.integrantes.min'] = 'El grupo debe tener al menos 2 integrantes.';
        $messages['unidades.*.evaluaciones.*.integrantes.max'] = 'El grupo no puede exceder los 10 integrantes.';
        $messages['unidades.*.evaluaciones.*.forma_participacion.required'] = 'Debe seleccionar una forma de participación.';
        $messages['unidades.*.evaluaciones.*.forma_participacion.in'] = 'La forma de participación seleccionada no es válida.';
        $messages['unidades.*.bibliografias.*.bibliografia_id.required'] = 'Debe seleccionar una referencia bibliográfica.';


        // REMOVED GLOBAL BIBLIOGRAPHY MESSAGES
        // $messages['bibliografias.*.bibliografia_id.required'] = 'Debe seleccionar una referencia bibliográfica.';
        // $messages['bibliografias.*.bibliografia_id.exists'] = 'La referencia bibliográfica seleccionada no es válida.';

        // Mensajes genéricos de respaldo
        $messages['*.required'] = 'El campo es obligatorio.';
        $messages['*.min'] = 'El campo debe tener al menos :min caracteres.';
        $messages['*.numeric'] = 'El campo debe ser un número.';
        $messages['*.in'] = 'El valor seleccionado para el campo no es válido.';
        $messages['*.exists'] = 'El valor seleccionado no existe en la base de datos.';

        return $messages;
    }

    public function updated($propertyName)
    {
        $this->validateOnly($propertyName);
    }

    protected function createUnidadTemplate($numero)
    {
        return [
            'numero' => $numero,
            'objetivos' => [[
                'tema_id' => '',
                'objetivo_id' => '',
                'contenidos' => [['contenido_id' => '']]
            ]],
            'estrategias' => [['tema_id' => '', 'actividad' => '', 'recursos' => [['recurso_id' => '']]]], 
            'evaluaciones' => [['fecha_evaluacion' => '', 'evaluacion_id' => '', 'ponderacion' => 5, 'tecnica_id' => '', 'forma_participacion' => '', 'integrantes' => null]],
            'bibliografias' => [['bibliografia_id' => '']],
            'indicadores_logro' => ''
        ];
    }

    public function addItem($unidadIndex, $arrayName, $parentIndex = null)
    {
        if ($arrayName === 'bibliografias') {
             // Add bibliography to unit
             $this->unidades[$unidadIndex]['bibliografias'][] = ['bibliografia_id' => ''];
        } elseif ($arrayName === 'objetivos') {
             // Add new objective block
             $this->unidades[$unidadIndex]['objetivos'][] = [
                'tema_id' => '',
                'objetivo_id' => '',
                'contenidos' => [['contenido_id' => '']]
            ];
        } elseif ($arrayName === 'contenidos') {
             // Add content to specific objective
             $this->unidades[$unidadIndex]['objetivos'][$parentIndex]['contenidos'][] = ['contenido_id' => ''];

        } elseif ($arrayName === 'estrategia_recursos') {
             // Add resource to specific strategy
             // $parentIndex is the strategy index
             $this->unidades[$unidadIndex]['estrategias'][$parentIndex]['recursos'][] = ['recurso_id' => ''];

        } else {
             // Fallback for evaluations
              $defaultTemplates = [
                'evaluaciones' => [
                    'fecha_evaluacion' => '',
                    'evaluacion_id' => '',
                    'ponderacion' => 0,
                    'tecnica_id' => '',
                    'forma_participacion' => '',
                    'integrantes' => null
                ],
                'estrategias' => ['tema_id' => '', 'actividad' => '', 'recursos' => [['recurso_id' => '']]],
                // 'bibliografias' => ['bibliografia_id' => ''] // This was for global, now handled above
            ];
            if (isset($defaultTemplates[$arrayName])) {
                $this->unidades[$unidadIndex][$arrayName][] = $defaultTemplates[$arrayName];
            }
        }
    }

    public function removeItem($unidadIndex, $arrayName, $itemIndex, $parentIndex = null)
    {
        // $unidadIndex is ignored for bibliografias if it was global, but now it is unit-based.
        // Wait, original signature was removeItem($unidadIndex, $arrayName, $itemIndex) for unidad items
        // and removeItem(null, 'bibliografias', index) for global.
        
        if ($arrayName === 'bibliografias') {
             if (isset($this->unidades[$unidadIndex]['bibliografias'][$itemIndex])) {
                unset($this->unidades[$unidadIndex]['bibliografias'][$itemIndex]);
                $this->unidades[$unidadIndex]['bibliografias'] = array_values($this->unidades[$unidadIndex]['bibliografias']);
            }
        } elseif ($arrayName === 'objetivos') {
            // Remove objective block
            if (isset($this->unidades[$unidadIndex]['objetivos'][$itemIndex])) {
                unset($this->unidades[$unidadIndex]['objetivos'][$itemIndex]);
                $this->unidades[$unidadIndex]['objetivos'] = array_values($this->unidades[$unidadIndex]['objetivos']);
            }
        } elseif ($arrayName === 'contenidos') {
            // Remove content from objective
             if (isset($this->unidades[$unidadIndex]['objetivos'][$parentIndex]['contenidos'][$itemIndex])) {
                unset($this->unidades[$unidadIndex]['objetivos'][$parentIndex]['contenidos'][$itemIndex]);
                $this->unidades[$unidadIndex]['objetivos'][$parentIndex]['contenidos'] = array_values($this->unidades[$unidadIndex]['objetivos'][$parentIndex]['contenidos']);
            }
        } elseif ($arrayName === 'estrategia_recursos') {
            // Remove resource from strategy
            if (isset($this->unidades[$unidadIndex]['estrategias'][$parentIndex]['recursos'][$itemIndex])) {
                unset($this->unidades[$unidadIndex]['estrategias'][$parentIndex]['recursos'][$itemIndex]);
                $this->unidades[$unidadIndex]['estrategias'][$parentIndex]['recursos'] = array_values($this->unidades[$unidadIndex]['estrategias'][$parentIndex]['recursos']);
            }
        } else {
            // Remove resource, evaluation, or strategy
            if (isset($this->unidades[$unidadIndex][$arrayName][$itemIndex])) {
                unset($this->unidades[$unidadIndex][$arrayName][$itemIndex]);
                $this->unidades[$unidadIndex][$arrayName] = array_values($this->unidades[$unidadIndex][$arrayName]);
            }
        }
    }

    public function getTotalPonderacionForUnidad($unidadIndex)
    {
        return collect($this->unidades[$unidadIndex]['evaluaciones'])
            ->sum(fn($e) => (float) ($e['ponderacion'] ?? 0));
    }

    public function render()
    {
        return view('livewire.pages.planificacion.create-planificacion', [
            'weekDays' => ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'], // No longer used but kept for compatibility
            'timeSlots' => $this->generateTimeSlots()
        ]);
    }

    protected function generateTimeSlots()
    {
        return collect(range(8, 18))->map(fn($h) => sprintf('%02d:00', $h));
    }

    public function savePlanificacion()
    {
        $this->validate();

        DB::beginTransaction();

        try {
            $planificacionData = [
                'id_profesor_asignado' => $this->id_profesor_asignado,
                'fecha_creacion' => now(),
                'estatus' => '2', // Pendiente por defecto
            ];

            $planificacionId = DB::table('planificacion')->insertGetId($planificacionData);

            // Nota: Aquí se elimina la actualización del propósito en unidad curricular
            // ya que ahora seleccionamos una asignación establecida.

            foreach ($this->unidades as $unidad) {
                $unidadId = DB::table('unidad_corte')->insertGetId([
                    'id_planificacion' => $planificacionId,
                    'numero_unidad_corte' => $unidad['numero'],
                    'indicador_logro_unidad_corte' => $unidad['indicadores_logro'] ?? null,
                    'fecha_creacion' => now(),
                    'estatus' => '2',
                ]);

                foreach ($unidad['objetivos'] as $objetivo) {
                    foreach ($objetivo['contenidos'] as $contenido) {
                         if (!empty($contenido['contenido_id'])) {
                            DB::table('detalle_contenido')->insert([
                                'id_unidad_corte' => $unidadId,
                                'id_contenido' => $contenido['contenido_id'],
                                'fecha_creacion' => now(),
                                'estatus' => '1',
                            ]);
                        }
                    }
                }

                foreach ($unidad['estrategias'] as $estrategia) {
                    if (!empty($estrategia['tema_id']) && !empty($estrategia['actividad'])) {
                        
                         $estrategiaId = DB::table('detalle_estrategia')->insertGetId([
                            'id_unidad_corte' => $unidadId,
                            'id_tema_unidad' => $estrategia['tema_id'],
                            'actividad' => $estrategia['actividad'],
                            'fecha_creacion' => now(),
                            'estatus' => '1',
                        ]);

                        foreach ($estrategia['recursos'] as $recurso) {
                            if (!empty($recurso['recurso_id'])) {
                                 DB::table('detalle_estrategia_recurso')->insert([
                                     'id_detalle_estrategia' => $estrategiaId,
                                     'id_recurso' => $recurso['recurso_id'],
                                     'fecha_creacion' => now(),
                                     'estatus' => '1',
                                 ]);
                            }
                        }
                    }
                }

                foreach ($unidad['evaluaciones'] as $evaluacion) {
                    if (!empty($evaluacion['evaluacion_id'])) {
                        DB::table('detalle_evaluacion')->insert([
                            'id_unidad_corte' => $unidadId,
                            'id_evaluacion' => $evaluacion['evaluacion_id'],
                            'id_tecnica' => $evaluacion['tecnica_id'],
                            'id_instrumento' => null, // null for now as per schema
                            'ponderacion_detalle_evaluacion' => $evaluacion['ponderacion'],
                            'integrantes_detalle_evaluacion' => ($evaluacion['forma_participacion'] == '2') ? ($evaluacion['integrantes'] ?? null) : 1, // 1 if individual
                            'fecha_evaluacion_detalle_evaluacion' => $evaluacion['fecha_evaluacion'],
                            'forma_participacion_detalle_evaluacion' => $evaluacion['forma_participacion'],
                            'fecha_creacion' => now(),
                            'estatus' => '2',
                        ]);
                    }
                }

                // Save bibliographies for this unit
                foreach ($unidad['bibliografias'] as $bibliografia) {
                    if (!empty($bibliografia['bibliografia_id'])) {
                        DB::table('detalle_bibliografia')->insert([
                            'id_unidad_corte' => $unidadId,
                            'id_bibliografia' => $bibliografia['bibliografia_id'],
                            'fecha_creacion' => now(),
                            'estatus' => '1',
                        ]);
                    }
                }
            }

            // Removed global bibliography insert loop

            DB::commit();
            $this->dispatch('mostrar-mensaje', ['tipo' => 'exitoso', 'mensaje' => 'Planificación guardada correctamente.']);
            $this->reset(['unidades', 'id_profesor_asignado']);
            $this->inicializarUnidades();
        } catch (\Exception $e) {
            DB::rollBack();
            $this->dispatch('mostrar-mensaje', ['tipo' => 'error', 'mensaje' => 'Error al guardar la planificación: ' . $e->getMessage()]);
        }
    }
    public function openObjetivoModal($temaId)
    {
        if (!$temaId || $temaId === '') {
            $this->dispatch('mostrar-mensaje', ['tipo' => 'error', 'mensaje' => 'Debe seleccionar un tema primero.']);
            return;
        }
        $this->selectedTemaIdForObjetivo = $temaId;
        $this->newObjetivoNombre = '';
        $this->showObjetivoModal = true;
    }

    public function closeObjetivoModal()
    {
        $this->showObjetivoModal = false;
        $this->reset(['newObjetivoNombre', 'selectedTemaIdForObjetivo']);
    }

    public function saveObjetivo()
    {
        $this->validate([
            'newObjetivoNombre' => 'required|min:3|max:255',
            'selectedTemaIdForObjetivo' => 'required|exists:tema_unidad,id_tema_unidad',
        ]);

        try {
            DB::table('objetivo')->insert([
                'titulo_objetivo' => $this->newObjetivoNombre,
                'id_tema_unidad' => $this->selectedTemaIdForObjetivo,
                'estatus' => '1',
                'fecha_creacion' => now(),
            ]);

            // Recargar objetivos
            $detalle = DB::table('detalle_profesor_asignado')->where('id_detalle_profesor_asignado', $this->id_profesor_asignado)->first();
            if ($detalle) {
                // Refresh objectives list
                $this->todosLosObjetivos = $this->planificacionRepository->select_objetivos($detalle->id_unidad_curricular);
            }

            $this->dispatch('mostrar-mensaje', ['tipo' => 'exitoso', 'mensaje' => 'Objetivo creado correctamente.']);
            $this->closeObjetivoModal();
        } catch (\Exception $e) {
            $this->dispatch('mostrar-mensaje', ['tipo' => 'error', 'mensaje' => 'Error al guardar el objetivo: ' . $e->getMessage()]);
        }
    }
}
