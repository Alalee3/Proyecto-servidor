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
        return DB::table('evaluacion')
            ->where('id_evaluacion', $id)
            ->first();
    }
}
