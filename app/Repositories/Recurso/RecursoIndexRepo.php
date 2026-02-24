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
            ->orderBy('fecha_creacion', 'desc')
            ->paginate($paginacion);
    }

    public function inhabilitar($id)
    {
        $recurso = \App\Models\Recurso::find($id);
        if ($recurso) {
            return $recurso->update([
                'estatus' => '2',
                'fecha_actualizacion' => Carbon::now()
            ]);
        }
        return false;
    }

    public function restaurar($id)
    {
        $recurso = \App\Models\Recurso::find($id);
        if ($recurso) {
            return $recurso->update([
                'estatus' => '1',
                'fecha_actualizacion' => Carbon::now()
            ]);
        }
        return false;
    }
}
