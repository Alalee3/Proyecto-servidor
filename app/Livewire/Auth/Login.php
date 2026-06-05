<?php

namespace App\Livewire\Auth;

use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use App\Models\User;
use Livewire\Component;
use Livewire\Attributes\Layout;
use App\Repositories\UsuarioRepository;
use App\Repositories\Calendario\CalendarioCreateRepo;
use App\Models\CalendarioAcademico;

class Login extends Component
{
    public string $username = '';
    public string $password = '';
    public string $errorMessage = '';

    protected $rules = [
        'username' => 'required|string',
        'password' => 'required|string',
    ];

    protected $messages = [
        'username.required' => 'El campo usuario es obligatorio.',
        'password.required' => 'El campo contraseña es obligatorio.',
    ];

    #[Layout('layouts.guest')]
    public function mount()
    {
        // Si ya está autenticado, redirigir al dashboard
        if (Auth::check()) {
            return redirect()->route('dashboard');
        }

        // Si viene un payload de login externo, manejarlo de inmediato
        if (request()->has('payload')) {
            return app(\App\Http\Controllers\Auth\ExternalLoginController::class)->login(request());
        }
    }

    public function login()
    {
        $this->errorMessage = '';
        $this->validate();

        try {
            // 1. Conectar y buscar en la base de datos de emulación
            $dbUser = DB::connection('emulacion_sogac_2')
                ->table('usuario')
                ->where('usu_nombre', $this->username)
                ->first();

            if (!$dbUser) {
                $this->errorMessage = 'Las credenciales ingresadas son incorrectas.';
                return;
            }

            // 2. Verificar contraseña (usando contraseña en mayúsculas como en acceso_sistema.php)
            if (!password_verify(strtoupper($this->password), $dbUser->usu_clave)) {
                $this->errorMessage = 'Las credenciales ingresadas son incorrectas.';
                return;
            }

            // Verificar si el usuario está activo
            if ($dbUser->usu_estatus !== 'A') {
                $this->errorMessage = 'Este usuario no se encuentra activo en el sistema.';
                return;
            }

            $cedula = $dbUser->usu_cedula;

            // 3. Obtener roles filtrados de Informática
            $usuarioRepo = new UsuarioRepository();
            $rolesList = $usuarioRepo->getRolesInformaticoPorCedula($cedula);

            if ($rolesList->isEmpty()) {
                $this->errorMessage = 'El usuario no posee un rol activo correspondiente al PNF en Informática.';
                return;
            }

            // 4. Si tiene múltiples roles, redirigir a selección de rol
            if ($rolesList->count() > 1) {
                session(['temp_cedula' => $cedula]);
                return redirect()->route('seleccionar-rol');
            }

            // 5. Si tiene un solo rol, validar calendario
            CalendarioAcademico::inactivarVencidos();
            $calendarioRepo = new CalendarioCreateRepo();
            if (!$calendarioRepo->hayCalendarioActivo()) {
                // Redirigir al flujo de selección de rol para mostrar alerta o formulario
                session(['temp_cedula' => $cedula]);
                return redirect()->route('seleccionar-rol');
            }

            // 6. Iniciar sesión con el único rol disponible
            $singleRole = $rolesList->first();
            $laravelUser = User::on('external_db')
                ->where('usu_cedula', $cedula)
                ->where('usu_cod_rol', $singleRole->usu_cod_rol)
                ->where('usu_estatus', 'A')
                ->first();

            if (!$laravelUser) {
                $this->errorMessage = 'No se encontró el perfil de usuario en el sistema.';
                return;
            }

            session(['active_role' => $singleRole->usu_cod_rol]);
            Auth::login($laravelUser);

            return redirect()->intended(route('dashboard'));

        } catch (\Exception $e) {
            \Illuminate\Support\Facades\Log::error("Error en login temporal: " . $e->getMessage());
            $this->errorMessage = 'Ocurrió un error al procesar el inicio de sesión. Por favor, intente de nuevo.';
        }
    }

    public function render()
    {
        return view('livewire.auth.login');
    }
}
