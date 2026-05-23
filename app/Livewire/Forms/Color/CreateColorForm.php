<?php

namespace App\Livewire\Forms\Color;

use Livewire\Form;
use Illuminate\Validation\Rule;

class CreateColorForm extends Form
{
    public $nombre_color = '';
    public $codigo_color = '#000000';

    protected function rules()
    {
        return [
            'nombre_color' => [
                'required',
                'string',
                'max:100',
                'regex:/^[A-Za-záéíóúÁÉÍÓÚñÑüÜ\d\s]+$/u',
                Rule::unique('color', 'nombre_color')
            ],
            'codigo_color' => [
                'required',
                'string',
                'size:7',
                'regex:/^#[a-fA-F0-9]{6}$/',
                Rule::unique('color', 'codigo_color')
            ],
        ];
    }

    protected function messages()
    {
        return [
            'nombre_color.required' => 'El nombre del color es obligatorio.',
            'nombre_color.max' => 'El nombre del color no debe exceder 100 caracteres.',
            'nombre_color.regex' => 'El formato del nombre del color no es válido.',
            'nombre_color.unique' => 'Ya existe un color con este nombre.',
            'codigo_color.required' => 'El código de color es obligatorio.',
            'codigo_color.size' => 'El código de color debe tener 7 caracteres (ej: #FF0000).',
            'codigo_color.regex' => 'El formato del código de color debe ser hexadecimal.',
            'codigo_color.unique' => 'Ya existe un color con este código hexadecimal.',
        ];
    }
}
