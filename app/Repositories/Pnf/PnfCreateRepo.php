<?php

namespace App\Repositories\Pnf;

use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;

class PnfCreateRepo
{
    public function crear(array $data)
    {
        return DB::table('pnf')->insertGetId([
            'nombre_pnf' => $data['nombre'],
            'fecha_creacion' => Carbon::now(),
            'fecha_actualizacion' => null,
            'estatus' => '1',
        ]);
    }

}
