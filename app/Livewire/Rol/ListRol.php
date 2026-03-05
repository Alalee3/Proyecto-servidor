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
                $nombrePermiso = trim("{$accionNombre} {$moduloNombre}");

                $permisosEncontrados[] = $nombrePermiso;

                // Delegar la persistencia al repositorio
                $this->rolRepository->upsertPermiso($nombrePermiso);
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
