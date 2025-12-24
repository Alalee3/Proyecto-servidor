<?php

namespace App\Livewire\Planificacion;

use App\Repositories\Planificacion\PlanificacionCreateRepo;
use Illuminate\Support\{Collection, Facades\Auth, Facades\DB, Str};
use Livewire\Component;
use Carbon\Carbon;

class CreatePlanificacion extends Component
{
    public $docente_id, $docenteNombre, $seccion_id, $unidad_codigo, $proposito;
    public Collection $tecnicas, $recursosMaestros, $evaluaciones, $indicadores, $estrategiasMaestras, $contenidosUnidad, $bibliografiasMaestras, $secciones, $unidadesCurriculares;
    public array $cortes = [];
    protected $planificacionRepository;

    public array $bibliografias = [['bibliografia_id' => '']];

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
        $this->loadInitialData();
        $this->verifyDocenteRole();
        $this->inicializarCortes();
    }

    public function updatedUnidadCodigo($value)
    {
        if ($value) {
            $unidad = DB::table('unidades_curriculares')
                ->where('codigo', $value)
                ->first();

            if ($unidad) {
                $this->proposito = $unidad->proposito;
            }
        } else {
            $this->proposito = '';
        }
    }

    protected function loadInitialData()
    {
        $this->tecnicas = $this->planificacionRepository->select_tecnicas();
        $this->evaluaciones = $this->planificacionRepository->select_evaluaciones();
        $this->indicadores = $this->planificacionRepository->select_indicadores();
        $this->recursosMaestros = $this->planificacionRepository->select_recursos();
        $this->estrategiasMaestras = $this->planificacionRepository->select_estrategias();
        $this->bibliografiasMaestras = $this->planificacionRepository->select_bibliografias();
        $this->secciones = $this->planificacionRepository->select_secciones();
        $this->unidadesCurriculares = $this->planificacionRepository->select_unidades_curriculares();
        $this->contenidosUnidad = $this->planificacionRepository->select_contenidos(); // Fetch all contents
    }

    public function refreshMasterLists($data)
    {
        switch ($data['tableName']) {
            case 'recursos':
                $this->recursosMaestros = $this->planificacionRepository->select_recursos();
                break;
            case 'estrategias_pedagogicas':
                $this->estrategiasMaestras = $this->planificacionRepository->select_estrategias();
                break;
            case 'tecnicas':
                $this->tecnicas = $this->planificacionRepository->select_tecnicas();
                break;
            case 'evaluaciones':
                $this->evaluaciones = $this->planificacionRepository->select_evaluaciones();
                break;
            case 'indicadores_logros':
                $this->indicadores = $this->planificacionRepository->select_indicadores();
                break;
            case 'bibliografias':
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
            $this->docenteNombre = Auth::user()->name;
        } else {
            $this->dispatch('mostrar-mensaje', ['tipo' => 'error', 'mensaje' => 'Acceso denegado.']);
        }
    }

    protected function inicializarCortes()
    {
        foreach (range(0, 3) as $index) {
            $this->cortes[$index] = $this->createCorteTemplate($index + 1);
        }
    }

    public function rules()
    {
        $rules = [
            'seccion_id' => 'required|exists:secciones,seccion_id',
            'unidad_codigo' => 'required|exists:unidades_curriculares,codigo',
            'proposito' => 'required|string|min:10',
        ];

        // INDICADORES DE LOGRO
        $allIndicadorIds = [];
        foreach ($this->cortes as $corte) {
            if (isset($corte['contenidos']) && is_array($corte['contenidos'])) {
                foreach ($corte['contenidos'] as $contenido) {
                    if (isset($contenido['indicadores_logros']) && is_array($contenido['indicadores_logros'])) {
                        $allIndicadorIds = array_merge($allIndicadorIds, array_column($contenido['indicadores_logros'], 'indicador_id'));
                    }
                }
            }
        }
        $allIndicadorIds = array_filter($allIndicadorIds);

        // Reglas para bibliografías
        foreach ($this->bibliografias as $biblioIndex => $bibliografia) {
            $rules["bibliografias.$biblioIndex.bibliografia_id"] = [
                'required',
                'exists:bibliografias,bibliografia_id',
                function ($attribute, $value, $fail) use ($biblioIndex) {
                    $allBiblioIds = collect($this->bibliografias)->pluck('bibliografia_id')->filter()->all();
                    $occurrences = array_keys($allBiblioIds, $value);
                    if (count($occurrences) > 1) {
                        $fail('Esta bibliografía ya ha sido seleccionada.');
                    }
                },
            ];
        }

        foreach ($this->cortes as $index => $corte) {
            // Validación para recursos
            $recursoIds = array_column($corte['recursos'], 'recurso_id');
            foreach ($corte['recursos'] as $recursoIndex => $recurso) {
                $rules["cortes.$index.recursos.$recursoIndex.recurso_id"] = [
                    'required',
                    function ($attribute, $value, $fail) use ($recursoIds, $recursoIndex) {
                        if (count(array_keys($recursoIds, $value)) > 1) {
                            $fail('Este recurso ya fue seleccionado en este corte.');
                        }
                    }
                ];
            }

            // Validación para estrategias
            $estrategiaIds = array_column($corte['estrategias'], 'estrategia_id');
            foreach ($corte['estrategias'] as $estrategiaIndex => $estrategia) {
                $rules["cortes.$index.estrategias.$estrategiaIndex.estrategia_id"] = [
                    'required',
                    function ($attribute, $value, $fail) use ($estrategiaIds, $estrategiaIndex) {
                        if (count(array_keys($estrategiaIds, $value)) > 1) {
                            $fail('Esta estrategia ya fue seleccionada en este corte.');
                        }
                    }
                ];
            }

            // Validación para contenidos
            $contenidoIds = array_column($this->cortes, 'contenidos');
            $contenidoIds = array_merge(...array_map(function ($corte) {
                return array_column($corte['contenidos'], 'contenido_id');
            }, $this->cortes));
            foreach ($corte['contenidos'] as $contenidoIndex => $contenido) {
                $rules["cortes.$index.contenidos.$contenidoIndex.indicadores_logros"] = 'required|array|min:1';
                $rules["cortes.$index.contenidos.$contenidoIndex.contenido_id"] = [
                    'required',
                    function ($attribute, $value, $fail) use ($contenidoIds, $contenidoIndex) {
                        if (count(array_keys($contenidoIds, $value)) > 1) {
                            $fail('Este contenido ya fue seleccionado.');
                        }
                    }
                ];

                if (isset($contenido['indicadores_logros']) && is_array($contenido['indicadores_logros'])) {
                    foreach ($contenido['indicadores_logros'] as $indicadorIndex => $indicador) {
                        $rules["cortes.$index.contenidos.$contenidoIndex.indicadores_logros.$indicadorIndex.indicador_id"] = [
                            'required',
                            'exists:indicadores_logros,indicador_id',
                            function ($attribute, $value, $fail) use ($allIndicadorIds) {
                                if ($value && count(array_keys($allIndicadorIds, (string) $value)) > 1) {
                                    $fail('Este indicador de logro ya ha sido seleccionado en el formulario.');
                                }
                            },
                        ];
                    }
                }
            }

            // Validación para evaluaciones
            foreach ($corte['evaluaciones'] as $evaluacionIndex => $evaluacion) {
                $fechaEvaluacionRules = ['required', 'date'];
                // Removed date range validation as lapso dates are gone

                $rules["cortes.$index.evaluaciones.$evaluacionIndex.fecha_evaluacion"] = $fechaEvaluacionRules;
                $rules["cortes.$index.evaluaciones.$evaluacionIndex.evaluacion_id"] = 'required';
                $rules["cortes.$index.evaluaciones.$evaluacionIndex.tecnica_id"] = 'required';

                $rules["cortes.$index.evaluaciones.$evaluacionIndex.ponderacion"] = [
                    'required',
                    'numeric',
                    function ($attribute, $value, $fail) use ($index, $corte, $evaluacionIndex) {
                        $totalEvaluaciones = count($corte['evaluaciones']);
                        $sumaActual = $this->getTotalPonderacionForCorte($index);

                        if ($totalEvaluaciones === 1 && $value != 25) {
                            $fail('La única evaluación debe tener 25% de ponderación');
                        } elseif ($totalEvaluaciones > 1) {
                            if ($value < 5) {
                                $fail('La ponderación mínima por evaluación es 5%');
                            }
                            $sumaSinActual = $sumaActual - ($corte['evaluaciones'][$evaluacionIndex]['ponderacion'] ?? 0);
                            $maxPermitido = 25 - $sumaSinActual;

                            if ($value > $maxPermitido) {
                                $fail("La ponderación máxima permitida para esta evaluación es $maxPermitido% (Suma actual sin este campo: $sumaSinActual%)");
                            }
                        }
                    }
                ];

                $rules["cortes.$index.evaluaciones.$evaluacionIndex.forma_participacion"] = 'required|in:1,2,3';
            }

            $rules["cortes.$index.evaluaciones.$evaluacionIndex.ponderacion"][] = function ($attribute, $value, $fail) use ($index) {
                $total = $this->getTotalPonderacionForCorte($index);
                if ($total < 25) {
                    $fail("La suma total de ponderaciones en el Corte {$index} debe ser al menos 25% (actual: {$total}%)");
                } elseif ($total > 25) {
                    $fail("La suma total de ponderaciones en el Corte {$index} debe ser exactamente 25% (actual: {$total}%)");
                }
            };
        }

        return $rules;
    }

    public function messages()
    {
        $messages = [];

        $messages['seccion_id.required'] = 'Debe seleccionar una sección.';
        $messages['seccion_id.exists'] = 'La sección seleccionada no es válida.';
        $messages['unidad_codigo.required'] = 'Debe seleccionar una unidad curricular.';
        $messages['unidad_codigo.exists'] = 'La unidad curricular seleccionada no es válida.';
        $messages['proposito.required'] = 'El propósito de la unidad curricular es obligatorio.';
        $messages['proposito.min'] = 'El propósito debe tener al menos 10 caracteres.';

        $messages['*.required'] = 'El campo es obligatorio.';
        $messages['*.min'] = 'El campo debe tener al menos :min caracteres.';
        $messages['*.numeric'] = 'El campo debe ser un número.';
        $messages['*.in'] = 'El valor seleccionado para el campo no es válido.';

        foreach ($this->bibliografias as $biblioIndex => $bibliografia) {
            $messages["bibliografias.$biblioIndex.bibliografia_id.required"] = 'Debe seleccionar una bibliografía.';
            $messages["bibliografias.$biblioIndex.bibliografia_id.exists"] = 'La bibliografía seleccionada no es valida.';
        }

        foreach ($this->cortes as $index => $corte) {
            $messages["cortes.$index.recursos.*.recurso_id.required"] = 'Debe seleccionar un recurso para cada fila.';
            $messages["cortes.$index.estrategias.*.estrategia_id.required"] = 'Debe seleccionar una estrategia para cada fila.';
            $messages["cortes.$index.contenidos.*.contenido_id.required"] = 'Debe seleccionar un contenido para cada fila.';

            foreach ($corte['contenidos'] as $contenidoIndex => $contenido) {
                $messages["cortes.$index.contenidos.$contenidoIndex.indicadores_logros.required"] = 'Debe añadir al menos un indicador de logro para el contenido #' . ($contenidoIndex + 1) . ' del Corte #' . ($index + 1) . '.';
                $messages["cortes.$index.contenidos.$contenidoIndex.indicadores_logros.min"] = 'El contenido #' . ($contenidoIndex + 1) . ' del Corte #' . ($index + 1) . ' debe tener al menos :min indicador de logro.';
                $messages["cortes.$index.contenidos.$contenidoIndex.indicadores_logros.*.indicador_id.required"] = 'Debe seleccionar un indicador de logro para el contenido.';
            }

            $messages["cortes.$index.evaluaciones.*.fecha_evaluacion.required"] = 'La fecha de la evaluación es obligatoria.';
            $messages["cortes.$index.evaluaciones.*.fecha_evaluacion.date"] = 'La fecha de la evaluación debe ser una fecha válida.';
            $messages["cortes.$index.evaluaciones.*.evaluacion_id.required"] = 'La evaluación es obligatoria.';
            $messages["cortes.$index.evaluaciones.*.tecnica_id.required"] = 'Debe seleccionar una técnica de evaluación.';
            $messages["cortes.$index.evaluaciones.*.ponderacion.required"] = 'La ponderación de la evaluación es obligatoria.';
            $messages["cortes.$index.evaluaciones.*.ponderacion.numeric"] = 'La ponderación de la evaluación debe ser un número.';
            $messages["cortes.$index.evaluaciones.*.forma_participacion.required"] = 'La forma de participación es obligatoria.';
            $messages["cortes.$index.evaluaciones.*.forma_participacion.in"] = 'La forma de participación seleccionada no es válida.';

            $messages["cortes.$index.evaluaciones.required"] = 'Debe añadir al menos una evaluación para el Corte ' . ($index + 1) . '.';
            $messages["cortes.$index.evaluaciones.min"] = 'Debe añadir al menos una evaluación para el Corte ' . ($index + 1) . '.';
        }

        return $messages;
    }

    public function updated($propertyName)
    {
        $this->validateOnly($propertyName);
    }

    protected function createCorteTemplate($numero)
    {
        return [
            'numero' => $numero,
            'contenidos' => [['contenido_id' => '', 'indicadores_logros' => [['indicador_id' => '']]]],
            'recursos' => [['recurso_id' => '']],
            'estrategias' => [['estrategia_id' => '']],
            'evaluaciones' => [['fecha_evaluacion' => '', 'evaluacion_id' => '', 'ponderacion' => 0, 'tecnica_id' => '', 'forma_participacion' => '']]
        ];
    }

    public function addItem($corteIndex, $arrayName, $contenidoIndex = null)
    {
        $defaultTemplates = [
            'contenidos' => ['contenido_id' => '', 'indicadores_logros' => [['indicador_id' => '']]],
            'recursos' => ['recurso_id' => ''],
            'estrategias' => ['estrategia_id' => ''],
            'evaluaciones' => [
                'fecha_evaluacion' => '',
                'evaluacion_id' => '',
                'ponderacion' => 0,
                'tecnica_id' => '',
                'forma_participacion' => ''
            ],
            'indicadores_logros' => ['indicador_id' => ''],
            'bibliografias' => ['bibliografia_id' => ''],
        ];

        $template = $defaultTemplates[$arrayName] ?? [];

        if ($arrayName === 'bibliografias') {
            $this->bibliografias[] = $template;
        } elseif ($arrayName === 'indicadores_logros' && $contenidoIndex !== null) {
            if (isset($this->cortes[$corteIndex]['contenidos'][$contenidoIndex])) {
                $this->cortes[$corteIndex]['contenidos'][$contenidoIndex]['indicadores_logros'][] = $template;
            }
        } else {
            $this->cortes[$corteIndex][$arrayName][] = $template;
        }
    }

    public function removeItem($corteIndex, $arrayName, $itemIndex, $contenidoIndex = null)
    {
        if ($arrayName === 'contenidos') {
            unset($this->cortes[$corteIndex][$arrayName][$itemIndex]);
            $this->cortes[$corteIndex][$arrayName] = array_values($this->cortes[$corteIndex][$arrayName]);
        } elseif ($arrayName === 'indicadores_logros' && $contenidoIndex !== null) {
            if (isset($this->cortes[$corteIndex]['contenidos'][$contenidoIndex]['indicadores_logros'][$itemIndex])) {
                unset($this->cortes[$corteIndex]['contenidos'][$contenidoIndex]['indicadores_logros'][$itemIndex]);
                $this->cortes[$corteIndex]['contenidos'][$contenidoIndex]['indicadores_logros'] = array_values($this->cortes[$corteIndex]['contenidos'][$contenidoIndex]['indicadores_logros']);
            }
        } elseif ($arrayName === 'bibliografias') {
            if (isset($this->bibliografias[$itemIndex])) {
                unset($this->bibliografias[$itemIndex]);
                $this->bibliografias = array_values($this->bibliografias);
            }
        } else {
            unset($this->cortes[$corteIndex][$arrayName][$itemIndex]);
            $this->cortes[$corteIndex][$arrayName] = array_values($this->cortes[$corteIndex][$arrayName]);
        }
    }

    public function getTotalPonderacionForCorte($corteIndex)
    {
        return collect($this->cortes[$corteIndex]['evaluaciones'])
            ->sum(fn($e) => (float) ($e['ponderacion'] ?? 0));
    }

    public function render()
    {
        return view('livewire.planificacion.create-planificacion', [
            'weekDays' => ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'],
            'timeSlots' => $this->generateTimeSlots()
        ]);
    }

    protected function generateTimeSlots()
    {
        return collect(range(8, 18))->map(fn($h) => sprintf('%02d:00', $h));
    }

    public function savePlanificacion()
    {
        try {
            $this->validate();
        } catch (\Illuminate\Validation\ValidationException $e) {
            $this->dispatch('mostrar-mensaje', [
                'tipo' => 'error',
                'mensaje' => 'Por favor, corrige los errores en los campos marcados.'
            ]);
            throw $e;
        }

        DB::beginTransaction();

        try {
            $planificacionData = [
                'docente_id' => $this->docente_id,
                'seccion_id' => $this->seccion_id,
                'unidad_codigo' => $this->unidad_codigo,
                'fecha_creacion' => now(),
            ];

            $planificacionId = DB::table('planificacion')->insertGetId($planificacionData);

            // Actualizar el propósito en la unidad curricular
            DB::table('unidades_curriculares')
                ->where('codigo', $this->unidad_codigo)
                ->update(['proposito' => $this->proposito]);

            foreach ($this->cortes as $corte) {
                $detalleActividadData = [
                    'corte' => $corte['numero'],
                ];
                $detalleActividadId = DB::table('detalle_actividad')->insertGetId($detalleActividadData);

                DB::table('detalle_planificacion')->insert([
                    'planificacion_id' => $planificacionId,
                    'detalle_id' => $detalleActividadId,
                ]);

                foreach ($corte['recursos'] as $recurso) {
                    if (!empty($recurso['recurso_id'])) {
                        DB::table('detalle_recursos')->insert([
                            'detalle_id' => $detalleActividadId,
                            'recurso_id' => $recurso['recurso_id'],
                        ]);
                    }
                }

                foreach ($corte['estrategias'] as $estrategia) {
                    if (!empty($estrategia['estrategia_id'])) {
                        DB::table('detalle_estrategias')->insert([
                            'detalle_id' => $detalleActividadId,
                            'estrategia_id' => $estrategia['estrategia_id'],
                        ]);
                    }
                }

                foreach ($corte['contenidos'] as $contenido) {
                    if (!empty($contenido['contenido_id'])) {
                        $planificacionContenidoId = DB::table('detalle_contenidos')->insertGetId([
                            'detalle_id' => $detalleActividadId,
                            'contenido_id' => $contenido['contenido_id'],
                        ]);

                        foreach ($contenido['indicadores_logros'] as $indicador) {
                            if (!empty($indicador['indicador_id'])) {
                                DB::table('contenido_indicadores')->insert([
                                    'detalle_contenido_id' => $planificacionContenidoId,
                                    'indicador_id' => $indicador['indicador_id'],
                                ]);
                            }
                        }
                    }
                }

                foreach ($corte['evaluaciones'] as $evaluacion) {
                    if (!empty($evaluacion['evaluacion_id'])) {
                        DB::table('detalle_evaluacion')->insert([
                            'detalle_id' => $detalleActividadId,
                            'evaluacion_id' => $evaluacion['evaluacion_id'],
                            'tecnica_id' => $evaluacion['tecnica_id'],
                            'ponderacion' => $evaluacion['ponderacion'],
                            'fecha_evaluacion' => $evaluacion['fecha_evaluacion'],
                            'forma_participacion' => $evaluacion['forma_participacion'],
                        ]);
                    }
                }
            }

            foreach ($this->bibliografias as $bibliografia) {
                if (!empty($bibliografia['bibliografia_id'])) {
                    DB::table('detalle_bibliografia')->insert([
                        'planificacion_id' => $planificacionId,
                        'bibliografia_id' => $bibliografia['bibliografia_id'],
                    ]);
                }
            }

            DB::commit();
            $this->dispatch('mostrar-mensaje', ['tipo' => 'exitoso', 'mensaje' => 'Planificación guardada correctamente.']);
            $this->reset(['cortes', 'bibliografias', 'seccion_id', 'unidad_codigo']);
            $this->inicializarCortes();
        } catch (\Exception $e) {
            DB::rollBack();
            $this->dispatch('mostrar-mensaje', ['tipo' => 'error', 'mensaje' => 'Error al guardar la planificación: ' . $e->getMessage()]);
        }
    }
}
