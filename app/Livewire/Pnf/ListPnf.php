<?php

namespace App\Livewire\Pnf;

use Livewire\Component;
use Livewire\WithPagination;
use App\Repositories\Pnf\PnfIndexRepo;
use Exception;

class ListPnf extends Component
{
    use WithPagination;

    public $busqueda = '';
    public $paginacion = 5;
    public $idInhabilitar = null;
    public $idRestaurar = null;
    
    protected $pnfsRepository;

    public function __construct()
    {
        $this->pnfsRepository = new PnfIndexRepo();
    }

    public function confirmarInhabilitar($id){
        $this->idInhabilitar = $id;
    }

    public function confirmarRestaurar($id)
    {
        $this->idRestaurar = $id;
    }

    public function inhabilitar()
    {
        try {
            $result = $this->pnfsRepository->inhabilitar($this->idInhabilitar);

            if ($result) {
                session()->flash('message', 'PNF inhabilitado exitosamente.');
                $this->dispatch('pnfUpdated');
            } else {
                session()->flash('error', 'No se pudo inhabilitar el PNF.');
            }
        } catch (Exception $e) {
            session()->flash('error', $e->getMessage());
        }

        $this->idInhabilitar = null;
    }

    public function restaurar()
    {
        try {
            $result = $this->pnfsRepository->restaurar($this->idRestaurar);

            if ($result) {
                session()->flash('message', 'PNF restaurado exitosamente.');
                $this->dispatch('pnfUpdated');
            } else {
                session()->flash('error', 'No se pudo restaurar el PNF. Verifique que esté inhabilitado.');
            }
        } catch (Exception $e) {
            session()->flash('error', 'Error al restaurar el PNF: ' . $e->getMessage());
        }

        $this->idRestaurar = null;
    }

    public function render()
    {
        $paginacionCorrecta = [5, 10, 25, 50];
        if (!in_array($this->paginacion, $paginacionCorrecta)) {
            $this->paginacion = 5;
        }

        $pnfs = $this->pnfsRepository->listar($this->busqueda, $this->paginacion);

        return view('livewire.pages.pnf.list-pnf', compact('pnfs'));
    }
}