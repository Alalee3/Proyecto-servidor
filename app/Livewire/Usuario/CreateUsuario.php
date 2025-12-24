<?php

namespace App\Livewire\Usuario;

use App\Livewire\Forms\Usuario\CreateUsuarioForm;
use App\Repositories\UsuarioRepository;
use Livewire\Component;

use Exception;
use Illuminate\Support\Facades\Hash;

class CreateUsuario extends Component
{

    // Instanciar tu Livewire Form. Livewire lo inicializará automáticamente.
    public CreateUsuarioForm $form; // ¡Esto es clave!

    public $allRoles = []; // Seguirá siendo una propiedad del componente para cargar opciones

    protected $usuarioRepository;

    public function __construct()
    {
        $this->usuarioRepository = new UsuarioRepository();
    }

    /**
     * Método `mount()`: Se ejecuta una vez cuando el componente es inicializado.
     */
    public function mount()
    {

        // Cargar los roles disponibles usando la función del repositorio
        try {
            $this->allRoles = $this->usuarioRepository->select_roles()->toArray();
        } catch (Exception $e) {
            $this->dispatch('mostrar-mensaje', ['tipo' => 'error', 'mensaje' => 'No se pudieron cargar los roles disponibles.']);
        }
    }

    /**
     * El método `rules()` y la propiedad `$messages` se han movido a CreateUsuarioForm.
     * No necesitas definirlos aquí en el componente si están en el Form.
     */

    public function updated($propertyName)
    {
        $field = str_replace('form.', '', $propertyName);
        $this->form->validateOnly($field);
    }
    /**
     * Método que se ejecuta al enviar el formulario para guardar el usuario.
     */
    public function save()
    {
        // 1. Ejecutar la validación directamente en el objeto form
        $this->form->validate(); // Esto ejecutará las reglas definidas en CreateUsuarioForm

        try {
            // 2. Encriptar la contraseña obteniéndola del objeto form
            $hashedPassword = Hash::make($this->form->password);

            // 3. Preparar los datos del usuario para el repositorio, obteniéndolos del objeto form
            $userData = [
                'name' => $this->form->name,
                'apellido' => $this->form->apellido,
                'cedula' => $this->form->cedula,
                'email' => $this->form->email,
                'password' => $hashedPassword, // Contraseña ya hasheada
                'telefono' => $this->form->telefono,
            ];

            // 4. Llamar al método 'crear' de tu UsersRepository, pasando los selectedRoles del form
            $this->usuarioRepository->crear($userData, $this->form->selectedRoles);


            $this->form->reset();
            // 5. Si la creación fue exitosa
            $data = ['tipo' => 'exitoso', 'mensaje' => 'Usuario creado correctamente.'];
            $this->dispatch('mostrar-mensaje', $data);
        } catch (Exception $e) {
            // En caso de error, dispara un evento para mostrar un mensaje de error
            $data = ['tipo' => 'error', 'mensaje' => 'Error inténtelo de nuevo.'];
            $this->dispatch('mostrar-mensaje', $data);
        }
    }

    public function render()
    {
        return view('livewire.usuario.create-usuario');
    }
}
