<?php

namespace App\Repositories\Bibliografia;

use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class BibliografiaCreateRepo
{
    public function crear(array $datos)
    {
        $bibliografia = \App\Models\Bibliografia::create([
            'nombre_bibliografia' => $datos['nombre'],
            'estatus' => '1'
        ]);

        return $bibliografia->id_bibliografia;
    }
}
