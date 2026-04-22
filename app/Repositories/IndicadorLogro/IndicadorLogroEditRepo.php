<?php

namespace App\Repositories\IndicadorLogro;

use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class IndicadorLogroEditRepo
{
    public function obtener_por_id($id)
    {
        return DB::table('indicador_logro')
            ->where('id_indicador_logro', $id)
            ->first();
    }

    public function actualizar($id, array $data)
    {
            return $indicador->update([
                'nombre_indicador_logro' => $data['nombre_indicador_logro']
            ]);
        }
        return false;
    }
}
