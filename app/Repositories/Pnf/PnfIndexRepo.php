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
        $pnf = \App\Models\Pnf::find($id);
        if ($pnf) {
            return $pnf->update([
                'estatus' => '3',
            ]);
        }
        return false;
    }

    public function restaurar($id)
    {
        $pnf = \App\Models\Pnf::where('id_pnf', $id)->where('estatus', '3')->first();
        if ($pnf) {
            return $pnf->update([
                'estatus' => '1',
            ]);
        }
        return false;
    }

}