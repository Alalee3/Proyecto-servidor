<?php

namespace App\Repositories\Contenido;

use Illuminate\Support\Facades\DB;

class ContenidoViewRepo
{
    public function mostrar($id)
    {
        return DB::table('contenido as c')
            ->join('unidad_curricular as uc', 'c.id_unidad_curricular', '=', 'uc.id_unidad_curricular')
            ->select(
                'c.id_contenido',
                'uc.nombre_unidad_curricular',
                'c.titulo_contenido',
                'c.descripcion_contenido',
                'c.corte_contenido',
                'c.fecha_creacion',
                'c.fecha_actualizacion',
                'c.estatus'
            )
            ->where('c.id_contenido', $id)
            ->first();
    }
}
