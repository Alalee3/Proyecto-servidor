<?php

namespace App\Livewire\Forms\CalendarioAcademico;

use Livewire\Form;

class CreateCalendarioAcademicoForm extends Form
{
    public $id_lapso_academico = '';
    public $semana_calendario_academico = '';
    public $dia_inicio_calendario_academico = '';
    public $dia_fin_calendario_academico = '';

    protected function rules()
    {
        return [
            'id_lapso_academico' => 'required|exists:lapso_academico,id_lapso_academico',
            'semana_calendario_academico' => 'required|integer|min:1|max:52',
            'dia_inicio_calendario_academico' => 'required|date',
            'dia_fin_calendario_academico' => 'required|date|after_or_equal:dia_inicio_calendario_academico',
        ];
    }

    protected function messages()
    {
        return [
            'id_lapso_academico.required' => 'El lapso académico es obligatorio.',
            'id_lapso_academico.exists' => 'El lapso académico seleccionado no es válido.',
            'semana_calendario_academico.required' => 'La semana es obligatoria.',
            'semana_calendario_academico.integer' => 'La semana debe ser un número entero.',
            'semana_calendario_academico.min' => 'La semana mínima es 1.',
            'semana_calendario_academico.max' => 'La semana máxima es 52.',
            'dia_inicio_calendario_academico.required' => 'La fecha de inicio es obligatoria.',
            'dia_inicio_calendario_academico.date' => 'La fecha de inicio debe ser una fecha válida.',
            'dia_fin_calendario_academico.required' => 'La fecha de fin es obligatoria.',
            'dia_fin_calendario_academico.date' => 'La fecha de fin debe ser una fecha válida.',
            'dia_fin_calendario_academico.after_or_equal' => 'La fecha de fin debe ser igual o posterior a la fecha de inicio.',
        ];
    }
}
