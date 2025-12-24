<?php

namespace App\Repositories\Pnf;

use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;

class PnfEditRepo
{
    public function mostrar($id)
    {
        return DB::table('pnf')
            ->where('id_pnf', $id)
            ->select(
                'id_pnf as id',
                'nombre_pnf as nombre',
            )
            ->first();
    }


    public function editar($id, array $data)
    {
        $updateData = [
            'nombre_pnf' => $data['nombre'],
        ];

        return DB::table('pnf')
            ->where('id_pnf', $id)
            ->update($updateData);
    }
}
