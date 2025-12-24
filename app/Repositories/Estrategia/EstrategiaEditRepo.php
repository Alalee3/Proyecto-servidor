<?php

namespace App\Repositories\Estrategia;

use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class EstrategiaEditRepo
{
    /**
     * Obtiene una estrategia por su ID.
     */
    public function obtenerPorId($id)
    {
        return DB::table('estrategia_pedagogica')
            ->where('id_estrategia_pedagogica', $id)
            ->first();
    }

    /**
     * Actualiza una estrategia existente.
     */
    public function actualizar($id, array $datos)
    {
        return DB::table('estrategia_pedagogica')
            ->where('id_estrategia_pedagogica', $id)
            ->update([
                'nombre_estrategia_pedagogica' => $datos['nombre'],
                'fecha_actualizacion' => Carbon::now()
            ]);
    }
}
