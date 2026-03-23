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
                'evento.estatus'
            )
            ->when($busqueda, function ($consulta, $busqueda) {
                $consulta->where('evento.descripcion_evento', 'LIKE', '%' . $busqueda . '%');
            })
            ->orderBy('evento.dia_inicio_evento', 'desc')
            ->paginate($paginacion);

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
