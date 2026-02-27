<?php

namespace App\Repositories\Evento;

use Illuminate\Support\Facades\DB;

class EventoEditRepo
{
    public function mostrar($id)
    {
        return DB::table('evento')
            ->where('id_evento', $id)
            ->first();
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

    public function existeEventoConDescripcion(string $descripcion, ?int $idCalendario, ?int $idEventoExcluir): bool
    {
        return DB::table('evento')
            ->where('id_calendario', $idCalendario)
            ->where('descripcion_evento', $descripcion)
            ->where('id_evento', '!=', $idEventoExcluir)
            ->where('estatus', '!=', '3')
            ->exists();
    }
}
