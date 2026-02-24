<?php

namespace App\Repositories\Estrategia;

use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class EstrategiaCreateRepo
{
    /**
     * Crea una nueva estrategia pedagógica.
     */
    public function crear(array $datos)
    {
        $estrategia = \App\Models\Estrategia::create([
            'nombre_tecnica_actividad' => $datos['nombre'],
            'estatus' => '1',
            'fecha_creacion' => Carbon::now(),
            'fecha_actualizacion' => Carbon::now()
        ]);

        return $estrategia->id_tecnica_actividad;
    }
}
