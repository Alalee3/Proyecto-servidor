<?php

namespace App\Livewire\Evaluacion;

use Livewire\Component;
use Livewire\WithPagination;
use App\Repositories\Evaluacion\EvaluacionIndexRepo;
use Exception;

class ListEvaluacion extends Component
{
    use WithPagination;

    public $busqueda = '';
    public $paginacion = 5;
    public $idInhabilitar = null;
    public $idRestaurar = null;

    protected $evaluacionesRepository;

    public function __construct()
    {
        $this->evaluacionesRepository = new EvaluacionIndexRepo();
    }

    public function updatedBusqueda()
    {
        $this->resetPage();
    }

    public function confirmarInhabilitar($id)
    {
        $this->idInhabilitar = $id;
    }

    public function inhabilitar()
    {
        try {
            $this->evaluacionesRepository->inhabilitar($this->idInhabilitar);
            session()->flash('message', 'Evaluación inhabilitada correctamente.');
        } catch (Exception $e) {
            session()->flash('error', 'Error al inhabilitar la evaluación.');
        }
        $this->idInhabilitar = null;
    }

    public function confirmarRestaurar($id)
    {
        $this->idRestaurar = $id;
    }

    public function restaurar()
    {
        try {
            $this->evaluacionesRepository->restaurar($this->idRestaurar);
            session()->flash('message', 'Evaluación restaurada correctamente.');
        } catch (Exception $e) {
            session()->flash('error', 'Error al restaurar la evaluación.');
        }
        $this->idRestaurar = null;
    }

    public function render()
    {
        $paginacionCorrecta = [5, 10, 25, 50];
        if (!in_array($this->paginacion, $paginacionCorrecta)) {
            $this->paginacion = 5;
        }

        $evaluaciones = $this->evaluacionesRepository->listar($this->busqueda, $this->paginacion);

        return view('livewire.pages.evaluacion.list-evaluacion', compact('evaluaciones'));
    }
}
