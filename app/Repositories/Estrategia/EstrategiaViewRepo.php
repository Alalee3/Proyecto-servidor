<?php

namespace App\Repositories\Estrategia;

use Illuminate\Support\Facades\DB;

class EstrategiaViewRepo
{
    /**
     * Obtiene los detalles de una estrategia pedagógica.
     */
    public function mostrar($id)
    {
        $estrategia = \App\Models\Estrategia::find($id);
        if ($estrategia) {
            \App\Models\Estrategia::logMostrar($estrategia);
        }
        return $estrategia;
    }
}
