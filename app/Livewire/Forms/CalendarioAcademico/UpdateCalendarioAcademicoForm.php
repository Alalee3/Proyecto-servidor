<?php

namespace App\Livewire\Forms\CalendarioAcademico;

use Livewire\Form;
use Livewire\Attributes\Locked;

class UpdateCalendarioAcademicoForm extends Form
{
    #[Locked]
    public $id_calendario_academico;

    public $id_lapso_academico = '';
    public $semana = '';
    public $dia_inicio = '';
    public $dia_fin = '';
    public $carga_corte = '';

    protected function rules()
    {
        return [
            'id_lapso_academico' => [
                'required',
                'exists:lapso_academico,id_lapso_academico'
            ],
            'semana' => [
                'required',
                'integer',
                'min:1'
            ],
            'dia_inicio' => [
                'required',
                'date'
            ],
            'dia_fin' => [
                'required',
                'date',
                'after_or_equal:dia_inicio'
            ],
            'carga_corte' => [
                'required',
                'in:1,2'
            ],
        ];
    }

    protected function messages()
    {
        return [
            'id_lapso_academico.required' => 'El lapso académico es obligatorio.',
            'id_lapso_academico.exists' => 'El lapso académico seleccionado no es válido.',
            'semana.required' => 'El número de semana es obligatorio.',
            'semana.integer' => 'La semana debe ser un número entero.',
            'semana.min' => 'La semana debe ser mayor a 0.',
            'dia_inicio.required' => 'La fecha de inicio es obligatoria.',
            'dia_inicio.date' => 'La fecha de inicio debe ser válida.',
            'dia_fin.required' => 'La fecha de fin es obligatoria.',
            'dia_fin.date' => 'La fecha de fin debe ser válida.',
            'dia_fin.after_or_equal' => 'La fecha de fin debe ser igual o posterior a la fecha de inicio.',
            'carga_corte.required' => 'La carga de corte es obligatoria.',
            'carga_corte.in' => 'Opción de carga de corte inválida.',
        ];
    }
}
