<?php

namespace App\Livewire\Forms\Evento;

use Livewire\Form;

class CreateEventoForm extends Form
{
    public $id_color = '';
    public $descripcion_evento = '';
    public $tipo_evento = '1';
    public $especial_evento = '';
    public $is_especial = false;
    public $is_laborable = false;
    public $is_repetible = false;
    public $is_rango_dias = false;
    public $rango_dias = '';

    protected function rules()
    {
        return [
            'descripcion_evento' => [
                'required',
                'string',
                'max:100',
                function ($attribute, $value, $fail) {
                    $repo = new \App\Repositories\Evento\EventoCreateRepo();
                    if ($repo->existeEventoConDescripcion($value)) {
                        $fail('Ya existe un evento con esta descripción.');
                    }
                },
                'regex:/^[A-Za-záéíóúÁÉÍÓÚñÑüÜ\d\s\.,\-\(\)\"\':\/]+$/u'
            ],
            'tipo_evento' => [
                'required',
                'in:1,2,3,4,5',
                function ($attribute, $value, $fail) {
                    if ($this->is_especial) {
                        if (in_array($this->especial_evento, ['2', '3']) && $value != '4') {
                            $fail('Para este evento especial, el tipo de evento debe ser obligatoriamente Académico.');
                        } elseif ($this->especial_evento == '1' && $value != '5') {
                            $fail('Para Vacaciones Colectivas, el tipo de evento debe ser obligatoriamente Administrativo/Académico.');
                        }
                    }
                }
            ],
            'is_especial' => [
                'required',
                'boolean'
            ],
            'especial_evento' => [
                'required_if:is_especial,true',
                'nullable',
                'in:1,2,3'
            ],
            'is_laborable' => [
                'required',
                'boolean',
                function ($attribute, $value, $fail) {
                    if ($this->is_especial) {
                        if (in_array($this->especial_evento, ['2', '3']) && !$value) {
                            $fail('Para este evento especial, debe ser obligatoriamente Laborable.');
                        } elseif ($this->especial_evento == '1' && $value) {
                            $fail('Para Vacaciones Colectivas, no debe ser Laborable.');
                        }
                    }
                }
            ],
            'is_repetible' => [
                'required',
                'boolean',
                function ($attribute, $value, $fail) {
                    if ($this->is_especial) {
                        if (in_array($this->especial_evento, ['2', '3']) && !$value) {
                            $fail('Para este evento especial, debe ser obligatoriamente Repetible.');
                        } elseif ($this->especial_evento == '1' && !$value) {
                            $fail('Para Vacaciones Colectivas, debe ser obligatoriamente Repetible.');
                        }
                    }
                }
            ],
            'id_color' => [
                'required',
                'exists:color,id_color',
                function ($attribute, $value, $fail) {
                    $repo = new \App\Repositories\Evento\EventoCreateRepo();
                    if ($repo->existeColor($value)) {
                        $fail('Este color ya está asignado a otro evento activo.');
                    }
                }
            ],
            'is_rango_dias' => [
                'required',
                'boolean',
                function ($attribute, $value, $fail) {
                    if ($this->is_especial) {
                        if (in_array($this->especial_evento, ['2', '3']) && !$value) {
                            $fail('Para este evento especial, debe tener obligatoriamente cantidad específica de días.');
                        } elseif ($this->especial_evento == '1' && $value) {
                            $fail('Para Vacaciones Colectivas, no debe tener cantidad específica de días.');
                        }
                    }
                }
            ],
            'rango_dias' => [
                'required_if:is_rango_dias,true',
                'nullable',
                'integer',
                'min:1',
                'max:90',
                function ($attribute, $value, $fail) {
                    if ($this->is_especial) {
                        if (in_array($this->especial_evento, ['2', '3']) && $value != 1) {
                            $fail('Para este evento especial, la cantidad de días debe ser obligatoriamente 1.');
                        } elseif ($this->especial_evento == '1' && !empty($value)) {
                            $fail('Para Vacaciones Colectivas, no se debe definir cantidad de días.');
                        }
                    }
                }
            ],
        ];
    }

    protected function messages()
    {
        return [
            'descripcion_evento.required' => 'La descripción es obligatoria.',
            'descripcion_evento.string' => 'La descripción debe ser texto.',
            'descripcion_evento.max' => 'La descripción no debe exceder 100 caracteres.',
            'descripcion_evento.regex' => 'Formato inválido en la descripción.',
            'tipo_evento.required' => 'El tipo de evento es obligatorio.',
            'tipo_evento.in' => 'El tipo de evento no es válido.',
            'especial_evento.required_if' => 'Debe seleccionar qué tipo de evento especial es.',
            'especial_evento.in' => 'El evento especial seleccionado no es válido.',
            'id_color.required' => 'El color es obligatorio.',
            'id_color.exists' => 'El color seleccionado no es válido.',
            'is_laborable.boolean' => 'El valor de laborable debe ser booleano.',
            'is_repetible.boolean' => 'El valor de repetible debe ser booleano.',
            'is_rango_dias.boolean' => 'El valor de rango de días debe ser booleano.',
            'rango_dias.required_if' => 'La cantidad de días es obligatoria.',
            'rango_dias.integer' => 'La cantidad de días debe ser un número entero.',
            'rango_dias.min' => 'La cantidad de días debe ser al menos 1.',
            'rango_dias.max' => 'La cantidad de días no debe superar los 90 días.',
        ];
    }
}
