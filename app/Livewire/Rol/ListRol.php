<?php

namespace App\Livewire\Rol;

use Livewire\Component;
use Livewire\WithPagination;
use App\Repositories\Rol\RolIndexRepo;
use Illuminate\Support\Str;

class ListRol extends Component
{
    use WithPagination;

    public $busqueda = '';
    public $paginacion = 5;

    protected $rolRepository;

    /**
     * Inicialización del repositorio. 
     * Usamos boot() en lugar de __construct() para asegurar compatibilidad con Livewire 3.
     */
    public function boot()
    {
        $this->rolRepository = new RolIndexRepo();
    }

    /**
     * Orquestador de la sincronización: 
     * Lee rutas, procesa texto y pide al repositorio que guarde en BD.
     */
    private function sincronizarPermisos()
    {
        try {
            $webContent = file_get_contents(base_path('routes/web.php'));

            // Regex para buscar Route::get('uri', ...)
            preg_match_all("/Route::get\(['\"]([^'\"]+)['\"]/i", $webContent, $matches);
            $uris = array_unique($matches[1] ?? []);

            $accionesTraducidas = [
                'list' => 'Listar de',
                'create' => 'Crear de',
                'update' => 'Editar de',
                'show' => 'Ver Detalles de',
                'reporte-general' => 'Reporte General de',
                'reporte-detalle' => 'Reporte Detallado de',
            ];

            $ignorados = ['dashboard', 'profile', 'login', 'logout', 'register', 'password', '/', '#'];
            $permisosEncontrados = [];
            $modulosEncontrados = [];

            foreach ($uris as $uri) {
                // Limpiar parámetros {id} y separar en partes
                $uriLimpia = trim(preg_replace('/\{\w+\}/', '', $uri), '/');
                if (empty($uriLimpia))
                    continue;

                $partes = explode('/', $uriLimpia);
                $moduloSlug = $partes[0];

                if (in_array($moduloSlug, $ignorados))
                    continue;

                $accionSlug = $partes[1] ?? 'index';

                // Transformación de texto (Lógica de Negocio)
                $moduloNombre = Str::title(str_replace('-', ' ', $moduloSlug));
                $accionNombre = $accionesTraducidas[$accionSlug] ?? Str::title(str_replace('-', ' ', $accionSlug));

                // Forzamos el uso de ' de ' para asegurar la agrupación de módulos con nombres compuestos
                if (!str_ends_with(strtolower($accionNombre), ' de')) {
                    $accionNombre .= " de";
                }

                $nombrePermiso = trim("{$accionNombre} {$moduloNombre}");

                $permisosEncontrados[] = $nombrePermiso;

                // Delegar la persistencia al repositorio
                $this->rolRepository->upsertPermiso($nombrePermiso);

                // Guardamos el nombre del módulo en un array temporal para luego asignarle permisos que no dependen de rutas
                $modulosEncontrados[$moduloNombre] = true;
            }

            // Una vez que tenemos todos los módulos, generamos los permisos "virtuales" que no provienen de rutas
            foreach (array_keys($modulosEncontrados) as $moduloNombre) {
                // Generamos el permiso de Activación / Inactivación (Cabiar Estatus)
                $permisoEstatus = "Cambiar Estatus de {$moduloNombre}";

                // Lo añadimos a la lista para que no sea marcado como obsoleto
                $permisosEncontrados[] = $permisoEstatus;

                // Lo guardamos en BD
                $this->rolRepository->upsertPermiso($permisoEstatus);
            }

            // Delegar la limpieza al repositorio
            $this->rolRepository->inactivarObsoletos($permisosEncontrados);

        } catch (\Exception $e) {
            // Silencioso para no afectar la experiencia de usuario
        }
    }

    public function render()
    {
        // Sincronizamos antes de listar
        $this->sincronizarPermisos();

        $paginacionCorrecta = [5, 10, 25, 50];
        if (!in_array($this->paginacion, $paginacionCorrecta)) {
            $this->paginacion = 5;
        }

        $roles = $this->rolRepository->listar($this->busqueda, $this->paginacion);

        return view('livewire.pages.rol.list-rol', compact('roles'));
    }
}
