<?php

namespace App\Repositories\Tecnica;

use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class TecnicaEditRepo
{
    /**
     * Obtiene una técnica por su ID.
     */
    public function obtenerPorId($id)
    {
        return DB::table('tecnica_evaluacion')
            ->where('id_tecnica', $id)
            ->first();
    }

    /**
     * Actualiza una técnica existente.
     */
    public function actualizar($id, array $datos)
    {
        $tecnica = \App\Models\Tecnica::find($id);
        if ($tecnica) {
            return $tecnica->update([
                'nombre_tecnica_evaluacion' => $datos['nombre'],
                'fecha_actualizacion' => Carbon::now()
            ]);
        }
        return false;
    }
}
