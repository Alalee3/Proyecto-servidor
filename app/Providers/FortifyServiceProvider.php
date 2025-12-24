<?php

namespace App\Providers;

use App\Models\User;
use Illuminate\Support\Facades\Route;
use Illuminate\Foundation\Support\Providers\RouteServiceProvider as ServiceProvider;
use Illuminate\Support\Facades\Auth;
use Laravel\Fortify\Fortify;
use Illuminate\Support\ServiceProvider as BaseServiceProvider;

class FortifyServiceProvider extends BaseServiceProvider
{

    public function register(): void
    {
        //
    }
    public function boot()
    {
        // Aquí puedes registrar las rutas de Fortify
        Fortify::loginView(function () {
            dd('Fortify is attempting to show the login view!');
            return view('pages.auth.login');
        });

        // Middleware para verificar el estatus del usuario
        Fortify::authenticateUsing(function ($request) {
            $user = User::where('email', $request->email)->first();

            if ($user && $user->estatus === '2') {
                // Si el estatus es 2, no permitir el acceso
                return null; // Esto hará que la autenticación falle
            }

            $credenciales = $request->only('email', 'password');

            if (Auth::validate($credenciales) && $user->estatus === '1') {

                return $user; // Retorna el usuario si está permitido
            }

            return null;
        });
    }
}
