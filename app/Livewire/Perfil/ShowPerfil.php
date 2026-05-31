<?php

namespace App\Livewire\Perfil;

use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Livewire\Component;
use Livewire\Attributes\Layout;

class ShowPerfil extends Component
{
    #[Layout('layouts.app')]
    public function render()
    {
        $user = auth()->user();
        
        // Usamos el nuevo método del modelo User para obtener todos los perfiles
        $misRoles = $user->obtenerRolesAsociados();

        return view('livewire.perfil.show-perfil', [
            'user' => $user,
            'misRoles' => $misRoles,
            'rolActivo' => $user->usu_cod_rol
        ]);
    }

    /**
     * Permite cambiar dinámicamente el rol con el que se navega el sistema
     */
    public function cambiarRol($rolId)
    {
        $user = Auth::user();
        
        // Verificamos que el usuario posea este rol en la base de datos de emulación
        $existe = \DB::connection('external_db')
            ->table('usuario')
            ->where('usu_cedula', $user->usu_cedula)
            ->where('usu_cod_rol', $rolId)
            ->where('usu_estatus', 'A')
            ->exists();

        if ($existe) {
            session(['active_role' => $rolId]);
            
            // Refrescamos la página de inmediato para que los Gates (AuthServiceProvider)
            // se vuelvan a evaluar con el nuevo usu_cod_rol que provee el modelo User
            $this->dispatch('notificar', [
                'type' => 'success',
                'message' => 'Navegando como Rol ID: ' . $rolId
            ]);
            
            return redirect()->route('perfil');
        }
    }
}
