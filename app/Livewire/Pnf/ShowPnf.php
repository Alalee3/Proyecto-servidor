<?php

namespace App\Livewire\Pnf;

use Livewire\Component;
use App\Repositories\Pnf\PnfViewRepo;
use Exception;

class ShowPnf extends Component
{
    public $pnf;

    protected $pnfsRepository;

    public function __construct()
    {
        $this->pnfsRepository = new PnfViewRepo();
    } 

    public function mount(int $id)
    {
        try {
            $this->pnf = $this->pnfsRepository->mostrar($id);

        } catch (Exception $e) {
            session()->flash('error', 'Error al cargar el PNF: ' . $e->getMessage());
            return redirect()->route('pnf/listar');
        }
    }

    /**
     * Renderiza la vista del componente.
     */
    public function render()
    {
        return view('livewire.pages.pnf.show-pnf');
    }

    /**
     * Redirige al listado de PNF.
     */
    public function cerrar()
    {
        return redirect()->route('pnf/listar');
    }
}
