<?php

namespace App\Livewire\Forms\Evento;

use Livewire\Form;
use Livewire\Attributes\Locked;

class UpdateEventoForm extends Form
{
    #[Locked]
    public $id_evento;

    public $id_calendario;
    public $dia_inicio_evento = '';
    public $dia_fin_evento = '';
    public $descripcion_evento = '';
    public $tipo_evento = '';

    protected function rules()
    {
        return [
            'id_calendario' => [
                'nullable',
                'integer'
            ],
            'dia_inicio_evento' => [
                'required',
                'date',
                function ($attribute, $value, $fail) {
                    $calendario = \Illuminate\Support\Facades\DB::table('calendario_academico')
                        ->where('id_calendario_academico', $this->id_calendario)
                        ->first();

                    if (!$calendario) {
                        $fail('No se encontró el calendario académico asociado para realizar la validación.');
                        return;
                    }

                    if ($value < $calendario->dia_inicio_calendario_academico || $value > $calendario->dia_fin_calendario_academico) {
                        $fail("La fecha de inicio debe estar dentro del rango del calendario asociado ({$calendario->dia_inicio_calendario_academico} al {$calendario->dia_fin_calendario_academico}).");
                    }
                }
            ],
            'dia_fin_evento' => [
                'required',
                'date',
                'after_or_equal:dia_inicio_evento',
                function ($attribute, $value, $fail) {
                    $calendario = \Illuminate\Support\Facades\DB::table('calendario_academico')
                        ->where('id_calendario_academico', $this->id_calendario)
                        ->first();

                    if (!$calendario) {
                        $fail('No se encontró el calendario académico asociado para realizar la validación.');
                        return;
                    }

                    if ($value < $calendario->dia_inicio_calendario_academico || $value > $calendario->dia_fin_calendario_academico) {
                        $fail("La fecha de fin debe estar dentro del rango del calendario asociado ({$calendario->dia_inicio_calendario_academico} al {$calendario->dia_fin_calendario_academico}).");
                    }
                }
            ],
            'descripcion_evento' => [
                'required',
                'string',
                'max:100',
                function ($attribute, $value, $fail) {
                    $repo = new \App\Repositories\Evento\EventoEditRepo();
                    if ($repo->existeEventoConDescripcion($value, (int) $this->id_calendario, (int) $this->id_evento)) {
                        $fail('Ya existe un evento con esta descripción en el mismo calendario.');
                    }
                },
                'regex:/^[A-Za-záéíóúÁÉÍÓÚñÑüÜ\d\s\.,\-\(\)\"\':\/]+$/u'
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
            'id_calendario.integer' => 'El calendario debe ser un número entero.',
            'dia_inicio_evento.required' => 'La fecha de inicio es obligatoria.',
            'dia_inicio_evento.date' => 'La fecha de inicio debe ser válida.',
            'dia_fin_evento.required' => 'La fecha de fin es obligatoria.',
            'dia_fin_evento.date' => 'La fecha de fin debe ser válida.',
            'dia_fin_evento.after_or_equal' => 'La fecha de fin debe ser igual o posterior a la de inicio.',
            'descripcion_evento.required' => 'La descripción es obligatoria.',
            'descripcion_evento.string' => 'La descripción debe ser texto.',
            'descripcion_evento.max' => 'La descripción no debe exceder 100 caracteres.',
            'descripcion_evento.regex' => 'Formato inválido en la descripción.',
            'tipo_evento.required' => 'El tipo de evento es obligatorio.',
            'tipo_evento.in' => 'El tipo de evento no es válido.',
        ];
    }

    public function setEvento($evento)
    {
        $this->id_evento = $evento->id_evento;
        $this->id_calendario = $evento->id_calendario;
        $this->dia_inicio_evento = $evento->dia_inicio_evento;
        $this->dia_fin_evento = $evento->dia_fin_evento;
        $this->descripcion_evento = $evento->descripcion_evento;
        $this->tipo_evento = $evento->tipo_evento;
    }
}
