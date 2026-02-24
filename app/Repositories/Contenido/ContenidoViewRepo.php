<?php

namespace App\Repositories\Contenido;

use Illuminate\Support\Facades\DB;

class ContenidoViewRepo
{
    public function mostrar($id)
    {
        $contenido = \App\Models\Contenido::find($id);

        if ($contenido) {
            \App\Models\Contenido::logMostrar($contenido);

            // Obtener datos adicionales para compatibilidad con la vista
            $extraData = DB::table('contenido as c')
                ->join('objetivo as o', 'c.id_objetivo', '=', 'o.id_objetivo')
                ->join('tema_unidad as t', 'o.id_tema_unidad', '=', 't.id_tema_unidad')
                ->join('unidad_curricular as uc', 't.id_unidad_curricular', '=', 'uc.id_unidad_curricular')
                ->where('c.id_contenido', $id)
                ->select('uc.nombre_unidad_curricular', 't.unidad_tema as corte_contenido')
                ->first();

            if ($extraData) {
                $contenido->nombre_unidad_curricular = $extraData->nombre_unidad_curricular;
                $contenido->corte_contenido = $extraData->corte_contenido;
            }

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
