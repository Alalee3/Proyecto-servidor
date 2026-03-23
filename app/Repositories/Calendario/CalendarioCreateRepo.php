<?php

namespace App\Repositories\Calendario;

use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class CalendarioCreateRepo
{
    public function crear(array $data)
    {
        $calendario = \App\Models\CalendarioAcademico::create([
            'semana_calendario_academico' => $data['semana_calendario_academico'],
            'dia_inicio_calendario_academico' => $data['dia_inicio_calendario_academico'],
            'dia_fin_calendario_academico' => $data['dia_fin_calendario_academico'],
            'fecha_creacion' => Carbon::now(),
            'estatus' => '1',
        ]);

        return $calendario->getKey();
    }

    public function existeCalendarioEnSemana(int $semana): bool
    {
        return DB::table('calendario_academico')
            ->where('semana_calendario_academico', $semana)
            ->where('estatus', '!=', '3')
            ->exists();
    }

    public function hayCalendarioActivo(): bool
    {
        return DB::table('calendario_academico')
            ->where('estatus', '1')
            ->exists();
    }
}
