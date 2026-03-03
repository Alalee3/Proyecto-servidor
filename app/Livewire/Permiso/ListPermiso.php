<?php

namespace App\Livewire\Permiso;

use Livewire\Component;
use Livewire\WithPagination;
use App\Repositories\Permiso\PermisoIndexRepo;
use Exception;

class ListPermiso extends Component
{
    use WithPagination;

    public $busqueda = '';
    public $paginacion = 5;

    protected $permisoRepository;

    public function __construct()
    {
        $this->permisoRepository = new PermisoIndexRepo();
    }

    public function render()
    {
        $paginacionCorrecta = [5, 10, 25, 50];
        if (!in_array($this->paginacion, $paginacionCorrecta)) {
            $this->paginacion = 5;
        }

        $permisos = $this->permisoRepository->listar($this->busqueda, $this->paginacion);

        return view('livewire.pages.permiso.list-permiso', compact('permisos'));
    }
}
