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
        return DB::table('tecnica_actividad')
            ->where('id_tecnica_actividad', $id)
            ->first();
    }
}
