<?php

namespace App\Repositories\TecnicaEvaluacion;

use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class TecnicaEvaluacionEditRepo
{
    /**
     * Obtiene una evaluación por su ID.
     */
    public function obtenerPorId($id)
    {
        return DB::table('tecnica_evaluacion')
            ->where('id_tecnica_evaluacion', $id)
            ->first();
    }

    /**
     * Actualiza una evaluación existente.
     */
    public function actualizar($id, array $datos)
    {
        $evaluacion = \App\Models\TecnicaEvaluacion::find($id);
        if ($evaluacion) {
            return $evaluacion->update([
                'nombre_tecnica_evaluacion' => $datos['nombre']
            ]);
        }
        return false;
    }
}
