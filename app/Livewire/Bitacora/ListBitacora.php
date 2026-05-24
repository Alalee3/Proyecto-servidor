<?php

namespace App\Livewire\Bitacora;

use Livewire\Component;
use Livewire\WithPagination;
use App\Repositories\Bitacora\BitacoraIndexRepo;

class ListBitacora extends Component
{
    use WithPagination;

    public $busqueda = '';
    public $fecha_inicio = null;
    public $fecha_fin = null;
    public $paginacion = 5;

    protected $bitacoraRepository;

    public function __construct()
    {
        $this->bitacoraRepository = new BitacoraIndexRepo();
    }

    public function render()
    {
        $paginacionCorrecta = [5, 10, 25, 50, 100];
        if (!in_array($this->paginacion, $paginacionCorrecta)) {
            $this->paginacion = 10;
        }

        $bitacoras = $this->bitacoraRepository->listar($this->busqueda, $this->fecha_inicio, $this->fecha_fin, $this->paginacion);

        return view('livewire.pages.bitacora.list-bitacora', compact('bitacoras'));
    }
}
