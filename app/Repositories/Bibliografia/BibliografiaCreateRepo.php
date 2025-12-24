<?php

namespace App\Repositories\Bibliografia;

use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class BibliografiaCreateRepo
{
    public function crear(array $datos)
    {
        return DB::table('bibliografia')->insert([
            'nombre_bibliografia' => $datos['nombre'],
            'fecha_creacion' => Carbon::now(),
            'estatus' => '1'
        ]);
    }
}
