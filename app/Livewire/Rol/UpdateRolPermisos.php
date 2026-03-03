<?php

namespace App\Livewire\Rol;

use Livewire\Component;
use App\Repositories\Rol\RolPermisoRepo;

class UpdateRolPermisos extends Component
{
    public $rolId;
    public $rol;
    public $modulosPermisos = [];
    public $selectedPermisos = [];

    protected $rolPermisoRepo;

    public function boot(RolPermisoRepo $rolPermisoRepo)
    {
        $this->rolPermisoRepo = $rolPermisoRepo;
    }

    public function mount($rolId)
    {
        $this->rolId = $rolId;
        $this->rol = $this->rolPermisoRepo->getRol($this->rolId);

        if (!$this->rol) {
            abort(404, 'Rol no encontrado en DAECE');
        }

        $this->modulosPermisos = $this->rolPermisoRepo->getModules();
        $this->selectedPermisos = array_map('strval', $this->rolPermisoRepo->getRolePermissions($this->rolId));
    }

    public function savePermisos()
    {
        // Filtramos valores nulos/vacíos en caso de que Alpine/Livewire los envíe
        $permisosToSave = array_filter($this->selectedPermisos, function ($val) {
            return !empty($val) && $val !== false && $val !== 'false';
        });

        $success = $this->rolPermisoRepo->saveRolePermissions($this->rolId, array_values($permisosToSave));

        if ($success) {
            session()->flash('message', 'Permisos actualizados correctamente para el rol: ' . $this->rol->rol_nombre);
        } else {
            session()->flash('error', 'Ocurrió un error al actualizar los permisos.');
        }

        return redirect()->route('rol/listar');
    }


    public function render()
    {
        return view('livewire.pages.rol.update-rol-permisos');
    }
}
