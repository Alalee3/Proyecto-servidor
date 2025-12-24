<?php

namespace App\Repositories\Evaluacion;

use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class EvaluacionIndexRepo
{
    /**
     * Lista las evaluaciones con búsqueda y paginación.
     */
    public function listar($busqueda = '', $paginacion = 5)
    {
        return DB::table('evaluacion')
            ->select('id_evaluacion', 'nombre_evaluacion as nombre', 'estatus')
            ->when($busqueda, function ($consulta, $busqueda) {
                $consulta->where('nombre_evaluacion', 'LIKE', '%' . $busqueda . '%');
            })
            ->orderBy('nombre_evaluacion')
            ->paginate($paginacion);
    }

    /**
     * Inhabilita una evaluación.
     */
    public function inhabilitar($id)
    {
        return DB::table('evaluacion')
            ->where('id_evaluacion', $id)
            ->update([
                'estatus' => '2',
                'fecha_actualizacion' => Carbon::now()
            ]);
    }

    /**
     * Restaura una evaluación.
     */
    public function restaurar($id)
    {
        return DB::table('evaluacion')
            ->where('id_evaluacion', $id)
            ->update([
                'estatus' => '1',
                'fecha_actualizacion' => Carbon::now()
            ]);
    }
}
