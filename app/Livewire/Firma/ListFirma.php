<?php

namespace App\Livewire\Firma;

use Livewire\Component;
use Livewire\WithPagination;
use App\Repositories\Firma\FirmaIndexRepo;
use Exception;

class ListFirma extends Component
{
    use WithPagination;

    public $busqueda = '';
    public $paginacion = 5;
    public $idInhabilitar = null;
    public $idRestaurar = null;

    protected $firmaRepository;

    public function __construct()
    {
        $this->firmaRepository = new FirmaIndexRepo();
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
        if (!\Illuminate\Support\Facades\Gate::allows('cambiar-estatus-firma')) {
            abort(403);
        }

        try {
            $this->firmaRepository->inhabilitar($this->idInhabilitar);
            session()->flash('message', 'Firma inhabilitada correctamente.');
        } catch (Exception $e) {
            session()->flash('error', 'Error al inhabilitar la firma.');
        }
        $this->idInhabilitar = null;
    }

    public function confirmarRestaurar($id)
    {
        $this->idRestaurar = $id;
    }

    public function restaurar()
    {
        if (!\Illuminate\Support\Facades\Gate::allows('cambiar-estatus-firma')) {
            abort(403);
        }

        try {
            $this->firmaRepository->restaurar($this->idRestaurar);
            session()->flash('message', 'Firma restaurada correctamente.');
        } catch (Exception $e) {
            session()->flash('error', 'Error al restaurar la firma.');
        }
        $this->idRestaurar = null;
    }

    public function render()
    {
        $paginacionCorrecta = [5, 10, 25, 50];
        if (!in_array($this->paginacion, $paginacionCorrecta)) {
            $this->paginacion = 5;
        }

        $firmas = $this->firmaRepository->listar($this->busqueda, $this->paginacion);

        return view('livewire.pages.firma.list-firma', compact('firmas'));
    }
}
