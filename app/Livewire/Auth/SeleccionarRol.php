<?php

namespace App\Livewire\Auth;

use Illuminate\Support\Facades\Auth;
use App\Models\User;
use Livewire\Component;
use Livewire\Attributes\Layout;
use App\Repositories\Calendario\CalendarioCreateRepo;
use App\Models\CalendarioAcademico;
use App\Repositories\UsuarioRepository;

class SeleccionarRol extends Component
{
    public $misRoles = [];
    public bool $hayCalendarioActivo = false;

    protected $usuarioRepository;

    #[Layout('layouts.guest')]
    public function mount()
    {
        // Revisamos si ya está autenticado
        if (Auth::check()) {
            return redirect()->route('dashboard');
        }

        // Buscamos la cédula temporal de la sesión
        $cedula = session('temp_cedula');

        if (!$cedula) {
            return redirect()->route('login');
        }

        $this->usuarioRepository = new UsuarioRepository();

        // Obtener todos sus roles en emulación
        $this->misRoles = $this->usuarioRepository->getRolesPorCedula($cedula);

        if (count($this->misRoles) === 0) {
            return redirect()->route('login');
        }

        // Verificar si existe calendario activo
        CalendarioAcademico::inactivarVencidos();
        $repo = new CalendarioCreateRepo();
        $this->hayCalendarioActivo = $repo->hayCalendarioActivo();
    }

    /**
     * Hace el Auth final con el rol seleccionado.
     */
    public function seleccionarRol($rolId)
    {
        $cedula = session('temp_cedula');

        if (!$cedula)
            return;

        // Verificar que haya calendario activo antes de permitir seleccionar rol
        // EXCEPCIÓN: Permitir al administrador (Rol 3) entrar sin calendario para que pueda crearlo internamente
        $repo = new CalendarioCreateRepo();
        if (!$repo->hayCalendarioActivo() && $rolId != 3) {
            session()->flash('error', 'Debe existir un calendario activo para ingresar al sistema. Contacte al administrador.');
            return;
        }

        // Buscamos el usu_codigo específico en emulación para esa combinación
        $usuarioRepo = new UsuarioRepository();
        $usu_codigo = $usuarioRepo->getUsuCodigo($cedula, $rolId);

        if ($usu_codigo) {
            $usuario = User::on('emulacion_sogac_2')->find($usu_codigo);

            if ($usuario) {
                session(['active_role' => $rolId]);
                Auth::login($usuario);
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
