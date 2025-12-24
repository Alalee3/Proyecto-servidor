<?php

namespace App\Repositories\Pnf;

use Illuminate\Support\Facades\DB;

class PnfViewRepo
{
    public function mostrar($id)
    {
        return DB::table('pnf')
            ->where('id_pnf', $id)
            ->select(
                'id_pnf',
                'nombre_pnf as nombre',
                'fecha_creacion',
                'estatus',
            )
            ->first();
    }
}