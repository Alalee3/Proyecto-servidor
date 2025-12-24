<?php

namespace App\Livewire\Forms\Evaluacion;

use Livewire\Form;
use Illuminate\Validation\Rule;

class UpdateEvaluacionForm extends Form
{
    public $id_evaluacion;
    public $nombre = '';

    protected function rules()
    {
        return [
            'nombre' => [
                'required',
                'string',
                'min:3',
                'regex:/^[A-Za-záéíóúÁÉÍÓÚñÑüÜ\\d\\s\\.,\\-\\(\\)\\\"\\\':\\/]+$/u',
                Rule::unique('evaluacion', 'nombre_evaluacion')->ignore($this->id_evaluacion, 'id_evaluacion')
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

    public function setForm($evaluacion)
    {
        $this->id_evaluacion = $evaluacion->id_evaluacion;
        $this->nombre = $evaluacion->nombre_evaluacion;
    }
}
