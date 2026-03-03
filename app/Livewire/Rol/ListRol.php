<?php

namespace App\Livewire\Rol;

use Livewire\Component;
use Livewire\WithPagination;
use App\Repositories\Rol\RolIndexRepo;

class ListRol extends Component
{
    use WithPagination;

    public $busqueda = '';
    public $paginacion = 5;

    protected $rolRepository;

    public function __construct()
    {
        $this->rolRepository = new RolIndexRepo();
    }

    public function render()
    {
        $paginacionCorrecta = [5, 10, 25, 50];
        if (!in_array($this->paginacion, $paginacionCorrecta)) {
            $this->paginacion = 5;
        }

        $roles = $this->rolRepository->listar($this->busqueda, $this->paginacion);

        return view('livewire.pages.rol.list-rol', compact('roles'));
    }
}
