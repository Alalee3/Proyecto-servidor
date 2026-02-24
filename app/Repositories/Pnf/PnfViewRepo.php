<?php

namespace App\Repositories\Pnf;

use Illuminate\Support\Facades\DB;

class PnfViewRepo
{
    public function mostrar($id)
    {
        $pnf = \App\Models\Pnf::find($id);
        if ($pnf) {
            \App\Models\Pnf::logMostrar($pnf);
        }
        return $pnf;
    }
}