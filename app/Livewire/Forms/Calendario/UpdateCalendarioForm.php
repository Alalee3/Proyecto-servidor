<?php

namespace App\Livewire\Forms\Calendario;

use Livewire\Form;
use Illuminate\Support\Facades\DB;

class UpdateCalendarioForm extends Form
{
    public $id_calendario_academico = '';
    public $id_lapso_academico = '';
    public $semana_calendario_academico = '';
    public $dia_inicio_calendario_academico = '';
    public $dia_fin_calendario_academico = '';

    protected function rules()
    {
        return [
            'id_lapso_academico' => [
                'required',
                'integer'
            ],
            'dia_inicio_calendario_academico' => [
                'required',
                'date',
                function ($attribute, $value, $fail) {
                    $id_lapso = (int) $this->id_lapso_academico;
                    if ($id_lapso) {
                        $lapso = DB::connection('pgsql_daece')->table('lapso_academico')->where('lap_codigo', $id_lapso)->first();
                        if ($lapso) {
                            if ($value < $lapso->lap_fecha_inicio || $value > $lapso->lap_fecha_fin) {
                                $fail("La fecha de inicio debe estar entre {$lapso->lap_fecha_inicio} y {$lapso->lap_fecha_fin}.");
                            }
                        }
                    }
                }
            ],
            'dia_fin_calendario_academico' => [
                'required',
                'date',
                'after_or_equal:dia_inicio_calendario_academico',
                function ($attribute, $value, $fail) {
                    $id_lapso = (int) $this->id_lapso_academico;
                    if ($id_lapso) {
                        $lapso = DB::connection('pgsql_daece')->table('lapso_academico')->where('lap_codigo', $id_lapso)->first();
                        if ($lapso) {
                            if ($value < $lapso->lap_fecha_inicio || $value > $lapso->lap_fecha_fin) {
                                $fail("La fecha de fin debe estar entre {$lapso->lap_fecha_inicio} y {$lapso->lap_fecha_fin}.");
                            }
                        }
                    }
                }
            ],
        ];
    }

    protected function messages()
    {
        return [
            'dia_inicio_calendario_academico.required' => 'La fecha de inicio es obligatoria.',
            'dia_inicio_calendario_academico.date' => 'La fecha de inicio debe ser válida.',
            'dia_fin_calendario_academico.required' => 'La fecha de fin es obligatoria.',
            'dia_fin_calendario_academico.date' => 'La fecha de fin debe ser válida.',
            'dia_fin_calendario_academico.after_or_equal' => 'La fecha de fin debe ser igual o posterior a la de inicio.',
        ];
    }

    public function setCalendario($calendario)
    {
        $this->id_calendario_academico = $calendario->id_calendario_academico;
        $this->id_lapso_academico = $calendario->id_lapso_academico;
        $this->semana_calendario_academico = $calendario->semana_calendario_academico;
        $this->dia_inicio_calendario_academico = $calendario->dia_inicio_calendario_academico;
        $this->dia_fin_calendario_academico = $calendario->dia_fin_calendario_academico;
    }
}
