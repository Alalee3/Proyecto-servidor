<?php

namespace App\Repositories\Evento;

use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class EventoCreateRepo
{
    public function crear(array $data)
    {
        return DB::table('evento')->insertGetId([
            'descripcion_evento' => $data['descripcion_evento'],
            'fecha_evento' => $data['fecha_evento'],
            'tipo_evento' => $data['tipo_evento'],
            'fecha_creacion' => Carbon::now(),
            'estatus' => '1',
        ]);
    }
}
