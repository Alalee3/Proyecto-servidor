<?php

namespace App\Repositories\Evento;

use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class EventoCreateRepo
{
    public function crear(array $data)
    {
        $evento = \App\Models\Evento::create([
            'descripcion_evento' => $data['descripcion_evento'],
            'fecha_evento' => $data['fecha_evento'],
            'tipo_evento' => $data['tipo_evento'],
            'fecha_creacion' => Carbon::now(),
            'estatus' => '1',
        ]);

        return $evento->getKey();
    }
}
