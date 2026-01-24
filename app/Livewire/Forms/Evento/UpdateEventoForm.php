<?php

namespace App\Livewire\Forms\Evento;

use Livewire\Form;
use Livewire\Attributes\Locked;

class UpdateEventoForm extends Form
{
    #[Locked]
    public $id_evento;

    public $descripcion_evento = '';
    public $fecha_evento = '';
    public $tipo_evento = '';

    protected function rules()
    {
        return [
            'descripcion_evento' => [
                'required',
                'string',
                'max:100',
                'regex:/^[A-Za-záéíóúÁÉÍÓÚñÑüÜ\d\s\.,\-\(\)\"\':\/]+$/u'
            ],
            'fecha_evento' => [
                'required',
                'date'
            ],
            'tipo_evento' => [
                'required',
                'in:1,2,3'
            ],
        ];
    }

    protected function messages()
    {
        return [
            'descripcion_evento.required' => 'La descripción del evento es obligatoria.',
            'descripcion_evento.string' => 'La descripción debe ser texto.',
            'descripcion_evento.max' => 'La descripción no debe exceder los 100 caracteres.',
            'descripcion_evento.regex' => 'Formato inválido en la descripción.',
            'fecha_evento.required' => 'La fecha del evento es obligatoria.',
            'fecha_evento.date' => 'La fecha debe ser válida.',
            'tipo_evento.required' => 'El tipo de evento es obligatorio.',
            'tipo_evento.in' => 'El tipo de evento seleccionado no es válido.',
        ];
    }
}
