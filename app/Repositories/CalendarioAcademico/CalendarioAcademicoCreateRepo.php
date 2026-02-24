<?php

namespace App\Repositories\CalendarioAcademico;

use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class CalendarioAcademicoCreateRepo
{
    public function obtenerLapsosActivos()
    {
        return DB::table('lapso_academico')
            ->where('estatus', '1')
            ->select('id_lapso_academico', 'nombre_lapso_academico')
            ->get();
    }

    public function crear(array $data)
    {
        $calendario = \App\Models\CalendarioAcademico::create([
            'id_lapso_academico' => $data['id_lapso_academico'],
            'semana' => $data['semana'],
            'dia_inicio' => $data['dia_inicio'],
            'dia_fin' => $data['dia_fin'],
            'carga_corte' => $data['carga_corte'],
            'fecha_creacion' => Carbon::now(),
            'estatus' => '1',
        ]);

        return $calendario->getKey();
    }
}
