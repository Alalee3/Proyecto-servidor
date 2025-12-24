<?php

namespace App\Livewire\Forms\Usuario;

use Livewire\Attributes\Validate;
use Livewire\Form;
use Illuminate\Validation\Rule;

class UpadateUsuarioForm extends Form
{
    public ?int $userId = null;

    // *** CAMBIO AQUÍ ***
    #[Validate(['nullable', 'array', 'min:0'])] // Corregido el atributo Validate
    public array $selectedRoleIds = [];

    public function rules(): array
    {
        return [
            'userId' => ['required', 'integer', 'exists:users,id'],
            'selectedRoleIds.*' => ['integer', Rule::exists('roles', 'rol_id')],
        ];
    }

    public function messages(): array
    {
        return [
            'userId.required' => 'El ID de usuario es obligatorio.',
            'userId.integer' => 'El ID de usuario debe ser un número entero.',
            'userId.exists' => 'El usuario especificado no existe.',
            'selectedRoleIds.array' => 'Los roles seleccionados deben ser un formato de lista válido.',
            'selectedRoleIds.*.integer' => 'Cada rol debe ser un número entero.',
            'selectedRoleIds.*.exists' => 'Uno de los roles seleccionados no es válido.',
        ];
    }
}
