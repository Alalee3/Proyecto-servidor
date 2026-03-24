<?php

namespace App\Repositories\Calendario;

use Illuminate\Support\Facades\DB;
use App\Models\CalendarioAcademico;

class CalendarioViewRepo
{
    public function mostrar($id)
    {
        CalendarioAcademico::inactivarVencidos();

        $calendario = DB::table('calendario_academico')
            ->where('id_calendario_academico', $id)
            ->first();

        if ($calendario) {
            CalendarioAcademico::logMostrar(CalendarioAcademico::find($id));
        }

        return $calendario;
    }
}
