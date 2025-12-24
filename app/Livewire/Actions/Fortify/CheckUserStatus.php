<?php

namespace App\Livewire\Actions\Fortify;

use App\Models\User; // Asegúrate de que esta línea apunte correctamente a tu modelo de Usuario.
use Illuminate\Auth\AuthenticationException; // Necesario para lanzar la excepción de autenticación.
use Illuminate\Http\Request; // Necesario para tipar el parámetro $request.

class CheckUserStatus
{
    /**
     * Maneja el proceso de autenticación.
     *
     * @param  \Illuminate\Http\Request  $request  La solicitud HTTP entrante (contiene el email y contraseña).
     * @param  callable  $next     El siguiente "paso" en la pipeline de Fortify.
     * @return mixed                 El resultado de la siguiente acción, o una excepción si el estatus no es válido.
     * @throws \Illuminate\Auth\AuthenticationException Si el estatus del usuario no permite el login.
     */
    public function __invoke(Request $request, callable $next)
    {
        // Paso 1: Intentamos encontrar al usuario por el email que intentó loguearse.
        // Es importante hacer esto AQUÍ, porque esta acción se ejecuta después de que Fortify
        // ya verificó que la contraseña es correcta para el email dado.
        $user = User::where('email', $request->email)->first();

        // Paso 2: Verificamos si el usuario fue encontrado Y si su 'estatus' es 2 o 3.
        // Si es así, significa que no debe poder iniciar sesión.
        if ($user && ($user->estatus == 2 || $user->estatus == 3)) {
            // Paso 3: Lanzamos una excepción de autenticación.
            // Laravel Fortify la capturará automáticamente y mostrará este mensaje al usuario
            // en la página de login (generalmente debajo del campo de email o password).
            throw new AuthenticationException(
                'Tu cuenta está inactiva o suspendida. Por favor, contacta al administrador.'
            );
        }

        // Paso 4: Si el usuario no existe (lo cual es manejado por otra acción en la pipeline),
        // o si su estatus es 1 (activo), permitimos que la autenticación continúe
        // pasando la solicitud a la siguiente acción en la cadena.
        return $next($request);
    }
}
