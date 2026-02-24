<?php

namespace App\Repositories\Bibliografia;

use Illuminate\Support\Facades\DB;

class BibliografiaViewRepo
{
    public function mostrar($id)
    {
        $bibliografia = \App\Models\Bibliografia::find($id);
        if ($bibliografia) {
            \App\Models\Bibliografia::logMostrar($bibliografia);
        }
        return $bibliografia;
    }
}
