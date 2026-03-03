<?php

namespace App\Repositories\Rol;

use Illuminate\Support\Facades\DB;

class RolIndexRepo
{
    public function listar($busqueda = '', $paginacion = 5)
    {
        // Registro automático de permisos al abrir el módulo
        $this->sincronizarAutonomamente();

        return DB::connection('pgsql_daece')
            ->table('rol')
            ->select('rol_codigo', 'rol_nombre', 'rol_estatus')
            ->when($busqueda, function ($consulta, $busqueda) {
                $consulta->where('rol_nombre', 'ILIKE', '%' . escapeshellcmd($busqueda) . '%')
                    ->orWhere('rol_nombre', 'LIKE', '%' . strtoupper($busqueda) . '%')
                    ->orWhere('rol_nombre', 'LIKE', '%' . strtolower($busqueda) . '%');
            })
            ->orderBy('rol_codigo', 'desc')
            ->paginate($paginacion);
    }

    /**
     * Sincroniza las rutas del sistema con la tabla de permisos automáticamente.
     */
    private function sincronizarAutonomamente()
    {
        try {
            $routes = \Illuminate\Support\Facades\Route::getRoutes();

            $accionesTraducidas = [
                'list' => 'Listar',
                'create' => 'Crear',
                'update' => 'Editar',
                'show' => 'Ver Detalles de',
                'reporte-general' => 'Reporte General de',
                'reporte-detalle' => 'Reporte Detallado de',
            ];

            $ignorados = ['_debugbar', '_ignition', 'livewire', 'sanctum', 'api', 'dashboard', 'profile', 'login', 'logout', 'register', 'password', '/', 'storage'];

            foreach ($routes as $route) {
                if (!in_array('GET', $route->methods()))
                    continue;

                $uri = $route->uri();
                $esValido = true;
                foreach ($ignorados as $ignorado) {
                    if (\Illuminate\Support\Str::startsWith($uri, $ignorado) || $uri === $ignorado) {
                        $esValido = false;
                        break;
                    }
                }

                if (!$esValido)
                    continue;

                $partes = explode('/', $uri);
                if (count($partes) < 2)
                    continue;

                $moduloSlug = $partes[0];
                $accionSlug = $partes[1];

                if (\Illuminate\Support\Str::contains($moduloSlug, '{') || \Illuminate\Support\Str::contains($accionSlug, '{'))
                    continue;

                $moduloNombre = \Illuminate\Support\Str::title(str_replace('-', ' ', $moduloSlug));
                $accionNombre = $accionesTraducidas[$accionSlug] ?? \Illuminate\Support\Str::title(str_replace('-', ' ', $accionSlug));
                $nombrePermiso = trim("{$accionNombre} {$moduloNombre}");

                $existe = DB::table('permiso')->where('nombre_permiso', $nombrePermiso)->exists();

                if (!$existe) {
                    DB::table('permiso')->insert([
                        'nombre_permiso' => $nombrePermiso,
                        'fecha_creacion' => \Carbon\Carbon::now(),
                        'estatus' => '1'
                    ]);
                }
            }
        } catch (\Exception $e) {
            // Silencioso para no romper la vista si falla algo en la sincronización
        }
    }
}
