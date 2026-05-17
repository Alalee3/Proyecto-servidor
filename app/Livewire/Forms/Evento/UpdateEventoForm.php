<?php

namespace App\Livewire\Forms\Evento;

use Livewire\Form;
use Livewire\Attributes\Locked;

class UpdateEventoForm extends Form
{
    #[Locked]
    public $id_evento = '';

    public $id_color = '';
    public $descripcion_evento = '';
    public $tipo_evento = '1';
    public $especial_evento = '';
    public $is_especial = false;
    public $is_laborable = false;
    public $is_repetible = false;
    public $is_rango_dias = false;
    public $rango_dias = '';
    public $is_independiente = false;
    public $cantidad_dias_evento = '';

    public function setEvento($evento)
    {
        $this->id_evento = $evento->id_evento;
        $this->descripcion_evento = $evento->nombre_evento;
        $this->tipo_evento = $evento->tipo_evento;
        $this->especial_evento = $evento->especial_evento ?? '';
        $this->is_especial = !empty($evento->especial_evento);
        $this->id_color = $evento->id_color;
        $this->is_laborable = (bool) $evento->is_laborable_evento;
        $this->is_repetible = (bool) $evento->is_repetible_evento;
        $this->is_rango_dias = (bool) $evento->is_rango_dias_evento;
        $this->rango_dias = $evento->rango_dias_evento;
        $this->is_independiente = (bool) ($evento->is_independiente ?? $evento->is_independiente_evento ?? false);
        $this->cantidad_dias_evento = $evento->cantidad_dias_evento;
    }

    protected function rules()
    {
        return [
            'cantidad_dias_evento' => [
                'nullable',
                function ($attribute, $value, $fail) {
                    if ($this->is_especial && $this->especial_evento == '1') {
                        if (empty($value) && $value !== '0' && $value !== 0) {
                            $fail('La cantidad de días de vacaciones es obligatoria.');
                        } elseif (!is_numeric($value) || $value < 1 || $value > 365) {
                            $fail('La cantidad de días de vacaciones debe ser un número entero entre 1 y 365.');
                        }
                    } else {
                        if (!empty($value) && $value !== '') {
                            $fail('No se permite asignar una cantidad de días de vacaciones para este tipo de evento.');
                        }
                    }
                }
            ],
            'is_independiente' => [
                'required',
                'boolean',
                function ($attribute, $value, $fail) {
                    if (in_array($this->tipo_evento, ['1', '2']) && !$value) {
                        $fail('Para los feriados nacionales y locales, el evento debe ser obligatoriamente Independiente.');
                    }
                    if ($this->is_especial && !$value) {
                        $fail('Para los eventos especiales, el evento debe ser obligatoriamente Independiente.');
                    }
                }
            ],
            'descripcion_evento' => [
                'required',
                'string',
                'max:100',
                function ($attribute, $value, $fail) {
                    $repo = new \App\Repositories\Evento\EventoUpdateRepo();
                    if ($repo->existeEventoConDescripcion($value, $this->id_evento)) {
                        $fail('Ya existe otro evento con esta descripción.');
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
            'is_especial' => ['required', 'boolean'],
            'especial_evento' => ['required_if:is_especial,true', 'nullable', 'in:1,2,3'],
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
                    $repo = new \App\Repositories\Evento\EventoUpdateRepo();
                    if ($repo->existeColor($value, $this->id_evento)) {
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
