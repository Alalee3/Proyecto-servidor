<?php

namespace App\Repositories\Tecnica;

use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class TecnicaCreateRepo
{
    /**
     * Crea una nueva técnica de evaluación.
     */
    public function crear(array $datos)
    {
        return DB::table('tecnica')->insert([
            'nombre_tecnica' => $datos['nombre'],
            'estatus' => '1',
            'fecha_creacion' => Carbon::now(),
            'fecha_actualizacion' => Carbon::now()
        ]);
    }
}
