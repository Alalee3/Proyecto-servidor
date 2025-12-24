<?php

namespace App\Repositories\Recurso;

use Illuminate\Support\Facades\DB;

class RecursoViewRepo
{
    public function mostrar($id)
    {
        return DB::table('recurso')
            ->where('id_recurso', $id)
            ->first();
    }
}
