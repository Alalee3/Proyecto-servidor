<?php

namespace App\Livewire\Color;

use Livewire\Component;
use Livewire\WithPagination;
use App\Repositories\Color\ColorIndexRepo;
use Exception;
use Illuminate\Support\Facades\Gate;

class ListColor extends Component
{
    use WithPagination;

    public $busqueda = '';
    public $paginacion = 5;
    public $idInhabilitar = null;
    public $idRestaurar = null;

    protected $colorRepository;

    public function __construct()
    {
        $this->colorRepository = new ColorIndexRepo();
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
        if (!Gate::allows('cambiar-estatus-color')) {
            abort(403);
        }

        try {
            $this->colorRepository->inhabilitar($this->idInhabilitar);
            session()->flash('message', 'Color inhabilitado correctamente.');
        } catch (Exception $e) {
            session()->flash('error', 'Error al inhabilitar el color.');
        }
        $this->idInhabilitar = null;
    }

    public function confirmarRestaurar($id)
    {
        $this->idRestaurar = $id;
    }

    public function restaurar()
    {
        if (!Gate::allows('cambiar-estatus-color')) {
            abort(403);
        }

        try {
            $this->colorRepository->restaurar($this->idRestaurar);
            session()->flash('message', 'Color restaurado correctamente.');
        } catch (Exception $e) {
            session()->flash('error', 'Error al restaurar el color.');
        }
        $this->idRestaurar = null;
    }

    public function render()
    {
        $paginacionCorrecta = [5, 10, 25, 50];
        if (!in_array($this->paginacion, $paginacionCorrecta)) {
            $this->paginacion = 5;
        }

        $colores = $this->colorRepository->listar($this->busqueda, $this->paginacion);

        return view('livewire.pages.color.list-color', compact('colores'));
    }
}
