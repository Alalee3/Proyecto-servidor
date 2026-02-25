<?php

namespace App\Repositories\CalendarioAcademico;

use App\Models\CalendarioAcademico;

class CalendarioAcademicoEditRepo
{
    public function mostrar($id)
    {
        $calendario = CalendarioAcademico::find($id);
        if ($calendario) {
            CalendarioAcademico::logMostrar($calendario);
        }
        return $calendario;
    }

    public function editar($id, array $data)
    {
        $calendario = CalendarioAcademico::find($id);
        if ($calendario) {
            return $calendario->update([
                'id_lapso_academico' => $data['id_lapso_academico'],
                'semana_calendario_academico' => $data['semana_calendario_academico'],
                'dia_inicio_calendario_academico' => $data['dia_inicio_calendario_academico'],
                'dia_fin_calendario_academico' => $data['dia_fin_calendario_academico'],
            ]);
        }
        return false;
    }
}
