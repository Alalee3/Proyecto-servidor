<?php

namespace App\Repositories\TecnicaEvaluacion;

use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class TecnicaEvaluacionIndexRepo
{
    /**
     * Lista las evaluaciones con búsqueda y paginación.
     */
    public function listar($busqueda = '', $paginacion = 5)
    {
        return DB::table('tecnica_evaluacion')
            ->select('id_tecnica_evaluacion', 'nombre_tecnica_evaluacion as nombre', 'estatus')
            ->when($busqueda, function ($consulta, $busqueda) {
                $consulta->where('nombre_tecnica_evaluacion', 'LIKE', '%' . $busqueda . '%');
            })
            ->orderBy('id_tecnica_evaluacion', 'desc')
            ->paginate($paginacion);
    }

    /**
     * Inhabilita una evaluación.
     */
    public function inhabilitar($id)
    {
        $evaluacion = \App\Models\TecnicaEvaluacion::find($id);
        if ($evaluacion) {
            return $evaluacion->update([
                'estatus' => '3',
                'fecha_actualizacion' => Carbon::now()
            ]);
        }
        return false;
    }

    /**
     * Restaura una evaluación.
     */
    public function restaurar($id)
    {
        $evaluacion = \App\Models\TecnicaEvaluacion::where('id_tecnica_evaluacion', $id)->where('estatus', '3')->first();
        if ($evaluacion) {
            return $evaluacion->update([
                'estatus' => '1',
                'fecha_actualizacion' => Carbon::now()
            ]);
        }
        return false;
    }
}
