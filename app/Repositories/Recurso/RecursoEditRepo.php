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
        $recurso = \App\Models\Recurso::find($id);
        if ($recurso) {
            return $recurso->update([
                'nombre_recurso' => $datos['nombre']
            ]);
        }
        return false;
    }
}
