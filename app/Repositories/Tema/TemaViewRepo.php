<?php

namespace App\Repositories\Tema;

use Illuminate\Support\Facades\DB;

class TemaViewRepo
{
    public function mostrar($id)
    {
        $tema = DB::table('tema_unidad as t')
            ->join('unidad_curricular as uc', 't.id_unidad_curricular', '=', 'uc.id_unidad_curricular')
            ->select(
                't.id_tema_unidad',
                'uc.nombre_unidad_curricular',
                't.titulo_tema',
                't.unidad_tema',
                't.fecha_creacion',
                't.fecha_actualizacion',
                't.estatus'
            )
            ->where('t.id_tema_unidad', $id)
            ->first();

        if ($tema) {
            $tema->objetivos = DB::table('objetivo')
                ->where('id_tema_unidad', $id)
                ->where('estatus', '1')
                ->select('titulo_objetivo')
                ->get();
        }

        return $tema;
    }
}
