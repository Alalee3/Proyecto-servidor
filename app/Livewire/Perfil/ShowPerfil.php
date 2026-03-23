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
        $user = Auth::user();
        
        // Buscamos todas las "cuentas" (roles) que tiene esta persona 
        // explícitamente en la base de datos de emulación (emulacion_sogac_2)
        // para saltar cualquier lógica de fallback o conexión de producción (real SOGAC)
        $misRoles = \DB::connection('emulacion_sogac_2')
            ->table('usuario as u')
            ->join('rol as r', 'u.usu_cod_rol', '=', 'r.rol_codigo')
            ->where('u.usu_cedula', $user->usu_cedula)
            ->select('u.usu_codigo', 'u.usu_estatus', 'u.usu_cod_rol', 'r.rol_nombre')
            ->get();

        return view('livewire.perfil.show-perfil', [
            'user' => $user,
            'misRoles' => $misRoles,
            'rolActivo' => $user->usu_cod_rol // El rol que ya trae por el accesor modificado
        ]);
    }

    /**
     * Permite cambiar dinámicamente el rol con el que se navega el sistema
     */
    public function cambiarRol($rolId)
    {
        $user = Auth::user();
        
        // Verificamos que el usuario posea este rol en la base de datos de emulación
        $existe = \DB::connection('emulacion_sogac_2')
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
