<?php

namespace App\Providers;

use App\Models\User;
use Illuminate\Foundation\Support\Providers\AuthServiceProvider as ServiceProvider;
use Illuminate\Support\Facades\Gate; // Importa la fachada de Gate
use App\Repositories\AccesoRepository; // Importa tu repositorio de acceso
use Illuminate\Support\Facades\Auth; // Necesario para Auth::check() dentro del Gate
use Illuminate\Support\Facades\Log;

class AuthServiceProvider extends ServiceProvider
{
    /**
     * The model to policy mappings for the application.
     *
     * @var array<class-string, class-string>
     */
    protected $policies = [
        // 'App\Models\Model' => 'App\Policies\ModelPolicy',
    ];

    /**
     * Register any authentication / authorization services.
     *
     * Aquí es donde definirás tus Gates (Puertas) y otras lógicas de autorización.
     */
    public function boot(): void
    {
        // Obtén una instancia de AcesoRepository a través del contenedor de servicios de Laravel.
        // Laravel inyectará automáticamente las dependencias necesarias.
        $accesoRepository = app(AccesoRepository::class);

        // Define un Gate para verificar si el usuario es Coordinador.
        // Uso en Blade: @can('is-coordinador') ... @endcan
        // Uso en controladores: $this->authorize('is-coordinador');
        // Uso manual: Gate::allows('is-coordinador');
        //
        // @param \App\Models\User $user El objeto de usuario autenticado (se pasa automáticamente).
        // @param \App\Repositories\AccesoRepository $accesoRepository Inyectado automáticamente por el contenedor de servicios de Laravel.
        // @return bool
        Gate::define('is-coordinador', function ($user) use ($accesoRepository) {
            return Auth::check() && $accesoRepository->checkRole(1); // '2' es el ID para Profesor
        });


        /**
         * Define un Gate para verificar si el usuario es Profesor.
         * Uso en Blade: @can('is-profesor') ... @endcan
         * Uso en controladores: $this->authorize('is-profesor');
         * Uso manual: Gate::allows('is-profesor');
         *
         * @param \App\Models\User $user El objeto de usuario autenticado.
         * @return bool
         */
        Gate::define('is-profesor', function ($user) use ($accesoRepository) {
            return Auth::check() && $accesoRepository->checkRole(2); // '2' es el ID para Profesor
        });

        /**
         * Define un Gate para verificar si el usuario tiene uno de varios roles (Coordinador O Profesor).
         * Uso en Blade: @can('manage-pnf') ... @endcan
         *
         * @param \App\Models\User $user El objeto de usuario autenticado.
         * @return bool
         */
        Gate::define('manage-planificacion', function ($user) use ($accesoRepository) {
            return Auth::check() && ($accesoRepository->checkRole(1) || $accesoRepository->checkRole(2));
        });

        // NOTA: Si ya habías creado directivas personalizadas en AppServiceProvider (ej. @ifcoordinador),
        // y ahora vas a usar Gates (@can), puedes considerar eliminar esas directivas duplicadas para evitar redundancia.
    }
}
