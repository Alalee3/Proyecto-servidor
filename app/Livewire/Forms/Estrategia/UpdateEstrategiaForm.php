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
                Rule::unique('estrategia_pedagogica', 'nombre_estrategia_pedagogica')->ignore($this->id_estrategia_pedagogica, 'id_estrategia_pedagogica')
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
        $this->id_estrategia_pedagogica = $estrategia->id_estrategia_pedagogica;
        $this->nombre = $estrategia->nombre_estrategia_pedagogica;
    }
}
