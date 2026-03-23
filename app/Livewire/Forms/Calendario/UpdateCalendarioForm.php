<?php

namespace App\Livewire\Forms\Calendario;

use Livewire\Form;
use Illuminate\Support\Facades\DB;

class UpdateCalendarioForm extends Form
{
    public $id_calendario_academico = '';
    public $semana_calendario_academico = '';
    public $dia_inicio_calendario_academico = '';
    public $dia_fin_calendario_academico = '';

    protected function rules()
    {
        return [
            'dia_inicio_calendario_academico' => [
                'required',
                'date',
            ],
            'dia_fin_calendario_academico' => [
                'required',
                'date',
                'after_or_equal:dia_inicio_calendario_academico',
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
        $this->semana_calendario_academico = $calendario->semana_calendario_academico;
        $this->dia_inicio_calendario_academico = $calendario->dia_inicio_calendario_academico;
        $this->dia_fin_calendario_academico = $calendario->dia_fin_calendario_academico;
    }
}
