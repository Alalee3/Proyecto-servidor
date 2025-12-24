<?php

namespace App\Repositories\IndicadorLogro;

use Illuminate\Support\Facades\DB;

class IndicadorLogroViewRepo
{
    public function obtener_detalles($id)
    {
        return DB::table('indicador_logro')
            ->where('id_indicador_logro', $id)
            ->first();
    }
}
