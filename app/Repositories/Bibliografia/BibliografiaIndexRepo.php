<?php

namespace App\Repositories\Bibliografia;

use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class BibliografiaIndexRepo
{
    public function listar($busqueda = '', $paginacion = 5)
    {
        return DB::table('bibliografia')
            ->select('id_bibliografia', 'nombre_bibliografia as nombre', 'estatus')
            ->when($busqueda, function ($consulta, $busqueda) {
                $consulta->where('nombre_bibliografia', 'LIKE', '%' . $busqueda . '%');
            })
            ->orderBy('nombre_bibliografia')
            ->paginate($paginacion);
    }

    public function inhabilitar($id)
    {
        return DB::table('bibliografia')
            ->where('id_bibliografia', $id)
            ->update([
                'estatus' => '3',
                'fecha_actualizacion' => Carbon::now()
            ]);
    }

    public function restaurar($id)
    {
        return DB::table('bibliografia')
            ->where('id_bibliografia', $id)
            ->where('estatus', '3')
            ->update([
                'estatus' => '1',
                'fecha_actualizacion' => Carbon::now()
            ]);
    }
}
