<?php

namespace App\Repositories\Calendario;

use Illuminate\Support\Facades\DB;
use App\Models\CalendarioAcademico;

class CalendarioEditRepo
{
    public function obtener($id)
    {
        return DB::table('calendario_academico')
            ->where('id_calendario_academico', $id)
            ->first();
    }

    public function actualizar($id, array $data)
    {
        $calendario = CalendarioAcademico::find($id);
        if ($calendario) {
            return $calendario->update([
                'semana_calendario_academico' => $data['semana_calendario_academico'],
                'dia_inicio_calendario_academico' => $data['dia_inicio_calendario_academico'],
                'dia_fin_calendario_academico' => $data['dia_fin_calendario_academico'],
            ]);
        }
        return false;
    }
}
