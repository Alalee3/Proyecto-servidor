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
                'id_calendario' => $data['id_calendario'] ?? null,
                'dia_inicio_evento' => $data['dia_inicio_evento'],
                'dia_fin_evento' => $data['dia_fin_evento'],
                'semana_evento' => $data['semana_evento'],
                'descripcion_evento' => $data['descripcion_evento'],
                'tipo_evento' => $data['tipo_evento'],
            ]);
        }
        return false;
    }
}
