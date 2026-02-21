<?php

namespace App\Repositories\Pnf;

use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class PnfIndexRepo
{
    public function listar($busqueda = '', $paginacion = 5)
    {
        return DB::table('pnf')
            ->select('id_pnf', 'nombre_pnf as nombre', 'estatus')
            ->when($busqueda, function ($consulta, $busqueda) {
                $consulta->where('nombre_pnf', 'LIKE', '%' . $busqueda . '%');
            })
            ->orderBy('id_pnf', 'desc')
            ->paginate($paginacion);
    }

    public function inhabilitar($id)
    {
        return DB::table('pnf')
            ->where('id_pnf', $id)
            ->update([
                'estatus' => 3,
                //'updated_at' => Carbon::now()
            ]);
    }

    public function restaurar($id)
    {
        return DB::table('pnf')
            ->where('id_pnf', $id)
            ->where('estatus', '3')
            ->update([
                'estatus' => '1',
                //'updated_at' => Carbon::now()
            ]);
    }

}