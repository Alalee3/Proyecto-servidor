<?php

namespace App\Livewire\Forms\Tecnica;

use Livewire\Form;
use Illuminate\Validation\Rule;

class CreateTecnicaForm extends Form
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
                Rule::unique('tecnica', 'nombre_tecnica')
            ],
        ];
    }

    protected function messages()
    {
        return [
            'nombre.required' => 'La técnica de evaluación es requerida.',
            'nombre.string' => 'La técnica de evaluación debe ser texto.',
            'nombre.min' => 'La técnica de evaluación debe tener al menos 3 caracteres.',
            'nombre.regex' => 'La técnica de evaluación contiene caracteres no permitidos.',
            'nombre.unique' => 'Esta técnica de evaluación ya ha sido registrada.',
        ];
    }
}
