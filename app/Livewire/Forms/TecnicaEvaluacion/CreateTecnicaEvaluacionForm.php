<?php

namespace App\Livewire\Forms\TecnicaEvaluacion;

use Livewire\Form;
use Illuminate\Validation\Rule;

class CreateTecnicaEvaluacionForm extends Form
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
                Rule::unique('tecnica_evaluacion', 'nombre_tecnica_evaluacion')
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
