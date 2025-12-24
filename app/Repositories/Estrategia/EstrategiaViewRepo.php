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
        return DB::table('estrategia_pedagogica')
            ->where('id_estrategia_pedagogica', $id)
            ->first();
    }
}
