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
                ->join('detalle_objetivo as do', 'c.id_contenido', '=', 'do.id_contenido')
                ->join('objetivo as o', 'do.id_objetivo', '=', 'o.id_objetivo')
                ->join('tema_unidad as t', 'o.id_tema_unidad', '=', 't.id_tema_unidad')
                ->where('c.id_contenido', $id)
                ->where('do.estatus', '1')
                ->select('t.id_unidad_curricular', 't.unidad_tema as corte_contenido')
                ->first();

            if ($extraData) {
                // Fetch external unity name
                $unidadSogc = DB::connection('external_db')->table('unidad_curricular')
                    ->where('ucu_codigo', $extraData->id_unidad_curricular)
                    ->value('ucu_nombre');

                $contenido->nombre_unidad_curricular = $unidadSogc ?? 'No definida (SOGC)';
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
