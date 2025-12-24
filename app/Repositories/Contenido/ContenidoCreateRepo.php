<?php

namespace App\Repositories\Contenido;

use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class ContenidoCreateRepo
{
    public function select_unidades_curriculares()
    {
        return DB::table('unidad_curricular')
            ->select('id_unidad_curricular as id', 'nombre_unidad_curricular as nombre')
            ->where('estatus', '1')
            ->get();
    }

    public function crear(array $data)
    {
        return DB::table('contenido')->insertGetId([
            'id_unidad_curricular' => $data['id_unidad_curricular'],
            'titulo_contenido' => $data['titulo_contenido'],
            'descripcion_contenido' => $data['descripcion_contenido'] ?? null,
            'corte_contenido' => $data['corte_contenido'],
            'fecha_creacion' => Carbon::now(),
            'fecha_actualizacion' => null,
            'estatus' => '1',
        ]);
    }
}
