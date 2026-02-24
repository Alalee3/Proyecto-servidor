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
        $evaluacion = \App\Models\Evaluacion::create([
            'nombre_evaluacion' => $datos['nombre'],
            'estatus' => '1',
            'fecha_creacion' => Carbon::now(),
            'fecha_actualizacion' => Carbon::now()
        ]);

        return $evaluacion->id_evaluacion;
    }
}
