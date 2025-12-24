<?php

namespace App\Repositories\Recurso;

use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class RecursoEditRepo
{
    public function obtenerPorId($id)
    {
        return DB::table('recurso')
            ->where('id_recurso', $id)
            ->first();
    }

    public function actualizar($id, array $datos)
    {
        return DB::table('recurso')
            ->where('id_recurso', $id)
            ->update([
                'nombre_recurso' => $datos['nombre'],
                'fecha_actualizacion' => Carbon::now()
            ]);
    }
}
