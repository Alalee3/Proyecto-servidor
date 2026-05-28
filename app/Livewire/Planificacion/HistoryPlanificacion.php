<?php

namespace App\App\Livewire\Planificacion; // Let's check namespace of other livewire files. It was App\Livewire\Planificacion.
// Wait! Let's check the top of app/Livewire/Planificacion/ListPlanificacion.php:
// namespace App\Livewire\Planificacion;
// Yes! So the namespace should be:
namespace App\Livewire\Planificacion;

use Livewire\Component;
use Livewire\WithPagination;
use App\Repositories\Planificacion\HistoryPlanificacionRepo;
use App\Repositories\Planificacion\PlanificacionCreateRepo;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class HistoryPlanificacion extends Component
{
    use WithPagination;

    public $search = '';
    public $perPage = 10;

    // Modal & Duplication properties
    public $showDuplicarModal = false;
    public $selectedPlanificacionId = null;
    
    public $id_profesor_asignado = '';
    public $proposito = '';
    public $tipos_seccion = [];
    public $evaluacionesFechas = []; // Indexed by old_id_detalle_evaluacion
    
    // Auxiliary lists for the modal UI
    public $asignaciones = [];
    public $evaluacionesSource = [];
    
    // Lapso info for selected assignment
    public $lapsoNombre = '';
    public $lapsoFechaInicio = '';
    public $lapsoFechaFin = '';

    protected $historyRepo;
    protected $createRepo;

    public function boot()
    {
        $this->historyRepo = new HistoryPlanificacionRepo();
        $this->createRepo = new PlanificacionCreateRepo();
    }

    public function mount()
    {
        // Load active assignments for the current teacher (so they can pick the destination)
        $this->asignaciones = $this->createRepo->getAsignacionesDocente(Auth::id());
    }

    public function updatingSearch()
    {
        $this->resetPage();
    }

    public function selectPlanificacionParaDuplicar($id)
    {
        $this->selectedPlanificacionId = $id;
        $this->id_profesor_asignado = '';
        $this->lapsoNombre = '';
        $this->lapsoFechaInicio = '';
        $this->lapsoFechaFin = '';

        // Cargar propósito y tipos de sección origen
        $source = DB::table('planificacion')
            ->where('id_planificacion', $id)
            ->first();

        if ($source) {
            $this->proposito = $source->proposito_unidad;
            $this->tipos_seccion = json_decode($source->tipo_planificacion, true) ?? [];
        }

        // Cargar las evaluaciones de la planificación origen para mapear las nuevas fechas
        $this->evaluacionesSource = DB::table('unidad_corte as uc')
            ->join('detalle_evaluacion as de', 'uc.id_unidad_corte', '=', 'de.id_unidad_corte')
            ->join('tipo_evaluacion as te', 'de.id_tipo_evaluacion', '=', 'te.id_tipo_evaluacion')
            ->join('tecnica_evaluacion as t', 'de.id_tecnica_evaluacion', '=', 't.id_tecnica_evaluacion')
            ->where('uc.id_planificacion', $id)
            ->where('de.estatus', '!=', '3') // No copiamos rechazadas
            ->select(
                'uc.numero_unidad_corte',
                'de.id_detalle_evaluacion',
                'te.nombre_tipo_evaluacion as evaluacion',
                't.nombre_tecnica_evaluacion as tecnica',
                'de.ponderacion_detalle_evaluacion as ponderacion',
                'de.fecha_evaluacion_detalle_evaluacion'
            )
            ->orderBy('uc.numero_unidad_corte')
            ->orderBy('de.id_detalle_evaluacion')
            ->get();

        // Inicializar array de nuevas fechas vacío
        $this->evaluacionesFechas = [];
        foreach ($this->evaluacionesSource as $ev) {
            $this->evaluacionesFechas[$ev->id_detalle_evaluacion] = '';
        }

        $this->showDuplicarModal = true;
    }

    public function updatedIdProfesorAsignado($value)
    {
        if ($value) {
            $lapso = $this->createRepo->getLapsoAcademicoByAsignacion($value);
            if ($lapso) {
                $this->lapsoNombre = $lapso->lap_nombre;
                $this->lapsoFechaInicio = $lapso->lap_fecha_inicio;
                $this->lapsoFechaFin = $lapso->lap_fecha_fin;
            }
        } else {
            $this->lapsoNombre = '';
            $this->lapsoFechaInicio = '';
            $this->lapsoFechaFin = '';
        }
    }

    public function closeDuplicarModal()
    {
        $this->showDuplicarModal = false;
        $this->reset(['selectedPlanificacionId', 'id_profesor_asignado', 'proposito', 'tipos_seccion', 'evaluacionesFechas', 'evaluacionesSource', 'lapsoNombre', 'lapsoFechaInicio', 'lapsoFechaFin']);
    }

    public function duplicar()
    {
        // 1. Validaciones
        $rules = [
            'id_profesor_asignado' => 'required',
            'proposito' => 'required|string|min:5',
            'tipos_seccion' => 'required|array|min:1',
            'evaluacionesFechas' => 'required|array',
        ];

        // Añadir reglas dinámicas para cada fecha de evaluación
        foreach ($this->evaluacionesSource as $ev) {
            $evalId = $ev->id_detalle_evaluacion;
            $rules["evaluacionesFechas.$evalId"] = [
                'required',
                'date',
                function ($attribute, $value, $fail) {
                    // Validar fin de semana
                    $dayOfWeek = Carbon::parse($value)->dayOfWeek;
                    if ($dayOfWeek === 0 || $dayOfWeek === 6) {
                        $fail("La fecha de evaluación no puede caer en fin de semana (sábado o domingo).");
                    }

                    // Validar límites del lapso
                    if ($this->lapsoFechaInicio && $this->lapsoFechaFin) {
                        if ($value < $this->lapsoFechaInicio || $value > $this->lapsoFechaFin) {
                            $fail("La fecha debe estar dentro del lapso ({$this->lapsoFechaInicio} al {$this->lapsoFechaFin}).");
                        }
                    }
                }
            ];
        }

        $messages = [
            'id_profesor_asignado.required' => 'Debe seleccionar una asignatura de destino.',
            'proposito.required' => 'El propósito de la unidad es obligatorio.',
            'proposito.min' => 'El propósito debe tener al menos 5 caracteres.',
            'tipos_seccion.required' => 'Debe seleccionar al menos un tipo de sección.',
            'evaluacionesFechas.*.required' => 'Debe seleccionar la nueva fecha para esta evaluación.',
            'evaluacionesFechas.*.date' => 'La fecha no es válida.',
        ];

        $this->validate($rules, $messages);

        try {
            // Verificar si el destino ya tiene una planificación activa
            $existing = \App\Models\Planificacion::where('id_profesor_asignado', $this->id_profesor_asignado)
                ->whereIn('estatus', ['1', '2', '3', '4'])
                ->first();

            if ($existing) {
                $this->showAlert('error', 'La asignatura seleccionada ya tiene una planificación asignada (ya sea Borrador, Pendiente o Aprobada). Por favor elimínala o edítala en Gestionar Planificaciones.');
                return;
            }

            // Realizar duplicación
            $this->historyRepo->duplicarPlanificacion(
                $this->selectedPlanificacionId,
                $this->id_profesor_asignado,
                $this->evaluacionesFechas,
                $this->proposito,
                $this->tipos_seccion
            );

            $this->closeDuplicarModal();
            $this->showAlert('success', '¡Planificación duplicada con éxito! Se ha guardado como borrador para que puedas revisarla en Gestionar Planificaciones.', '/planificacion/list');
        } catch (\Exception $e) {
            $this->showAlert('error', 'Error al duplicar la planificación. Por favor, inténtelo de nuevo.');
        }
    }

    protected function showAlert($type, $message, $redirect = null)
    {
        $data = json_encode(['type' => $type, 'message' => $message, 'redirect' => $redirect]);
        $this->js("window.dispatchEvent(new CustomEvent('show-alert', { detail: {$data} }))");
    }

    public function render()
    {
        $filters = [
            'search_term' => $this->search,
        ];
        $planificaciones = $this->historyRepo->listarHistorial($filters, $this->perPage);

        return view('livewire.pages.planificacion.history-planificacion', [
            'planificaciones' => $planificaciones,
        ]);
    }
}
