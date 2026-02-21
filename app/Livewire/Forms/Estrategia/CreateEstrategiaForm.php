<?php

namespace App\Livewire\Forms\Estrategia;

use Livewire\Form;
use Illuminate\Validation\Rule;

class CreateEstrategiaForm extends Form
{
    public $nombre = '';

    protected function rules()
    {
        return [
            'nombre' => [
                'required',
                'string',
                'min:3',
                // Validación universal permitiendo caracteres especiales
                'regex:/^[A-Za-záéíóúÁÉÍÓÚñÑüÜ\\d\\s\\.,\\-\\(\\)\\\"\\\':\\/]+$/u',
                Rule::unique('tecnica_actividad', 'nombre_tecnica_actividad')
            ],
        ];
    }

    protected function messages()
    {
        return [
            'nombre.required' => 'La estrategia pedagógica es requerida.',
            'nombre.string' => 'La estrategia pedagógica debe ser texto.',
            'nombre.min' => 'La estrategia pedagógica debe tener al menos 3 caracteres.',
            'nombre.regex' => 'La estrategia pedagógica contiene caracteres no permitidos.',
            'nombre.unique' => 'Esta estrategia pedagógica ya ha sido registrada.',
        ];
    }
}
