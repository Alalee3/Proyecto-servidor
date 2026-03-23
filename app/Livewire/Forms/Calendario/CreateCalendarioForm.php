<?php

namespace App\Livewire\Forms\Calendario;

use Livewire\Form;
use Illuminate\Support\Facades\DB;

class CreateCalendarioForm extends Form
{
    public $semana_calendario_academico = '';
    public $dia_inicio_calendario_academico = '';
    public $dia_fin_calendario_academico = '';

    protected function rules()
    {
        return [
            'dia_inicio_calendario_academico' => [
                'required',
                'date',
                function ($attribute, $value, $fail) {
                    $repo = new \App\Repositories\Calendario\CalendarioCreateRepo();
                    if ($repo->hayCalendarioActivo()) {
                        $fail('Ya existe un calendario activo configurado.');
                    }
                }
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
}
