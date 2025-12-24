<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use App\Repositories\AccesoRepository;
use Illuminate\Support\Facades\Auth; // Asegúrate de que esta importación esté presente
use Symfony\Component\HttpFoundation\Response;

// ¡Cambia el nombre de la clase de CoordinadorMiddleware a RoleMiddleware!
class RoleMiddleware
{
    protected $accesoRepository;

    /**
     * Constructor del middleware.
     * Inyecta el AcesoRepository para usar sus funciones de verificación de roles.
     *
     * @param AccesoRepository $accesoRepository
     */
    public function __construct(AccesoRepository $accesoRepository)
    {
        $this->accesoRepository = $accesoRepository;
    }

    /**
     * Maneja una solicitud entrante.
     *
     * @param Request $request La solicitud HTTP entrante.
     * @param Closure $next La siguiente operación en la tubería de middleware.
     * @param string $roles Una cadena con los IDs de roles requeridos, separados por '|' (ej. "1|2").
     * @return Response
     */
    public function handle(Request $request, Closure $next, string $roles): Response
    {
        // 1. Verificar si el usuario está autenticado.
        if (Auth::guest()) {
            return redirect()->route('login')->with('error', 'Necesitas iniciar sesión para acceder a esta página.');
        }

        // 2. Dividir la cadena de roles en un array de IDs individuales.
        $requiredRoles = explode('|', $roles);

        // 3. Iterar sobre los roles requeridos para verificar si el usuario tiene AL MENOS UNO de ellos.
        $hasRequiredRole = false;
        foreach ($requiredRoles as $roleId) {
            if ($this->accesoRepository->checkRole((int) $roleId)) {
                $hasRequiredRole = true;
                break; // Si se encuentra un rol coincidente, no es necesario seguir verificando.
            }
        }

        // 4. Si el usuario NO tiene ninguno de los roles requeridos, redirige.
        if (!$hasRequiredRole) {
            return redirect()->route('dashboard')->with('error', 'No tienes los permisos necesarios para acceder a esta sección.');
        }

        // 5. Si el usuario tiene al menos uno de los roles, permite que la solicitud continúe.
        return $next($request);
    }
}
