<?php

namespace App\Repositories\Evaluacion;

use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class EvaluacionCreateRepo
{
    /**
     * Crea una nueva evaluación.
     */
    public function crear(array $datos)
    {
        return DB::table('evaluacion')->insert([
            'nombre_evaluacion' => $datos['nombre'],
            'estatus' => '1',
            'fecha_creacion' => Carbon::now(),
            'fecha_actualizacion' => Carbon::now()
        ]);
    }
}
