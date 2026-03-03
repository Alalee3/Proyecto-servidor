<?php

namespace App\Repositories\Permiso;

use Illuminate\Support\Facades\DB;

class PermisoViewRepo
{
    public function mostrar($id)
    {
        $permiso = DB::table('permiso')
            ->where('id_permiso', $id)
            ->first();

        if ($permiso) {
            \App\Models\Permiso::logMostrar(\App\Models\Permiso::find($id));
        }

        return $permiso;
    }
}
