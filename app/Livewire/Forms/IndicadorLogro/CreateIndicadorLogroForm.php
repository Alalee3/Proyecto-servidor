<?php

namespace App\Livewire\Forms\IndicadorLogro;

use Illuminate\Validation\Rule;
use Livewire\Form;

class CreateIndicadorLogroForm extends Form
{
    public $nombre_indicador_logro = '';

    protected function rules()
    {
        return [
            'nombre_indicador_logro' => [
                'required',
                'string',
                'min:3',
                'max:255',
                'regex:/^[A-Za-záéíóúÁÉÍÓÚñÑüÜ\s0-9\.\,]+$/u',
                Rule::unique('indicador_logro', 'nombre_indicador_logro')
            ],
        ];
    }

    protected function messages()
    {
        return [
            'nombre_indicador_logro.required' => 'El nombre del indicador es requerido.',
            'nombre_indicador_logro.string' => 'El nombre del indicador debe ser texto.',
            'nombre_indicador_logro.min' => 'El nombre del indicador debe tener al menos 3 caracteres.',
            'nombre_indicador_logro.max' => 'El nombre del indicador no debe exceder los 255 caracteres.',
            'nombre_indicador_logro.regex' => 'El nombre del indicador solo permite letras, números y puntuación básica.',
            'nombre_indicador_logro.unique' => 'Este indicador ya ha sido registrado.',
        ];
    }

    protected function validationAttributes()
    {
        return [
            'nombre_indicador_logro' => 'Nombre del Indicador',
        ];
    }

    public function values()
    {
        return [
            'nombre_indicador_logro' => trim($this->nombre_indicador_logro),
        ];
    }
}
