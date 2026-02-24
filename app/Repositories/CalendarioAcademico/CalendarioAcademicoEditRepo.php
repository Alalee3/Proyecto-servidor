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
        $calendario = \App\Models\CalendarioAcademico::find($id);
        if ($calendario) {
            \App\Models\CalendarioAcademico::logMostrar($calendario);
        }
        return $calendario;
    }

    public function editar($id, array $data)
    {
        $calendario = \App\Models\CalendarioAcademico::find($id);
        if ($calendario) {
            return $calendario->update([
                'id_lapso_academico' => $data['id_lapso_academico'],
                'semana' => $data['semana'],
                'dia_inicio' => $data['dia_inicio'],
                'dia_fin' => $data['dia_fin'],
                'carga_corte' => $data['carga_corte'],
            ]);
        }
        return false;
    }
}
