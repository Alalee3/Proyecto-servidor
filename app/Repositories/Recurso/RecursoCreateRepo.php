<?php

namespace App\Repositories\Recurso;

use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class RecursoCreateRepo
{
    public function crear(array $datos)
    {
        $recurso = \App\Models\Recurso::create([
            'nombre_recurso' => $datos['nombre'],
            'estatus' => '1'
        ]);

        return $recurso->id_recurso;
    }
}
