<?php

namespace App\Livewire\Forms\Estrategia;

use Livewire\Form;
use Illuminate\Validation\Rule;

class UpdateEstrategiaForm extends Form
{
    public $id_estrategia_pedagogica;
    public $nombre = '';

    protected function rules()
    {
        return [
            'nombre' => [
                'required',
                'string',
                'min:3',
                'regex:/^[A-Za-záéíóúÁÉÍÓÚñÑüÜ\\d\\s\\.,\\-\\(\\)\\\"\\\':\\/]+$/u',
                Rule::unique('tecnica_actividad', 'nombre_tecnica_actividad')->ignore($this->id_estrategia_pedagogica, 'id_tecnica_actividad')
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

    public function setForm($estrategia)
    {
        $this->id_estrategia_pedagogica = $estrategia->id_tecnica_actividad;
        $this->nombre = $estrategia->nombre_tecnica_actividad;
    }
}
