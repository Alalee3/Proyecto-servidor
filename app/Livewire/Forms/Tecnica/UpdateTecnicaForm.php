<?php

namespace App\Livewire\Forms\Tecnica;

use Livewire\Form;
use Illuminate\Validation\Rule;

class UpdateTecnicaForm extends Form
{
    public $id_tecnica;
    public $nombre = '';

    protected function rules()
    {
        return [
            'nombre' => [
                'required',
                'string',
                'min:3',
                'regex:/^[A-Za-záéíóúÁÉÍÓÚñÑüÜ\\d\\s\\.,\\-\\(\\)\\\"\\\':\\/]+$/u',
                Rule::unique('tecnica', 'nombre_tecnica')->ignore($this->id_tecnica, 'id_tecnica')
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

    public function setForm($tecnica)
    {
        $this->id_tecnica = $tecnica->id_tecnica;
        $this->nombre = $tecnica->nombre_tecnica;
    }
}
