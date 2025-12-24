<?php

namespace App\Repositories\Contenido;

use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class ContenidoEditRepo
{
    public function mostrar($id)
    {
        return DB::table('contenido')
            ->where('id_contenido', $id)
            ->select(
                'id_contenido as id',
                'id_unidad_curricular',
                'titulo_contenido',
                'descripcion_contenido',
                'corte_contenido'
            )
            ->first();
    }

    public function editar($id, array $data)
    {
        return DB::table('contenido')
            ->where('id_contenido', $id)
            ->update([
                'id_unidad_curricular' => $data['id_unidad_curricular'],
                'titulo_contenido' => $data['titulo_contenido'],
                'descripcion_contenido' => $data['descripcion_contenido'] ?? null,
                'corte_contenido' => $data['corte_contenido'],
                'fecha_actualizacion' => Carbon::now(),
            ]);
    }
}
