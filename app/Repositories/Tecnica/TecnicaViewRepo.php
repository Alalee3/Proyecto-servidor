<?php

namespace App\Repositories\Tecnica;

use Illuminate\Support\Facades\DB;

class TecnicaViewRepo
{
    /**
     * Obtiene los detalles de una técnica de evaluación.
     */
    public function mostrar($id)
    {
        return DB::table('tecnica_evaluacion')
            ->where('id_tecnica', $id)
            ->first();
    }
}
