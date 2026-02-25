<?php

namespace App\Repositories\CalendarioAcademico;

use App\Models\CalendarioAcademico;
use Carbon\Carbon;

class CalendarioAcademicoCreateRepo
{
    public function crear(array $data)
    {
        $calendario = CalendarioAcademico::create([
            'id_lapso_academico' => $data['id_lapso_academico'],
            'semana_calendario_academico' => $data['semana_calendario_academico'],
            'dia_inicio_calendario_academico' => $data['dia_inicio_calendario_academico'],
            'dia_fin_calendario_academico' => $data['dia_fin_calendario_academico'],
            'fecha_creacion' => Carbon::now(),
            'estatus' => '1',
        ]);

        return $calendario->id_calendario_academico;
    }
}
