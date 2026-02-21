<?php

namespace App\Repositories\Contenido;

use Illuminate\Support\Facades\DB;

class ContenidoViewRepo
{
    public function mostrar($id)
    {
        $contenido = DB::table('contenido as c')
            ->join('objetivo as o', 'c.id_objetivo', '=', 'o.id_objetivo')
            ->join('tema_unidad as t', 'o.id_tema_unidad', '=', 't.id_tema_unidad')
            ->join('unidad_curricular as uc', 't.id_unidad_curricular', '=', 'uc.id_unidad_curricular')
            ->select(
                'c.id_contenido',
                'uc.nombre_unidad_curricular',
                'c.titulo_contenido',
                't.unidad_tema as corte_contenido', // Alias for view compatibility
                'c.fecha_creacion',
                'c.fecha_actualizacion',
                'c.estatus'
            )
            ->where('c.id_contenido', $id)
            ->first();

        if ($contenido) {
            $contenido->objetivos = DB::table('detalle_objetivo as do')
                ->join('objetivo as o', 'do.id_objetivo', '=', 'o.id_objetivo')
                ->where('do.id_contenido', $id)
                ->where('do.estatus', '1')
                ->select('o.titulo_objetivo')
                ->get();
        }

        return $contenido;
    }
}
