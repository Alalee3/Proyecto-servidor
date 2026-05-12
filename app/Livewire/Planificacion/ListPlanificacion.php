<?php

namespace App\Livewire\Planificacion;

use Livewire\Component;
use Livewire\WithPagination;
use App\Repositories\Planificacion\PlanificacionIndexRepo;
use Illuminate\Support\Facades\DB;
use Barryvdh\DomPDF\Facade\Pdf;

class ListPlanificacion extends Component
{

    use WithPagination;

    public $search = '';
    public $perPage = 5;

    protected $planificacionRepository;

    public function __construct()
    {
        $this->planificacionRepository = new PlanificacionIndexRepo();
    }

    public function mount()
    {
    }

    // Define los eventos que este componente va a escuchar.
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

    public function render()
    {
        $filters = [
            'search_term' => $this->search,
        ];
        $planificaciones = $this->planificacionRepository->listar($filters, $this->perPage);

        return view('livewire.pages.planificacion.list-planificacion', [
            'planificaciones' => $planificaciones,
        ]);
    }

}
