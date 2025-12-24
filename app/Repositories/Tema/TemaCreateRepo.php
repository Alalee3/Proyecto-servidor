<?php

namespace App\Repositories\Tema;

use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class TemaCreateRepo
{
    public function select_contenidos()
    {
        return DB::table('contenido')
            ->select('id_contenido as id', 'titulo_contenido as nombre')
            ->where('estatus', '1')
            ->get();
    }

    public function crear(array $data)
    {
        return DB::table('tema')->insertGetId([
            'id_contenido' => $data['id_contenido'],
            'titulo_tema' => $data['titulo_tema'],
            'descripcion_tema' => $data['descripcion_tema'] ?? null,
            'fecha_creacion' => Carbon::now(),
            'fecha_actualizacion' => null,
            'estatus' => '1',
        ]);
    }
}
