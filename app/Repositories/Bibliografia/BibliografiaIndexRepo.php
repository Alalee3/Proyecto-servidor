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
            ->orderBy('fecha_creacion', 'desc')
            ->paginate($paginacion);
    }

    public function inhabilitar($id)
    {
        $bibliografia = \App\Models\Bibliografia::find($id);
        if ($bibliografia) {
            return $bibliografia->update([
                'estatus' => '3',
                'fecha_actualizacion' => Carbon::now()
            ]);
        }
        return false;
    }

    public function restaurar($id)
    {
        $bibliografia = \App\Models\Bibliografia::where('id_bibliografia', $id)->where('estatus', '3')->first();
        if ($bibliografia) {
            return $bibliografia->update([
                'estatus' => '1',
                'fecha_actualizacion' => Carbon::now()
            ]);
        }
        return false;
    }
}
