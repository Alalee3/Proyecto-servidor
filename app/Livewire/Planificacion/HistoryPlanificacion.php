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

    // Modal properties
    public $showDuplicarModal = false;
    public $selectedPlanificacionId = null;
    
    public $id_profesor_asignado = '';
    public $proposito = '';
    public $tipos_seccion = [];
    public $asignaciones = [];

    public $search = '';
    public $perPage = 10;

    protected $historyRepo;
    protected $createRepo;

    public function boot()
    {
        $this->historyRepo = new HistoryPlanificacionRepo();
        $this->createRepo = new \App\Repositories\Planificacion\PlanificacionCreateRepo();
    }

    public function mount()
    {
        // Load active assignments for the current teacher
        $this->asignaciones = $this->createRepo->getAsignacionesDocente(\Illuminate\Support\Facades\Auth::id());
    }

    public function updatingSearch()
    {
        $this->resetPage();
    }



    public function selectPlanificacionParaDuplicar($id)
    {
        $this->selectedPlanificacionId = $id;
        $this->id_profesor_asignado = '';

        // Cargar propósito y tipos de sección origen
        $source = \Illuminate\Support\Facades\DB::table('planificacion')
            ->where('id_planificacion', $id)
            ->first();

        if ($source) {
            $this->proposito = $source->proposito_unidad;
            $this->tipos_seccion = json_decode($source->tipo_planificacion, true) ?? [];
        }

        $this->showDuplicarModal = true;
    }

    public function closeDuplicarModal()
    {
        $this->showDuplicarModal = false;
        $this->reset(['selectedPlanificacionId', 'id_profesor_asignado', 'proposito', 'tipos_seccion']);
    }

    public function duplicar()
    {
        $rules = [
            'id_profesor_asignado' => 'required',
            'proposito' => 'required|string|min:5',
            'tipos_seccion' => 'required|array|min:1',
        ];

        $messages = [
            'id_profesor_asignado.required' => 'Debe seleccionar una asignatura de destino.',
            'proposito.required' => 'El propósito de la unidad es obligatorio.',
            'proposito.min' => 'El propósito debe tener al menos 5 caracteres.',
            'tipos_seccion.required' => 'Debe seleccionar al menos un tipo de sección.',
        ];

        $this->validate($rules, $messages);

        try {
            $existing = \App\Models\Planificacion::where('id_profesor_asignado', $this->id_profesor_asignado)
                ->whereIn('estatus', ['1', '2', '3', '4'])
                ->first();

            if ($existing) {
                $this->showAlert('error', 'La asignatura seleccionada ya tiene una planificación asignada. Por favor elimínala o edítala en Gestionar Planificaciones.');
                return;
            }

            $newId = $this->historyRepo->duplicarPlanificacionSinFechas(
                $this->selectedPlanificacionId,
                $this->id_profesor_asignado,
                $this->proposito,
                $this->tipos_seccion
            );

            $this->closeDuplicarModal();
            $this->showAlert('success', '¡Planificación importada! Serás redirigido para asignar las fechas.');
            
            return redirect()->to('/planificacion/update/' . $newId . '?imported=1');
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
