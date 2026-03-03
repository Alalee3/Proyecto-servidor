<?php

namespace App\Repositories\Permiso;

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Str;
use Carbon\Carbon;

class PermisoIndexRepo
{
    public function listar($busqueda = '', $paginacion = 5)
    {
        // 1. Sincronización 100% Autónoma: Se ejecuta de forma silenciosa e imperceptible
        // justo antes de mostrar la lista de permisos en la pantalla.
        $this->sincronizarAutonomamente();

        return DB::table('permiso')
            ->select('id_permiso', 'nombre_permiso', 'fecha_creacion')
            ->when($busqueda, function ($consulta, $busqueda) {
                $consulta->where('nombre_permiso', 'LIKE', '%' . $busqueda . '%');
            })
            ->orderBy('id_permiso', 'desc')
            ->paginate($paginacion);
    }

    /**
     * Motor de Detección Autónoma de Módulos
     */
    private function sincronizarAutonomamente()
    {
        $routes = Route::getRoutes();

        // Diccionario de traducción para los permisos
        $accionesTraducidas = [
            'list' => 'Listar',
            'create' => 'Crear',
            'update' => 'Editar',
            'show' => 'Ver Detalles de',
            'reporte-general' => 'Reporte General de',
            'reporte-detalle' => 'Reporte Detallado de',
            'eliminar' => 'Eliminar',
            'gestionar' => 'Gestionar'
        ];

        // Se ignoran rutas del framework y aquellas genéricas
        $ignorados = ['_debugbar', '_ignition', 'livewire', 'sanctum', 'api', 'dashboard', 'profile', 'login', 'logout', 'register', 'password', '/', 'storage'];

        foreach ($routes as $route) {
            if (!in_array('GET', $route->methods())) {
                continue;
            }

            $uri = $route->uri();

            $esValido = true;
            foreach ($ignorados as $ignorado) {
                if (Str::startsWith($uri, $ignorado) || $uri === $ignorado) {
                    $esValido = false;
                    break;
                }
            }

            if (!$esValido) {
                continue;
            }

            $partes = explode('/', $uri);
            if (count($partes) < 2) {
                continue;
            }

            $moduloSlug = $partes[0];
            $accionSlug = $partes[1];

            if (Str::contains($moduloSlug, '{') || Str::contains($accionSlug, '{')) {
                continue;
            }

            $moduloNombre = Str::title(str_replace('-', ' ', $moduloSlug));
            $accionNombre = $accionesTraducidas[$accionSlug] ?? Str::title(str_replace('-', ' ', $accionSlug));
            $nombrePermiso = trim("{$accionNombre} {$moduloNombre}");

            // Verificamos de forma rápida si existe (la BD hace esto en microsegundos)
            $existe = DB::table('permiso')
                ->where('nombre_permiso', $nombrePermiso)
                ->exists();

            if (!$existe) {
                // Inserción silenciosa y automática del nuevo módulo detectado
                DB::table('permiso')->insert([
                    'nombre_permiso' => $nombrePermiso,
                    'fecha_creacion' => Carbon::now(),
                    'estatus' => '1'
                ]);
            }
        }
    }
}
