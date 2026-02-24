<?php

namespace App\Repositories\Recurso;

use Illuminate\Support\Facades\DB;

class RecursoViewRepo
{
    public function mostrar($id)
    {
        $recurso = \App\Models\Recurso::find($id);
        if ($recurso) {
            \App\Models\Recurso::logMostrar($recurso);
        }
        return $recurso;
    }
}
