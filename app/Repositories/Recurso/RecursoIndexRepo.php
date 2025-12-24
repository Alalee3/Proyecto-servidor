<?php

namespace App\Repositories\Recurso;

use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class RecursoIndexRepo
{
    public function listar($busqueda = '', $paginacion = 5)
    {
        return DB::table('recurso')
            ->select('id_recurso', 'nombre_recurso as nombre', 'estatus')
            ->when($busqueda, function ($consulta, $busqueda) {
                $consulta->where('nombre_recurso', 'LIKE', '%' . $busqueda . '%');
            })
            ->orderBy('nombre_recurso')
            ->paginate($paginacion);
    }

    public function inhabilitar($id)
    {
        return DB::table('recurso')
            ->where('id_recurso', $id)
            ->update([
                'estatus' => '2',
                'fecha_actualizacion' => Carbon::now()
            ]);
    }

    public function restaurar($id)
    {
        return DB::table('recurso')
            ->where('id_recurso', $id)
            ->update([
                'estatus' => '1',
                'fecha_actualizacion' => Carbon::now()
            ]);
    }
}
