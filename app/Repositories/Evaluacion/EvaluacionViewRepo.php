<?php

namespace App\Repositories\Evaluacion;

use Illuminate\Support\Facades\DB;

class EvaluacionViewRepo
{
    /**
     * Obtiene los detalles de una evaluación.
     */
    public function mostrar($id)
    {
        $evaluacion = \App\Models\Evaluacion::find($id);
        if ($evaluacion) {
            \App\Models\Evaluacion::logMostrar($evaluacion);
        }
        return $evaluacion;
    }
}
