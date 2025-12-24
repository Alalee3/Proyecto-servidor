<?php

namespace App\Livewire\Forms\Usuario;

use Livewire\Attributes\Validate;
use Livewire\Form;
use Illuminate\Validation\Rule;

class CreateUsuarioForm extends Form
{
    // ... (otras propiedades sin cambios, ej. name, apellido, cedula, email, password, password_confirmation, telefono) ...
    #[Validate('required|string|min:3|max:255')]
    public $name = '';

    #[Validate('required|string|min:3|max:255')]
    public $apellido = '';

    #[Validate('required|string|max:10|unique:users,cedula')]
    public $cedula = '';

    #[Validate('required|string|email|max:50|unique:users,email')]
    public $email = '';

    #[Validate('required|string|min:8|confirmed')]
    public $password = '';

    public $password_confirmation = '';

    #[Validate('nullable|string|max:20|unique:users,telefono')]
    public $telefono = '';


    // ¡¡¡CAMBIO CLAVE AQUÍ PARA selectedRoles!!!
    #[Validate(['required', 'array', 'min:1'])] // Ahora es un ARRAY de cadenas de reglas
    #[Validate('exists:roles,rol_id', as: 'roles seleccionados')] // Esta línea se mantiene igual
    public $selectedRoles = [];

    public array $messages = [
        'name.required' => 'El nombre es obligatorio.',
        'apellido.required' => 'El apellido es obligatorio.',
        'cedula.required' => 'La cédula es obligatoria.',
        'cedula.unique' => 'Ya existe un usuario con esta cédula.',
        'email.required' => 'El correo electrónico es obligatorio.',
        'email.email' => 'Debe ser un formato de correo electrónico válido.',
        'email.unique' => 'Ya existe un usuario con este correo electrónico.',
        'email.max' => 'El Email debe tener un maximo de 50 caracteres.',
        'password.required' => 'La contraseña es obligatoria.',
        'password.min' => 'La contraseña debe tener al menos 8 caracteres.',
        'password.confirmed' => 'La confirmación de contraseña no coincide.',
        'telefono.max' => 'El teléfono no debe exceder 10 caracteres.',
        'telefono.unique' => 'Ya existe un usuario con este teléfono.',
        'selectedRoles.required' => 'Debe seleccionar al menos un rol para el usuario.',
        'selectedRoles.min' => 'Debe seleccionar al menos un rol para el usuario.',
        'roles seleccionados.exists' => 'Uno o más roles seleccionados no son válidos.',
    ];
}
