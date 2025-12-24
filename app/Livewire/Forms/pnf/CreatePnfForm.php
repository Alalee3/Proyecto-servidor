<?php

namespace App\Livewire\Forms\pnf;

use Livewire\Form;
use Illuminate\Validation\Rule;

class CreatePnfForm extends Form
{
    public $nombre = '';

    protected function rules()
    {
        return [
            'nombre' => [
                'required',
                'string',
                'min:3',
                'max:100', // Máximo recomendado para textos cortos
                'regex:/^[A-Za-záéíóúÁÉÍÓÚñÑüÜ\s]+$/u', // Solo letras y espacios
                Rule::unique('pnf', 'nombre_pnf')
            ],
        ];
    }

    protected function messages()
    {
        return [
            'nombre.required' => 'El nombre del PNF es requerido.',
            'nombre.string' => 'El nombre del PNF debe ser texto.',
            'nombre.min' => 'El nombre del PNF debe tener al menos 3 caracteres.',
            'nombre.max' => 'El nombre del PNF no debe exceder los 100 caracteres.',
            'nombre.regex' => 'El nombre del PNF solo puede contener letras y espacios.',
            'nombre.unique' => 'Este PNF ya ha sido registrado.',
        ];
    }
}
