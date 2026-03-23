<?php

namespace App\Livewire\Auth;

use Illuminate\Support\Facades\Auth;
use App\Models\User;
use Livewire\Component;
use Livewire\Attributes\Layout;

class SeleccionarRol extends Component
{
    public $misRoles = [];

    #[Layout('layouts.guest')]
    public function mount()
    {
        // Revisamos si ya está autenticado (no debería estar aquí si ya entró)
        if (Auth::check()) {
            return redirect()->route('dashboard');
        }

        // Buscamos la cédula temporal de la sesión
        $cedula = session('temp_cedula');
        
        if (!$cedula) {
            return redirect()->route('login');
        }

        // Obtener todos sus roles en emulación
        $this->misRoles = \DB::connection('emulacion_sogac_2')
            ->table('usuario as u')
            ->join('rol as r', 'u.usu_cod_rol', '=', 'r.rol_codigo')
            ->where('u.usu_cedula', $cedula)
            ->where('u.usu_estatus', 'A')
            ->select('u.usu_cod_rol', 'r.rol_nombre')
            ->get();
            
        if (count($this->misRoles) === 0) {
            return redirect()->route('login');
        }
    }

    /**
     * Hace el Auth final con el rol seleccionado.
     */
    public function seleccionarRol($rolId)
    {
        $cedula = session('temp_cedula');
        
        if (!$cedula) return;

        // Buscamos el usu_codigo específico en emulación para esa combinación
        $usu_codigo = \DB::connection('emulacion_sogac_2')
            ->table('usuario')
            ->where('usu_cedula', $cedula)
            ->where('usu_cod_rol', $rolId)
            ->where('usu_estatus', 'A')
            ->value('usu_codigo');

        if ($usu_codigo) {
            // FORZAMOS el uso de la conexión de emulación para encontrar el objeto Usuario
            $usuario = User::on('emulacion_sogac_2')->find($usu_codigo);

            if ($usuario) {
                // Guardamos el rol activo para que el sidebar/perfil sepa cuál es
                session(['active_role' => $rolId]);
                
                // Ahora sí, hacemos login oficial
                Auth::login($usuario);

                // Limpiamos la cédula temporal
                session()->forget('temp_cedula');

                return redirect()->intended(route('dashboard'));
            }
        }
    }

    public function render()
    {
        return view('livewire.auth.seleccionar-rol');
    }
}
