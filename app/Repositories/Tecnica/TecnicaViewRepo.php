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
        $tecnica = \App\Models\Tecnica::find($id);
        if ($tecnica) {
            \App\Models\Tecnica::logMostrar($tecnica);
        }
        return $tecnica;
    }
}
