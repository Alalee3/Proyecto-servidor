<?php

namespace App\Repositories\Evento;

use Illuminate\Support\Facades\DB;

class EventoViewRepo
{
    public function mostrar($id)
    {
        $evento = DB::table('evento')
            ->where('id_evento', $id)
            ->first();

        if ($evento) {
            \App\Models\Evento::logMostrar(\App\Models\Evento::find($id));
        }

        return $evento;
    }
}
