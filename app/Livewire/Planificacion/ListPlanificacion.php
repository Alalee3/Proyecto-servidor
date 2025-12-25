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
    // Todos estos eventos harán que se recarguen las planificaciones.
    protected $listeners = [
        'planificacionGuardada' => 'recargarPlanificaciones',   // Para cuando se guarda una nueva planificación
        'planificacionAprobada' => 'recargarPlanificaciones',   // Nuevo: Para cuando una planificación es aprobada
        'planificacionRechazada' => 'recargarPlanificaciones',  // Nuevo: Para cuando una planificación es rechazada
        'refreshDatatable' => 'recargarPlanificaciones',       // Para refrescar la tabla de datos
    ];

    /**
     * Este método se ejecuta cuando se dispara uno de los eventos definidos en $listeners.
     * Simplemente resetea la paginación a la primera página para forzar una recarga completa
     * de los datos en el método render().
     */
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

    public function exportarReporteGeneralPdf()
    {
        $filters = [
            'seccion_id' => $this->filterSeccionId,
            'lapso_id' => $this->filterLapsoId,
            'unidad_curricular_codigo' => $this->filterUnidadCurricularCodigo,
            'search_term' => $this->search,
        ];
        // Obtener todas las planificaciones filtradas (sin paginar)
        $planificaciones = $this->planificacionRepository->listar($filters, 10000); // Un límite alto para traer todas

        $pdf = Pdf::loadView('livewire.planificacion.pdf-list-planificacion', [
            'planificaciones' => $planificaciones
        ]);
        return response()->streamDownload(function () use ($pdf) {
            echo $pdf->stream();
        }, 'reporte_general_planificaciones.pdf');
    }
}
