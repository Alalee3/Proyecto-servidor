<?php

namespace App\Livewire\Forms\Calendario;

use Livewire\Form;
use Illuminate\Support\Facades\DB;

class CreateCalendarioForm extends Form
{
    public $id_lapso_academico = '';
    public $semana_calendario_academico = '';
    public $dia_inicio_calendario_academico = '';
    public $dia_fin_calendario_academico = '';

    protected function rules()
    {
        return [
            'id_lapso_academico' => [
                'nullable',
                'integer'
            ],
            'semana_calendario_academico' => [
                'required',
                'integer',
                'min:1',
                'max:52',
                function ($attribute, $value, $fail) {
                    $id_lapso = $this->id_lapso_academico;
                    if (empty($id_lapso)) {
                        $activo = DB::connection('pgsql_daece')->table('lapso_academico')->where('lap_estatus', 'A')->where('lap_cerrado', 'N')->first();
                        $id_lapso = $activo ? $activo->lap_codigo : null;
                    }

                    if ($id_lapso) {
                        $repo = new \App\Repositories\Calendario\CalendarioCreateRepo();
                        if ($repo->existeCalendarioEnSemana((int) $value, (int) $id_lapso)) {
                            $fail('Ya existe una semana configurada para este lapso.');
                        }
                    }
                }
            ],
            'dia_inicio_calendario_academico' => [
                'required',
                'date',
                function ($attribute, $value, $fail) {
                    $id_lapso = $this->id_lapso_academico;
                    if (empty($id_lapso)) {
                        $activo = DB::connection('pgsql_daece')->table('lapso_academico')->where('lap_estatus', 'A')->where('lap_cerrado', 'N')->first();
                        $id_lapso = $activo ? $activo->lap_codigo : null;
                    }

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
                    $id_lapso = $this->id_lapso_academico;
                    if (empty($id_lapso)) {
                        $activo = DB::connection('pgsql_daece')->table('lapso_academico')->where('lap_estatus', 'A')->where('lap_cerrado', 'N')->first();
                        $id_lapso = $activo ? $activo->lap_codigo : null;
                    }

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
            'semana_calendario_academico.required' => 'La semana es obligatoria.',
            'semana_calendario_academico.integer' => 'La semana debe ser un número entero.',
            'dia_inicio_calendario_academico.required' => 'La fecha de inicio es obligatoria.',
            'dia_inicio_calendario_academico.date' => 'La fecha de inicio debe ser válida.',
            'dia_fin_calendario_academico.required' => 'La fecha de fin es obligatoria.',
            'dia_fin_calendario_academico.date' => 'La fecha de fin debe ser válida.',
            'dia_fin_calendario_academico.after_or_equal' => 'La fecha de fin debe ser igual o posterior a la de inicio.',
        ];
    }
}
