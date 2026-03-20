<?php

namespace App\Repositories\Evento;

use Illuminate\Support\Facades\DB;

class EventoViewRepo
{
    public function mostrar($id)
    {
        $evento = DB::table('evento')
            ->leftJoin('calendario_academico', 'evento.id_calendario', '=', 'calendario_academico.id_calendario_academico')
            ->select('evento.*', 'calendario_academico.id_lapso_academico')
            ->where('evento.id_evento', $id)
            ->first();

        // Get lapso info
        if ($evento && $evento->id_lapso_academico) {
            $lapso = DB::connection('external_db')->table('lapso_academico')
                ->where('lap_codigo', $evento->id_lapso_academico)
                ->first();
            $evento->nombre_lapso = $lapso ? $lapso->lap_nombre : 'No definido (DAECE)';
        } elseif ($evento) {
            $evento->nombre_lapso = 'Sin Lapso';
        }

        if ($evento) {
            \App\Models\Evento::logMostrar(\App\Models\Evento::find($id));
        }

        return $evento;
    }
}
