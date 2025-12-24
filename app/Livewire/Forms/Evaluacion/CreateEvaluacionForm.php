<?php

namespace App\Livewire\Forms\Evaluacion;

use Livewire\Form;
use Illuminate\Validation\Rule;

class CreateEvaluacionForm extends Form
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
                Rule::unique('evaluacion', 'nombre_evaluacion')
            ],
        ];
    }

    protected function messages()
    {
        return [
            'nombre.required' => 'La evaluación es requerida.',
            'nombre.string' => 'La evaluación debe ser texto.',
            'nombre.min' => 'La evaluación debe tener al menos 3 caracteres.',
            'nombre.regex' => 'La evaluación contiene caracteres no permitidos.',
            'nombre.unique' => 'Esta evaluación ya ha sido registrada.',
        ];
    }
}
