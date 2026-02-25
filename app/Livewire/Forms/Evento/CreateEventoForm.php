<?php

namespace App\Livewire\Forms\Evento;

use Livewire\Form;

class CreateEventoForm extends Form
{
    public $id_calendario = '';
    public $dia_inicio_evento = '';
    public $dia_fin_evento = '';
    public $semana_evento = '';
    public $descripcion_evento = '';
    public $tipo_evento = '';

    protected function rules()
    {
        return [
            'id_calendario' => [
                'nullable',
                'integer',
                'exists:calendario_academico,id_calendario_academico'
            ],
            'dia_inicio_evento' => [
                'required',
                'date',
                function ($attribute, $value, $fail) {
                    $id_cal = $this->id_calendario;
                    if (empty($id_cal)) {
                        $activo = \Illuminate\Support\Facades\DB::table('calendario_academico')->where('estatus', '1')->first();
                        $id_cal = $activo ? $activo->id_calendario_academico : null;
                    }

                    if ($id_cal) {
                        $cal = \Illuminate\Support\Facades\DB::table('calendario_academico')->where('id_calendario_academico', $id_cal)->first();
                        if ($cal) {
                            if ($value < $cal->dia_inicio_calendario_academico || $value > $cal->dia_fin_calendario_academico) {
                                $fail("La fecha de inicio debe estar entre {$cal->dia_inicio_calendario_academico} y {$cal->dia_fin_calendario_academico}.");
                            }
                        }
                    }
                }
            ],
            'dia_fin_evento' => [
                'required',
                'date',
                'after_or_equal:dia_inicio_evento',
                function ($attribute, $value, $fail) {
                    $id_cal = $this->id_calendario;
                    if (empty($id_cal)) {
                        $activo = \Illuminate\Support\Facades\DB::table('calendario_academico')->where('estatus', '1')->first();
                        $id_cal = $activo ? $activo->id_calendario_academico : null;
                    }

                    if ($id_cal) {
                        $cal = \Illuminate\Support\Facades\DB::table('calendario_academico')->where('id_calendario_academico', $id_cal)->first();
                        if ($cal) {
                            if ($value < $cal->dia_inicio_calendario_academico || $value > $cal->dia_fin_calendario_academico) {
                                $fail("La fecha de fin debe estar entre {$cal->dia_inicio_calendario_academico} y {$cal->dia_fin_calendario_academico}.");
                            }
                        }
                    }
                }
            ],
            'semana_evento' => [
                'required',
                'integer',
                'min:1',
                function ($attribute, $value, $fail) {
                    $id_cal = $this->id_calendario;
                    if (empty($id_cal)) {
                        $activo = \Illuminate\Support\Facades\DB::table('calendario_academico')->where('estatus', '1')->first();
                        $id_cal = $activo ? $activo->id_calendario_academico : null;
                    }

                    if ($id_cal) {
                        $calRecord = \Illuminate\Support\Facades\DB::table('calendario_academico')->where('id_calendario_academico', $id_cal)->first();
                        if ($calRecord) {
                            $maxSemana = \Illuminate\Support\Facades\DB::table('calendario_academico')
                                ->where('id_lapso_academico', $calRecord->id_lapso_academico)
                                ->max('semana_calendario_academico');

                            if ($maxSemana && $value > $maxSemana) {
                                $fail("La semana del evento ($value) no puede ser superior a la duración en semanas establecida en el calendario ($maxSemana).");
                            }
                        }
                    }
                }
            ],
            'descripcion_evento' => [
                'required',
                'string',
                'max:100',
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
            'id_calendario.exists' => 'El calendario seleccionado no existe.',
            'dia_inicio_evento.required' => 'La fecha de inicio es obligatoria.',
            'dia_inicio_evento.date' => 'La fecha de inicio debe ser válida.',
            'dia_fin_evento.required' => 'La fecha de fin es obligatoria.',
            'dia_fin_evento.date' => 'La fecha de fin debe ser válida.',
            'dia_fin_evento.after_or_equal' => 'La fecha de fin debe ser igual o posterior a la de inicio.',
            'semana_evento.required' => 'La semana es obligatoria.',
            'semana_evento.integer' => 'La semana debe ser un número.',
            'semana_evento.min' => 'La semana mínima es 1.',
            'semana_evento.max' => 'La semana máxima es 52.',
            'descripcion_evento.required' => 'La descripción es obligatoria.',
            'descripcion_evento.string' => 'La descripción debe ser texto.',
            'descripcion_evento.max' => 'La descripción no debe exceder 100 caracteres.',
            'descripcion_evento.regex' => 'Formato inválido en la descripción.',
            'tipo_evento.required' => 'El tipo de evento es obligatorio.',
            'tipo_evento.in' => 'El tipo de evento no es válido.',
        ];
    }
}
