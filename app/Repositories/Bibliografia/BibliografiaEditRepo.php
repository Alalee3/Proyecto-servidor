<?php

namespace App\Repositories\Bibliografia;

use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class BibliografiaEditRepo
{
    public function obtenerPorId($id)
    {
        return DB::table('bibliografia')
            ->where('id_bibliografia', $id)
            ->first();
    }

    public function actualizar($id, array $datos)
    {
        $bibliografia = \App\Models\Bibliografia::find($id);
        if ($bibliografia) {
            return $bibliografia->update([
                'nombre_bibliografia' => $datos['nombre'],
                'fecha_actualizacion' => Carbon::now()
            ]);
        }
        return false;
    }
}
