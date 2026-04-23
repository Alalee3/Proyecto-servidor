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
        return DB::table('tecnica_actividad')
            ->where('id_tecnica_actividad', $id)
            ->first();
    }

    /**
     * Actualiza una estrategia existente.
     */
    public function actualizar($id, array $datos)
    {
        $estrategia = \App\Models\Estrategia::find($id);
        if ($estrategia) {
            return $estrategia->update([
                'nombre_tecnica_actividad' => $datos['nombre']
            ]);
        }
        return false;
    }
}
