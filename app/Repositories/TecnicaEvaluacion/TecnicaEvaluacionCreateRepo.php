<?php

namespace App\Repositories\TecnicaEvaluacion;

use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class TecnicaEvaluacionCreateRepo
{
    /**
     * Crea una nueva evaluación.
     */
    public function crear(array $datos)
    {
        $evaluacion = \App\Models\TecnicaEvaluacion::create([
            'nombre_tecnica_evaluacion' => $datos['nombre'],
            'estatus' => '1',
            'fecha_creacion' => Carbon::now(),
            'fecha_actualizacion' => Carbon::now()
        ]);

        return $evaluacion->id_tecnica_evaluacion;
    }
}
