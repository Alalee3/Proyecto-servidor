<?php

namespace App\Repositories\Tema;

use Illuminate\Support\Facades\DB;

class TemaViewRepo
{
    public function mostrar($id)
    {
        $tema = \App\Models\Tema::find($id);

        if ($tema) {
            \App\Models\Tema::logMostrar($tema);

            // Agregar nombre de unidad curricular para compatibilidad con la vista
            $uc = DB::connection('external_db')->table('unidad_curricular')
                ->where('ucu_codigo', $tema->id_unidad_curricular)
                ->value('ucu_nombre');

            $tema->nombre_unidad_curricular = $uc;

            $tema->objetivos = DB::table('objetivo')
                ->where('id_tema_unidad', $id)
                ->where('estatus', '1')
                ->select('titulo_objetivo')
                ->get();
        }

        return $tema;
    }
}
