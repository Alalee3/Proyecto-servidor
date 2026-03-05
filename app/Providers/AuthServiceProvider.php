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


        // --- GATES PARA EL MÓDULO DE EVENTO ---
        Gate::define('listar-evento', function ($user) use ($accesoRepository) {
            return $accesoRepository->checkPermission('Listar Evento');
        });

        Gate::define('crear-evento', function ($user) use ($accesoRepository) {
            return $accesoRepository->checkPermission('Crear Evento');
        });

        Gate::define('editar-evento', function ($user) use ($accesoRepository) {
            return $accesoRepository->checkPermission('Editar Evento');
        });

        Gate::define('ver-evento', function ($user) use ($accesoRepository) {
            return $accesoRepository->checkPermission('Ver Detalles de Evento');
        });
        // --------------------------------------

        // --- GATES PARA EL MÓDULO DE CONTENIDO ---
        Gate::define('listar-contenido', function ($user) use ($accesoRepository) {
            return $accesoRepository->checkPermission('Listar Contenido');
        });
        Gate::define('crear-contenido', function ($user) use ($accesoRepository) {
            return $accesoRepository->checkPermission('Crear Contenido');
        });
        Gate::define('editar-contenido', function ($user) use ($accesoRepository) {
            return $accesoRepository->checkPermission('Editar Contenido');
        });
        Gate::define('ver-contenido', function ($user) use ($accesoRepository) {
            return $accesoRepository->checkPermission('Ver Detalles de Contenido');
        });

        // --- GATES PARA EL MÓDULO DE TEMA ---
        Gate::define('listar-tema', function ($user) use ($accesoRepository) {
            return $accesoRepository->checkPermission('Listar Tema');
        });
        Gate::define('crear-tema', function ($user) use ($accesoRepository) {
            return $accesoRepository->checkPermission('Crear Tema');
        });
        Gate::define('editar-tema', function ($user) use ($accesoRepository) {
            return $accesoRepository->checkPermission('Editar Tema');
        });
        Gate::define('ver-tema', function ($user) use ($accesoRepository) {
            return $accesoRepository->checkPermission('Ver Detalles de Tema');
        });

        // --- GATES PARA EL MÓDULO DE INDICADOR LOGRO ---
        Gate::define('listar-indicador-logro', function ($user) use ($accesoRepository) {
            return $accesoRepository->checkPermission('Listar Indicador Logro');
        });
        Gate::define('crear-indicador-logro', function ($user) use ($accesoRepository) {
            return $accesoRepository->checkPermission('Crear Indicador Logro');
        });
        Gate::define('editar-indicador-logro', function ($user) use ($accesoRepository) {
            return $accesoRepository->checkPermission('Editar Indicador Logro');
        });
        Gate::define('ver-indicador-logro', function ($user) use ($accesoRepository) {
            return $accesoRepository->checkPermission('Ver Detalles de Indicador Logro');
        });

        // --- GATES PARA EL MÓDULO DE BIBLIOGRAFIA ---
        Gate::define('listar-bibliografia', function ($user) use ($accesoRepository) {
            return $accesoRepository->checkPermission('Listar Bibliografia');
        });
        Gate::define('crear-bibliografia', function ($user) use ($accesoRepository) {
            return $accesoRepository->checkPermission('Crear Bibliografia');
        });
        Gate::define('editar-bibliografia', function ($user) use ($accesoRepository) {
            return $accesoRepository->checkPermission('Editar Bibliografia');
        });
        Gate::define('ver-bibliografia', function ($user) use ($accesoRepository) {
            return $accesoRepository->checkPermission('Ver Detalles de Bibliografia');
        });

        // --- GATES PARA EL MÓDULO DE RECURSO ---
        Gate::define('listar-recurso', function ($user) use ($accesoRepository) {
            return $accesoRepository->checkPermission('Listar Recurso');
        });
        Gate::define('crear-recurso', function ($user) use ($accesoRepository) {
            return $accesoRepository->checkPermission('Crear Recurso');
        });
        Gate::define('editar-recurso', function ($user) use ($accesoRepository) {
            return $accesoRepository->checkPermission('Editar Recurso');
        });
        Gate::define('ver-recurso', function ($user) use ($accesoRepository) {
            return $accesoRepository->checkPermission('Ver Detalles de Recurso');
        });

        // --- GATES PARA EL MÓDULO DE ESTRATEGIA ---
        Gate::define('listar-estrategia', function ($user) use ($accesoRepository) {
            return $accesoRepository->checkPermission('Listar Estrategia');
        });
        Gate::define('crear-estrategia', function ($user) use ($accesoRepository) {
            return $accesoRepository->checkPermission('Crear Estrategia');
        });
        Gate::define('editar-estrategia', function ($user) use ($accesoRepository) {
            return $accesoRepository->checkPermission('Editar Estrategia');
        });
        Gate::define('ver-estrategia', function ($user) use ($accesoRepository) {
            return $accesoRepository->checkPermission('Ver Detalles de Estrategia');
        });

        // --- GATES PARA EL MÓDULO DE TECNICA ---
        Gate::define('listar-tecnica', function ($user) use ($accesoRepository) {
            return $accesoRepository->checkPermission('Listar Tecnica');
        });
        Gate::define('crear-tecnica', function ($user) use ($accesoRepository) {
            return $accesoRepository->checkPermission('Crear Tecnica');
        });
        Gate::define('editar-tecnica', function ($user) use ($accesoRepository) {
            return $accesoRepository->checkPermission('Editar Tecnica');
        });
        Gate::define('ver-tecnica', function ($user) use ($accesoRepository) {
            return $accesoRepository->checkPermission('Ver Detalles de Tecnica');
        });

        // --- GATES PARA EL MÓDULO DE EVALUACION ---
        Gate::define('listar-evaluacion', function ($user) use ($accesoRepository) {
            return $accesoRepository->checkPermission('Listar Evaluacion');
        });
        Gate::define('crear-evaluacion', function ($user) use ($accesoRepository) {
            return $accesoRepository->checkPermission('Crear Evaluacion');
        });
        Gate::define('editar-evaluacion', function ($user) use ($accesoRepository) {
            return $accesoRepository->checkPermission('Editar Evaluacion');
        });
        Gate::define('ver-evaluacion', function ($user) use ($accesoRepository) {
            return $accesoRepository->checkPermission('Ver Detalles de Evaluacion');
        });

        // --- GATES PARA EL MÓDULO DE ROL ---
        Gate::define('listar-rol', function ($user) use ($accesoRepository) {
            return $accesoRepository->checkPermission('Listar Rol');
        });
        Gate::define('editar-rol', function ($user) use ($accesoRepository) {
            return $accesoRepository->checkPermission('Editar Rol');
        });

        // --- GATES PARA EL MÓDULO DE BITACORA ---
        Gate::define('listar-bitacora', function ($user) use ($accesoRepository) {
            return $accesoRepository->checkPermission('Listar Bitacora');
        });
        Gate::define('ver-bitacora', function ($user) use ($accesoRepository) {
            return $accesoRepository->checkPermission('Ver Detalles de Bitacora');
        });

        // --- GATES PARA EL MÓDULO DE PLANIFICACIÓN ---
        Gate::define('listar-planificacion', function ($user) use ($accesoRepository) {
            return $accesoRepository->checkPermission('Listar Planificacion');
        });

        Gate::define('crear-planificacion', function ($user) use ($accesoRepository) {
            return $accesoRepository->checkPermission('Crear Planificacion');
        });

        Gate::define('editar-planificacion', function ($user) use ($accesoRepository) {
            return $accesoRepository->checkPermission('Editar Planificacion');
        });

        Gate::define('ver-planificacion', function ($user) use ($accesoRepository) {
            return $accesoRepository->checkPermission('Ver Detalles de Planificacion');
        });

        // ---------------------------------------------
        // NOTA: Si ya habías creado directivas personalizadas en AppServiceProvider (ej. @ifcoordinador),
        // y ahora vas a usar Gates (@can), puedes considerar eliminar esas directivas duplicadas para evitar redundancia.
    }
}
