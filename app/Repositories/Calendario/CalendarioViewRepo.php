<?php

namespace App\Repositories\Calendario;

use Illuminate\Support\Facades\DB;
use App\Models\CalendarioAcademico;

class CalendarioViewRepo
{
    public function mostrar($id)
    {
        $calendario = DB::table('calendario_academico')
            ->where('id_calendario_academico', $id)
            ->first();

        if ($calendario) {
            $lapso = DB::connection('pgsql_daece')->table('lapso_academico')
                ->where('lap_codigo', $calendario->id_lapso_academico)
                ->first();
            $calendario->nombre_lapso = $lapso ? $lapso->lap_nombre : 'No definido (DAECE)';

            CalendarioAcademico::logMostrar(CalendarioAcademico::find($id));
        }

        return $calendario;
    }
}
