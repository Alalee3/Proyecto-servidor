<?php

namespace App\Livewire\Forms\Pnf;

use Livewire\Form;
use Illuminate\Validation\Rule;
use Livewire\Attributes\Locked;

class UpdatePnfForm extends Form
{
    public $nombre = '';

    public $id; // ID bloqueado para seguridad

    protected function rules()
    {
        return [
            'nombre' => [
                'required',
                'string',
                'min:3',
                'max:255',
                'regex:/^[\pL\s]+$/u', // Solo letras y espacios
                Rule::unique('pnf', 'nombre_pnf')->ignore($this->id, 'id_pnf'),
            ],
        ];
    }

    protected function messages()
    {
        return [
            'nombre.required' => 'El nombre del PNF es obligatorio.',
            'nombre.string' => 'El nombre del PNF debe ser texto.',
            'nombre.min' => 'El nombre del PNF debe tener al menos 3 letras.',
            'nombre.max' => 'El nombre del PNF no debe exceder los 255 caracteres.',
            'nombre.regex' => 'El nombre del PNF solo puede contener letras y espacios.',
            'nombre.unique' => 'Este PNF ya ha sido registrado.',
        ];
    }
}
