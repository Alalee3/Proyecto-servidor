<?php

namespace App\Repositories\Tema;

use Illuminate\Support\Facades\DB;

class TemaViewRepo
{
    public function mostrar($id)
    {
        return DB::table('tema as t')
            ->join('contenido as c', 't.id_contenido', '=', 'c.id_contenido')
            ->select(
                't.id_tema',
                'c.titulo_contenido',
                't.titulo_tema',
                't.descripcion_tema',
                't.fecha_creacion',
                't.fecha_actualizacion',
                't.estatus'
            )
            ->where('t.id_tema', $id)
            ->first();
    }
}
