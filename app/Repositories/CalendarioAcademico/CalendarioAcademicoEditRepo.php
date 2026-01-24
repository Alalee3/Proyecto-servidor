<?php

namespace App\Repositories\CalendarioAcademico;

use Illuminate\Support\Facades\DB;

class CalendarioAcademicoEditRepo
{
    public function obtenerLapsosActivos()
    {
        return DB::table('lapso_academico')
            ->where('estatus', '1')
            ->select('id_lapso_academico', 'nombre_lapso_academico')
            ->get();
    }

    public function mostrar($id)
    {
        return DB::table('calendario_academico')
            ->where('id_calendario_academico', $id)
            ->select(
                'id_calendario_academico',
                'id_lapso_academico',
                'semana',
                'dia_inicio',
                'dia_fin',
                'carga_corte',
                'estatus'
            )
            ->first();
    }

    public function editar($id, array $data)
    {
        return DB::table('calendario_academico')
            ->where('id_calendario_academico', $id)
            ->update([
                'id_lapso_academico' => $data['id_lapso_academico'],
                'semana' => $data['semana'],
                'dia_inicio' => $data['dia_inicio'],
                'dia_fin' => $data['dia_fin'],
                'carga_corte' => $data['carga_corte'],
            ]);
    }
}
