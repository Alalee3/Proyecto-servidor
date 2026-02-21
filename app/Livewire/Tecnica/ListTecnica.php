<?php

namespace App\Livewire\Tecnica;

use Livewire\Component;
use Livewire\WithPagination;
use App\Repositories\Tecnica\TecnicaIndexRepo;
use Exception;

class ListTecnica extends Component
{
    use WithPagination;

    public $busqueda = '';
    public $paginacion = 5;
    public $idInhabilitar = null;
    public $idRestaurar = null;

    protected $tecnicaRepository;

    public function __construct()
    {
        $this->tecnicaRepository = new TecnicaIndexRepo();
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
            $this->tecnicaRepository->inhabilitar($this->idInhabilitar);
            session()->flash('message', 'Técnica inhabilitada correctamente.');
        } catch (Exception $e) {
            session()->flash('error', 'Error al inhabilitar la técnica.');
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
            $this->tecnicaRepository->restaurar($this->idRestaurar);
            session()->flash('message', 'Técnica restaurada correctamente.');
        } catch (Exception $e) {
            session()->flash('error', 'Error al restaurar la técnica.');
        }
        $this->idRestaurar = null;
    }

    public function render()
    {
        $paginacionCorrecta = [5, 10, 25, 50];
        if (!in_array($this->paginacion, $paginacionCorrecta)) {
            $this->paginacion = 5;
        }

        $tecnicas = $this->tecnicaRepository->listar($this->busqueda, $this->paginacion);
        return view('livewire.pages.tecnica.list-tecnica', compact('tecnicas'));
    }
}
