<?php

namespace App\Repositories\IndicadorLogro;

use Illuminate\Support\Facades\DB;

class IndicadorLogroIndexRepo
{
    public function obtener_indicadores($busqueda = null, $paginacion = 5)
    {
        $query = DB::table('indicador_logro')
            ->select('id_indicador_logro', 'nombre_indicador_logro', 'estatus')
            ->where('estatus', '!=', '3'); // No traer eliminados

        if ($busqueda) {
            $query->where('nombre_indicador_logro', 'like', '%' . $busqueda . '%');
        }

        return $query->orderBy('id_indicador_logro', 'desc')->paginate($paginacion);
    }

    public function inhabilitar($id)
    {
        return DB::table('indicador_logro')
            ->where('id_indicador_logro', $id)
            ->update(['estatus' => '2']);
    }

    public function restaurar($id)
    {
        return DB::table('indicador_logro')
            ->where('id_indicador_logro', $id)
            ->update(['estatus' => '1']);
    }
}
