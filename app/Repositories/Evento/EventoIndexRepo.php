<?php

namespace App\Repositories\Evento;

use Illuminate\Support\Facades\DB;

class EventoIndexRepo
{
    public function listar($busqueda = '', $paginacion = 5)
    {
        return DB::table('evento')
            ->select('id_evento', 'descripcion_evento', 'fecha_evento', 'tipo_evento', 'estatus')
            ->when($busqueda, function ($consulta, $busqueda) {
                $consulta->where('descripcion_evento', 'LIKE', '%' . $busqueda . '%');
            })
            ->orderBy('fecha_evento', 'desc')
            ->paginate($paginacion);
    }

    public function inhabilitar($id)
    {
        return DB::table('evento')
            ->where('id_evento', $id)
            ->update([
                'estatus' => '3'
            ]);
    }

    public function restaurar($id)
    {
        return DB::table('evento')
            ->where('id_evento', $id)
            ->where('estatus', '3')
            ->update([
                'estatus' => '1'
            ]);
    }
}
