<?php

namespace App\Repositories\Tema;

use Illuminate\Support\Facades\DB;

class TemaIndexRepo
{
    public function listar($busqueda = '', $paginacion = 5)
    {
        return DB::table('tema as t')
            ->join('contenido as c', 't.id_contenido', '=', 'c.id_contenido')
            ->select(
                't.id_tema',
                't.titulo_tema',
                'c.titulo_contenido',
                't.estatus'
            )
            ->when($busqueda, function ($query, $busqueda) {
                return $query->where('t.titulo_tema', 'LIKE', '%' . $busqueda . '%')
                    ->orWhere('c.titulo_contenido', 'LIKE', '%' . $busqueda . '%');
            })
            ->orderBy('t.fecha_creacion', 'desc')
            ->paginate($paginacion);
    }

    public function inhabilitar($id)
    {
        return DB::table('tema')
            ->where('id_tema', $id)
            ->update([
                'estatus' => '3',
                'fecha_actualizacion' => now()
            ]);
    }

    public function restaurar($id)
    {
        return DB::table('tema')
            ->where('id_tema', $id)
            ->where('estatus', '3')
            ->update([
                'estatus' => '1',
                'fecha_actualizacion' => now()
            ]);
    }
}
