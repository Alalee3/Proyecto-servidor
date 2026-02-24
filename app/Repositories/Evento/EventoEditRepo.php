<?php

namespace App\Repositories\Evento;

use Illuminate\Support\Facades\DB;

class EventoEditRepo
{
    public function mostrar($id)
    {
        $evento = \App\Models\Evento::find($id);
        if ($evento) {
            \App\Models\Evento::logMostrar($evento);
        }
        return $evento;
    }

    public function editar($id, array $data)
    {
        $evento = \App\Models\Evento::find($id);
        if ($evento) {
            return $evento->update([
                'descripcion_evento' => $data['descripcion_evento'],
                'fecha_evento' => $data['fecha_evento'],
                'tipo_evento' => $data['tipo_evento'],
            ]);
        }
        return false;
    }
}
