<?php

namespace App\Livewire\Planificacion;

use Livewire\Component;
use Livewire\WithPagination;
use App\Repositories\Planificacion\PlanificacionIndexRepo;
use App\Repositories\Planificacion\PlanificacionViewRepo;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Barryvdh\DomPDF\Facade\Pdf;

class MisPlanificaciones extends Component
{

    use WithPagination;
    public $search = '';
    public $perPage = 5;

    public $docente;

    protected $planificacionRepository;

    public function __construct()
    {
        $this->planificacionRepository = new PlanificacionIndexRepo();
    }

    public function mount()
    {
        if (Auth::check()) {
            $user = Auth::user();
            $this->docente = $user->name . ' ' . $user->apellido;
        } else {
            $this->docente = 'Invitado';
        }
    }

    protected $listeners = [
        'planificacionGuardada' => 'recargarPlanificaciones',
        'planificacionAprobada' => 'recargarPlanificaciones',
        'planificacionRechazada' => 'recargarPlanificaciones',
        'refreshDatatable' => 'recargarPlanificaciones',
    ];

    public function recargarPlanificaciones()
    {
        $this->resetPage();
    }

    public function updatingSearch()
    {
        $this->resetPage();
    }

    public function updatingPerPage()
    {
        $this->resetPage();
    }

    public function render()
    {
        $filters = [
            'search_term' => $this->search,
        ];

        $planificaciones = $this->planificacionRepository->listar(
            $filters,
            $this->perPage,
            true
        );

        return view('livewire.planificacion.mis-planificaciones', [
            'planificaciones' => $planificaciones,
        ]);
    }

    public function exportarPdf($planificacionId)
    {
        $repo = new PlanificacionViewRepo();
        $planificacion = $repo->getDetallesPlanificacion($planificacionId);
        if (!$planificacion) {
            session()->flash('error', 'Planificación no encontrada.');
            return;
        }
        $pdf = Pdf::loadView('livewire.planificacion.pdf-mis-planificacion', [
            'planificacion' => $planificacion
        ]);
        return response()->streamDownload(function () use ($pdf) {
            echo $pdf->stream();
        }, 'planificacion_' . $planificacionId . '.pdf');
    }
}
