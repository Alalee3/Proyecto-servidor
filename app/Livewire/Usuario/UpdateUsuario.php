<?php

namespace App\Livewire\Usuario;

// Importaciones necesarias
use App\Livewire\Forms\Usuario\UpadateUsuarioForm; // Tu Form Object, manteniendo el nombre
use App\Repositories\UsuarioRepository; // Tu repositorio de usuarios
use Exception;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\DB; // Para las operaciones directas en BD de roles
use Illuminate\Support\Facades\Log;
use LivewireUI\Modal\ModalComponent; // <--- ¡AQUÍ ESTÁ EL CAMBIO IMPORTANTE!

class UpdateUsuario extends ModalComponent // <--- Extiende ModalComponent
{
    protected $usuarioRepository;

    public UpadateUsuarioForm $form; // Instancia de tu Form Object, manteniendo el nombre

    public Collection $availableRoles; // Almacenará la lista de roles disponibles para el checkbox

    // Propiedad para mostrar el nombre del usuario en el modal
    public string $userName = '';

    public function __construct()
    {
        // Instancia el repositorio de usuarios
        $this->usuarioRepository = new UsuarioRepository();
    }

    /**
     * Se ejecuta cuando el componente es montado (cuando se abre el modal).
     * @param int $id El ID del usuario cuyos roles se van a editar.
     */
    public function mount(int $userId)
    {
        try {
            // 1. Obtener la información del usuario para mostrar su nombre en el modal
            $usuario = $this->usuarioRepository->mostrar($userId);

            if (!$usuario) {
                session()->flash('error', 'Usuario no encontrado para editar roles.');
                $this->closeModal();
                return;
            }

            $this->userName = $usuario->name . ' ' . $usuario->apellido;

            // 2. Cargar la lista de todos los roles disponibles desde tu repositorio
            $this->availableRoles = $this->usuarioRepository->select_roles();

            // 3. Asignar el ID del usuario al Form Object
            $this->form->userId = $usuario->id;

            // 4. Obtener los roles actuales del usuario desde la tabla pivote 'usuario_rol'
            //    (Esta lógica se mantiene aquí para no modificar el UsuarioRepository existente)
            $currentRoles = DB::table('usuario_rol')
                ->where('id_users', $usuario->id)
                ->where('estatus', 1) // Asumiendo que solo te interesan los roles activos
                ->pluck('id_rol')
                ->toArray();

            $this->form->selectedRoleIds = $currentRoles; // Asignar los IDs de los roles actuales al Form Object

            Log::info("Modal UpdateUsuario montado para usuario ID: {$usuario->id} ({$this->userName})", [
                'roles_actuales_ids_cargados' => $this->form->selectedRoleIds,
                'roles_disponibles_cargados' => $this->availableRoles->pluck('acceso', 'rol_id')->toArray()
            ]);
        } catch (Exception $e) {
            session()->flash('error', 'Error al cargar los datos de roles del usuario: ' . $e->getMessage());
            Log::error("Error montando UpdateUsuario modal para user ID {$userId}: " . $e->getMessage());
            $this->closeModal();
        }
    }

    /**
     * Guarda los cambios de roles del usuario.
     * Esta lógica reemplaza la función `syncRoles` en el repositorio para respetar la restricción.
     */
    public function saveRoles()
    {
        $this->form->validate(); // Valida el userId y los selectedRoleIds

        try {
            $userId = $this->form->userId;
            $newRoleIds = $this->form->selectedRoleIds;

            DB::beginTransaction();
            try {
                // Obtener los roles actuales del usuario (solo sus IDs y estatus)
                $currentRolesData = DB::table('usuario_rol')
                    ->where('id_users', $userId)
                    ->get(); // Obtenemos el objeto completo para saber el estatus actual

                $currentRoleIds = $currentRolesData->pluck('id_rol')->toArray();

                // Roles a añadir: están en $newRoleIds pero no en $currentRoleIds
                $rolesToAdd = array_diff($newRoleIds, $currentRoleIds);

                // Roles a desactivar: están en $currentRoleIds pero no en $newRoleIds,
                // Y su estatus actual es 1 (activo).
                $rolesToDeactivate = array_diff($currentRoleIds, $newRoleIds);
                $rolesToDeactivateActive = $currentRolesData->whereIn('id_rol', $rolesToDeactivate)
                    ->where('estatus', 1)
                    ->pluck('id_rol')
                    ->toArray();


                // --- Actualizar estatus a 1 (activo) para roles existentes que ahora están seleccionados ---
                foreach ($newRoleIds as $roleId) {
                    if (in_array($roleId, $currentRoleIds)) {
                        // Si el rol ya existe pero su estatus era diferente de 1 (ej. 2), lo activamos
                        $existingRoleEntry = $currentRolesData->firstWhere('id_rol', $roleId);
                        if ($existingRoleEntry && $existingRoleEntry->estatus !== 1) {
                            DB::table('usuario_rol')
                                ->where('id_users', $userId)
                                ->where('id_rol', $roleId)
                                ->update(['estatus' => 1]);
                        }
                    }
                }

                // --- Insertar los roles completamente nuevos (o que no tenían ninguna entrada) ---
                $insertData = [];
                foreach ($rolesToAdd as $roleId) {
                    // Solo insertamos si no existe NINGUNA entrada para este usuario y rol
                    $existingEntry = $currentRolesData->firstWhere('id_rol', $roleId);
                    if (!$existingEntry) {
                        $insertData[] = [
                            'id_users' => $userId,
                            'id_rol' => $roleId,
                            'estatus' => 1, // Nuevo rol, estatus activo
                        ];
                    }
                }
                if (!empty($insertData)) {
                    DB::table('usuario_rol')->insert($insertData);
                }

                // --- Desactivar los roles que ya no están en $newRoleIds y estaban activos ---
                if (!empty($rolesToDeactivateActive)) {
                    DB::table('usuario_rol')
                        ->where('id_users', $userId)
                        ->whereIn('id_rol', $rolesToDeactivateActive)
                        ->update(['estatus' => 2]); // O el estatus que uses para 'inactivo'
                }

                DB::commit(); // Confirmar la transacción
            } catch (Exception $e) {
                DB::rollBack(); // Revertir en caso de error
                throw $e; // Relanzar la excepción para que el catch externo la capture
            }

            $data = ['tipo' => 'exitoso', 'mensaje' => 'Usuario actualizado correctamente.'];
            $this->dispatch('mostrar-mensaje', $data);
            $this->dispatch('userUpdated'); // Dispara un evento para notificar a otros componentes
            $this->closeModal(); // Cierra el modal
        } catch (Exception $e) {
            $data = ['tipo' => 'error', 'mensaje' => 'Error inténtelo de nuevo.'];
            $this->dispatch('mostrar-mensaje', $data);
        }
    }

    public function render()
    {
        return view('livewire.usuario.update-usuario'); // Renderiza tu vista Blade existente
    }

    /**
     * Configuración de tamaño del modal.
     */
    public static function modalMaxWidth(): string
    {
        return 'md'; // Puedes ajustar el tamaño (sm, md, lg, xl, etc.)
    }

    /**
     * Permite o no cerrar el modal con la tecla ESC.
     */
    public static function closeModalOnEscape(): bool
    {
        return true;
    }

    /**
     * Permite o no cerrar el modal haciendo clic fuera.
     */
    public static function closeModalOnClickAway(): bool
    {
        return false;
    }
}
