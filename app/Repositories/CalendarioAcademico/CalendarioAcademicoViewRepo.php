<?php

namespace App\Repositories\CalendarioAcademico;

use Illuminate\Support\Facades\DB;

class CalendarioAcademicoViewRepo
{
    public function mostrar($id)
    {
        $calendario = DB::table('calendario_academico')
            ->leftJoin('lapso_academico', 'calendario_academico.id_lapso_academico', '=', 'lapso_academico.id_lapso_academico')
            ->select(
                'calendario_academico.*',
                'lapso_academico.nombre_lapso_academico as nombre_lapso'
            )
            ->where('id_calendario_academico', $id)
            ->first();

        if ($calendario) {
            \App\Models\CalendarioAcademico::logMostrar(\App\Models\CalendarioAcademico::find($id));
        }

        return $calendario;
    }

    public function obtenerEventos($id)
    {
        return DB::table('evento')
            ->where('id_calendario', $id)
            ->orderBy('semana_evento', 'asc')
            ->get();
    }

    public function obtenerActivo()
    {
        return DB::table('calendario_academico')
            ->where('estatus', '1')
            ->orderBy('fecha_creacion', 'desc')
            ->first();
    }
}
