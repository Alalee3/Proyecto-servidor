<?php

namespace App\Repositories\Calendario;

use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class CalendarioCreateRepo
{
    public function crear(array $data)
    {
        if (empty($data['id_lapso_academico'])) {
            $activo = DB::connection('pgsql_daece')->table('lapso_academico')
                ->where('lap_estatus', 'A')
                ->where('lap_cerrado', 'N')
                ->orderBy('lap_codigo', 'desc')
                ->first();
            if (!$activo) {
                throw new \Exception('No se puede registrar el calendario porque no existe un lapso académico activo.');
            }
            $data['id_lapso_academico'] = $activo->lap_codigo;
        }

        $calendario = \App\Models\CalendarioAcademico::create([
            'id_lapso_academico' => $data['id_lapso_academico'],
            'semana_calendario_academico' => $data['semana_calendario_academico'],
            'dia_inicio_calendario_academico' => $data['dia_inicio_calendario_academico'],
            'dia_fin_calendario_academico' => $data['dia_fin_calendario_academico'],
            'fecha_creacion' => Carbon::now(),
            'estatus' => '1',
        ]);

        return $calendario->getKey();
    }

    public function existeCalendarioEnSemana(int $semana, int $idLapso): bool
    {
        return DB::table('calendario_academico')
            ->where('id_lapso_academico', $idLapso)
            ->where('semana_calendario_academico', $semana)
            ->where('estatus', '!=', '3')
            ->exists();
    }

    public function obtenerLapsos()
    {
        return DB::connection('pgsql_daece')->table('lapso_academico')
            ->select('lap_codigo', 'lap_nombre')
            ->where('lap_estatus', 'A')
            ->orderBy('lap_codigo', 'desc')
            ->get();
    }
}
