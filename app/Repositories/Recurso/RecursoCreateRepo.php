<?php

namespace App\Repositories\Recurso;

use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class RecursoCreateRepo
{
    public function crear(array $datos)
    {
        return DB::table('recurso')->insert([
            'nombre_recurso' => $datos['nombre'],
            'estatus' => '1',
            'fecha_creacion' => Carbon::now(),
            'fecha_actualizacion' => Carbon::now()
        ]);
    }
}
