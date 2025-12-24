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
        return DB::table('estrategia_pedagogica')->insert([
            'nombre_estrategia_pedagogica' => $datos['nombre'],
            'estatus' => '1',
            'fecha_creacion' => Carbon::now(),
            'fecha_actualizacion' => Carbon::now()
        ]);
    }
}
