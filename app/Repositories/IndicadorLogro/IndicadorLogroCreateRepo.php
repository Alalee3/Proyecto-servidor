<?php

namespace App\Repositories\IndicadorLogro;

use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class IndicadorLogroCreateRepo
{
    public function crear(array $data)
    {
        return DB::table('indicador_logro')->insertGetId([
            'nombre_indicador_logro' => $data['nombre_indicador_logro'],
            'fecha_creacion' => Carbon::now(),
            'fecha_actualizacion' => null,
            'estatus' => '1',
        ]);
    }
}
