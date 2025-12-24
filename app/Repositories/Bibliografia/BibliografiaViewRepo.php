<?php

namespace App\Repositories\Bibliografia;

use Illuminate\Support\Facades\DB;

class BibliografiaViewRepo
{
    public function mostrar($id)
    {
        return DB::table('bibliografia')
            ->where('id_bibliografia', $id)
            ->first();
    }
}
