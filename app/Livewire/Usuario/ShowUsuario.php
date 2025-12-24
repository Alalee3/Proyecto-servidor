<?php

namespace App\Livewire\Usuario; // Mantenemos tu namespace original

use Livewire\Component; // Aunque se extiende ModalComponent, Livewire\Component se importa a menudo
use LivewireUI\Modal\ModalComponent; // <--- Importamos ModalComponent
use App\Repositories\UsuarioRepository; // <--- Importamos tu repositorio de usuarios
use Exception; // Para el manejo de excepciones

class ShowUsuario extends ModalComponent // <--- Cambiamos la clase base a ModalComponent
{
    public $user; // Propiedad pública para almacenar el usuario a mostrar
    public $userId; // Propiedad pública para recibir el ID del usuario

    protected $usersRepository; // Propiedad para la instancia del repositorio

    /**
     * Constructor del componente.
     * Instancia el UsersRepository.
     */
    public function __construct()
    {
        // No es estrictamente necesario llamar a parent::__construct() aquí
        // a menos que estés extendiendo una clase con un constructor personalizado
        // que necesite ser llamado. Livewire lo maneja internamente.
        $this->usersRepository = new UsuarioRepository();
    }

    /**
     * Se ejecuta cuando el componente es montado.
     * Recibe el ID del usuario directamente cuando el modal es despachado.
     *
     * @param int $userId El ID del usuario a mostrar.
     */
    public function mount(int $userId)
    {
        $this->userId = $userId; // Almacena el ID en la propiedad pública si lo necesitas en la vista
        try {
            // Llama al método 'mostrar' de tu UsersRepository
            $this->user = $this->usersRepository->mostrar($userId);

            // Importante: Si el usuario no fue encontrado por el repositorio (retorna null),
            // debemos manejarlo, por ejemplo, cerrando el modal y notificando.
            if (is_null($this->user)) {
                $data = ['tipo' => 'warning', 'mensaje' => 'Usuario no encontrado.'];
                $this->dispatch('mostrar-mensaje', $data); // Despacha un mensaje de advertencia
                $this->closeModal(); // Cierra el modal si el usuario no existe
            }
        } catch (Exception $e) {
            // Captura cualquier excepción que pueda ocurrir durante la carga de datos
            $data = ['tipo' => 'error', 'mensaje' => 'Error al cargar el usuario.'];
            $this->dispatch('mostrar-mensaje', $data);
            $this->closeModal(); // Cierra el modal en caso de error
        }
    }

    /**
     * Renderiza la vista del componente.
     */
    public function render()
    {
        return view('livewire.usuario.show-usuario'); // Mantenemos tu ruta de vista original
    }

    /**
     * Opcional: Define las características del modal.
     * Puedes ajustar el tamaño del modal aquí.
     */
    public static function modalMaxWidth(): string
    {
        return 'xl'; // Opciones: sm, md, lg, xl, 2xl, etc. Ajusta según necesites.
    }

    /**
     * Opcional: Si quieres que el modal se cierre al hacer clic fuera de él.
     */
    public static function closeModalOnEscape(): bool
    {
        return true;
    }

    /**
     * Opcional: Si quieres que el modal se cierre al hacer clic en el fondo.
     */
    public static function closeModalOnClickAway(): bool
    {
        return true;
    }
}
