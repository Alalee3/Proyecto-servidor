<?php

namespace App\Livewire\Permiso;

use Livewire\Component;
use App\Repositories\Permiso\PermisoViewRepo;
use Livewire\Attributes\Locked;

class ShowPermiso extends Component
{
    #[Locked]
    public $permisoId;

    public $permiso;
    protected $permisoRepository;

    public function __construct()
    {
        $this->permisoRepository = new PermisoViewRepo();
    }

    public function mount($id)
    {
        $this->permisoId = $id;
        $this->permiso = $this->permisoRepository->mostrar($this->permisoId);

        if (!$this->permiso) {
            return redirect()->route('permiso/listar')->with('error', 'Permiso no encontrado.');
        }
    }

    public function render()
    {
        return view('livewire.pages.permiso.show-permiso');
    }
}
