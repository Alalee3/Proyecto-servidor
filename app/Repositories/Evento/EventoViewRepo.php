<?php

namespace App\Repositories\Evento;

use Illuminate\Support\Facades\DB;

class EventoViewRepo
{
    public function mostrar($id)
    {
        $evento = DB::table('evento')
            ->leftJoin('calendario_academico', 'evento.id_calendario', '=', 'calendario_academico.id_calendario_academico')
            ->select('evento.*')
            ->where('evento.id_evento', $id)
            ->first();

        if ($evento) {
            \App\Models\Evento::logMostrar(\App\Models\Evento::find($id));
        }

        return $evento;
    }
}
