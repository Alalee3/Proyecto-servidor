<?php

namespace App\Repositories\Evaluacion;

use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class EvaluacionEditRepo
{
    /**
     * Obtiene una evaluación por su ID.
     */
    public function obtenerPorId($id)
    {
        return DB::table('evaluacion')
            ->where('id_evaluacion', $id)
            ->first();
    }

    /**
     * Actualiza una evaluación existente.
     */
    public function actualizar($id, array $datos)
    {
        $evaluacion = \App\Models\Evaluacion::find($id);
        if ($evaluacion) {
            return $evaluacion->update([
                'nombre_evaluacion' => $datos['nombre'],
                'fecha_actualizacion' => Carbon::now()
            ]);
        }
        return false;
    }
}
