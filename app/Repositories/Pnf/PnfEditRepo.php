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
            ->select('id_pnf as id', 'nombre_pnf as nombre')
            ->where('id_pnf', $id)
            ->first();
    }


    public function editar($id, array $data)
    {
        $updateData = [
            'nombre_pnf' => $data['nombre'],
        ];

        $pnf = \App\Models\Pnf::find($id);
        if ($pnf) {
            return $pnf->update($updateData);
        }
        return false;
    }
}
