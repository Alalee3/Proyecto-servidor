<?php

namespace App\Repositories\Evento;

use Illuminate\Support\Facades\DB;

class EventoEditRepo
{
    public function mostrar($id)
    {
        return DB::table('evento')
            ->where('id_evento', $id)
            ->select(
                'id_evento',
                'descripcion_evento',
                'fecha_evento',
                'tipo_evento',
                'estatus'
            )
            ->first();
    }

    public function editar($id, array $data)
    {
        return DB::table('evento')
            ->where('id_evento', $id)
            ->update([
                'descripcion_evento' => $data['descripcion_evento'],
                'fecha_evento' => $data['fecha_evento'],
                'tipo_evento' => $data['tipo_evento'],
            ]);
    }
}
