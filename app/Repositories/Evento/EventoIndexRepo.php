<?php

namespace App\Repositories\Evento;

use Illuminate\Support\Facades\DB;

class EventoIndexRepo
{
    public function listar($busqueda = '', $paginacion = 5)
    {
        $eventos = DB::table('evento')
            ->leftJoin('calendario_academico', 'evento.id_calendario', '=', 'calendario_academico.id_calendario_academico')
            ->select(
                'evento.id_evento',
                'evento.id_calendario',
                'evento.descripcion_evento',
                'evento.dia_inicio_evento',
                'evento.dia_fin_evento',
                'evento.tipo_evento',
                'evento.estatus',
                'calendario_academico.id_lapso_academico'
            )
            ->when($busqueda, function ($consulta, $busqueda) {
                $consulta->where('evento.descripcion_evento', 'LIKE', '%' . $busqueda . '%');
            })
            ->orderBy('evento.dia_inicio_evento', 'desc')
            ->paginate($paginacion);

        // Obtener nombres de lapsos desde la base de datos externa DAECE
        $idLapsos = $eventos->pluck('id_lapso_academico')->filter()->unique()->toArray();
        $lapsosDaece = DB::connection('external_db')->table('lapso_academico')
            ->whereIn('lap_codigo', $idLapsos)
            ->pluck('lap_nombre', 'lap_codigo');

        // Mapear los nombres a la colección
        $eventos->getCollection()->transform(function ($evento) use ($lapsosDaece) {
            $evento->nombre_lapso = $evento->id_lapso_academico ? ($lapsosDaece[$evento->id_lapso_academico] ?? 'No definido (DAECE)') : 'Sin Lapso';
            return $evento;
        });

        return $eventos;
    }

    public function inhabilitar($id)
    {
        $evento = \App\Models\Evento::find($id);
        if ($evento) {
            return $evento->update([
                'estatus' => '3'
            ]);
        }
        return false;
    }

    public function restaurar($id)
    {
        $evento = \App\Models\Evento::where('id_evento', $id)->where('estatus', '3')->first();
        if ($evento) {
            return $evento->update([
                'estatus' => '1'
            ]);
        }
        return false;
    }
}
