<?php

namespace App\Repositories\IndicadorLogro;

use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class IndicadorLogroCreateRepo
{
    public function crear(array $data)
    {
        $indicador = \App\Models\IndicadorLogro::create([
            'nombre_indicador_logro' => $data['nombre_indicador_logro'],
            'estatus' => '1',
        ]);

        return $indicador->getKey();
    }
}
