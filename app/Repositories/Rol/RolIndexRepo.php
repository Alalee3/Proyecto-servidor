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
            $webContent = file_get_contents(base_path('routes/web.php'));

            // Regex para buscar Route::get('uri', ...)
            // Captura tanto comillas simples como dobles
            preg_match_all("/Route::get\(['\"]([^'\"]+)['\"]/i", $webContent, $matches);
            $uris = array_unique($matches[1] ?? []);

            $accionesTraducidas = [
                'list' => 'Listar',
                'create' => 'Crear',
                'update' => 'Editar',
                'show' => 'Ver Detalles de',
                'reporte-general' => 'Reporte General de',
                'reporte-detalle' => 'Reporte Detallado de',
            ];

            $ignorados = ['dashboard', 'profile', 'login', 'logout', 'register', 'password', '/', '#'];
            $permisosEncontrados = [];

            foreach ($uris as $uri) {
                // Limpiar parámetros {id} para el slug
                $uriLimpia = preg_replace('/\{\w+\}/', '', $uri);
                $uriLimpia = trim($uriLimpia, '/');

                if (empty($uriLimpia))
                    continue;

                $partes = explode('/', $uriLimpia);
                $moduloSlug = $partes[0];

                // Si la URI es algo ignorado o empieza con algo ignorado
                if (in_array($moduloSlug, $ignorados))
                    continue;

                $accionSlug = $partes[1] ?? 'index';

                $moduloNombre = \Illuminate\Support\Str::title(str_replace('-', ' ', $moduloSlug));
                $accionNombre = $accionesTraducidas[$accionSlug] ?? \Illuminate\Support\Str::title(str_replace('-', ' ', $accionSlug));
                $nombrePermiso = trim("{$accionNombre} {$moduloNombre}");

                $permisosEncontrados[] = $nombrePermiso;

                $existe = DB::table('permiso')->where('nombre_permiso', $nombrePermiso)->first();

                if (!$existe) {
                    DB::table('permiso')->insert([
                        'nombre_permiso' => $nombrePermiso,
                        'fecha_creacion' => \Carbon\Carbon::now(),
                        'estatus' => '1'
                    ]);
                } else if ($existe->estatus == '0') {
                    // Si existía pero estaba inactivo, lo reactivamos si está en web.php
                    DB::table('permiso')->where('id_permiso', $existe->id_permiso)->update(['estatus' => '1']);
                }
            }

            // Inactivar permisos que NO estén en web.php (limpieza automática)
            if (!empty($permisosEncontrados)) {
                DB::table('permiso')
                    ->whereNotIn('nombre_permiso', $permisosEncontrados)
                    ->update(['estatus' => '0']);
            }

        } catch (\Exception $e) {
            // Silencioso para no romper la vista si falla algo en la sincronización
        }
    }
}
