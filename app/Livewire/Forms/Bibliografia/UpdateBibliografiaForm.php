<?php

namespace App\Livewire\Forms\Bibliografia;

use Livewire\Form;
use Illuminate\Validation\Rule;

class UpdateBibliografiaForm extends Form
{
    public $id_bibliografia;
    public $nombre = '';

    protected function rules()
    {
        return [
            'nombre' => [
                'required',
                'string',
                'min:3',
                // Validación para permitir caracteres especiales comunes en bibliografías
                'regex:/^[A-Za-záéíóúÁÉÍÓÚñÑüÜ\d\s\.,\-\(\)\"\':\/]+$/u',
                Rule::unique('bibliografia', 'nombre_bibliografia')->ignore($this->id_bibliografia, 'id_bibliografia')
            ],
        ];
    }

    protected function messages()
    {
        return [
            'nombre.required' => 'La bibliografía es requerida.',
            'nombre.string' => 'La bibliografía debe ser texto.',
            'nombre.min' => 'La bibliografía debe tener al menos 3 caracteres.',
            'nombre.regex' => 'La bibliografía contiene caracteres no permitidos.',
            'nombre.unique' => 'Esta bibliografía ya ha sido registrada.',
        ];
    }

    public function setForm($bibliografia)
    {
        $this->id_bibliografia = $bibliografia->id_bibliografia;
        $this->nombre = $bibliografia->nombre_bibliografia;
    }
}
