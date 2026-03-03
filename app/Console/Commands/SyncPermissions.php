<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Carbon\Carbon;

class SyncPermissions extends Command
{
    /**
     * El nombre y la firma del comando.
     *
     * @var string
     */
    protected $signature = 'permisos:sincronizar';

    /**
     * La descripción del comando.
     *
     * @var string
     */
    protected $description = 'Sincroniza dinámicamente las rutas del sistema y genera los permisos correspondientes en la BD si no existen.';

    /**
     * Ejecuta el comando de consola.
     */
    public function handle()
    {
        $this->info('Iniciando escaneo de rutas (Buscando permisos)...');

        $routes = Route::getRoutes();
        $permisosGenerados = 0;

        // Diccionario de traducción para hacer los nombres más legibles en español
        $accionesTraducidas = [
            'list' => 'Listar',
            'create' => 'Crear',
            'update' => 'Editar',
            'show' => 'Ver Detalles de',
            'reporte-general' => 'Reporte General de',
            'reporte-detalle' => 'Reporte Detallado de',
        ];

        // Rutas base, herramientas internas o protegidas por autenticación básica que no requieren permisos de módulos
        $ignorados = [
            '_debugbar',
            '_ignition',
            'livewire',
            'sanctum',
            'api',
            'dashboard',
            'profile',
            'login',
            'logout',
            'register',
            'password',
            '/',
            'storage'
        ];

        foreach ($routes as $route) {
            // Un permiso suele representar una Vista o una Acción, nos basamos en los métodos GET registrados
            if (!in_array('GET', $route->methods())) {
                continue;
            }

            $uri = $route->uri();

            // Filtrar ignorados
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

            // Procesamos la URI. Ejemplo: 'contenido/update/{id}' -> se convierte en ['contenido', 'update', '{id}']
            $partes = explode('/', $uri);
            if (count($partes) < 2) {
                continue; // Ignoramos URIs de 1 solo nivel que no sean módulos estandarizados
            }

            $moduloSlug = $partes[0];
            $accionSlug = $partes[1];

            // Ignoramos variables de ruta inyectadas en las dos primeras partes (ej: cosas raras o fallos)
            if (Str::contains($moduloSlug, '{') || Str::contains($accionSlug, '{')) {
                continue;
            }

            // Traducimos el módulo (ej: indicador-logro -> Indicador Logro)
            $moduloNombre = Str::title(str_replace('-', ' ', $moduloSlug));

            // Traducimos la acción desde nuestro diccionario (o la normalizamos si no existe en el diccionaro)
            $accionNombre = $accionesTraducidas[$accionSlug] ?? Str::title(str_replace('-', ' ', $accionSlug));

            // Formamos el Nombre Final del Permiso (Ej: "Editar Contenido")
            $nombrePermiso = trim("{$accionNombre} {$moduloNombre}");

            // Verificamos si el permiso ya existe en la base de datos principal
            $existe = DB::table('permiso')
                ->where('nombre_permiso', $nombrePermiso)
                ->exists();

            if (!$existe) {
                // Insertamos el nuevo permiso detectado
                DB::table('permiso')->insert([
                    'nombre_permiso' => $nombrePermiso,
                    'fecha_creacion' => Carbon::now(),
                    'estatus' => '1'
                ]);
                $this->line("- Insertado: <fg=green>{$nombrePermiso}</>");
                $permisosGenerados++;
            }
        }

        $this->info("Escaneo finalizado. Se generaron {$permisosGenerados} permisos nuevos hacia la base de datos.");
    }
}
