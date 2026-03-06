<?php

namespace App\Repositories\TecnicaEvaluacion;

use Illuminate\Support\Facades\DB;

class TecnicaEvaluacionViewRepo
{
    /**
     * Obtiene los detalles de una evaluación.
     */
    public function mostrar($id)
    {
        $evaluacion = \App\Models\TecnicaEvaluacion::find($id);
        if ($evaluacion) {
            \App\Models\TecnicaEvaluacion::logMostrar($evaluacion);
        }
        return $evaluacion;
    }
}
