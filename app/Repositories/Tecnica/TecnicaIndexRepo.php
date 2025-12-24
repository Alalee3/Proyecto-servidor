<?php

namespace App\Repositories\Tecnica;

use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class TecnicaIndexRepo
{
    /**
     * Lista las técnicas con búsqueda y paginación.
     */
    public function listar($busqueda = '', $paginacion = 5)
    {
        return DB::table('tecnica')
            ->select('id_tecnica', 'nombre_tecnica as nombre', 'estatus')
            ->when($busqueda, function ($consulta, $busqueda) {
                $consulta->where('nombre_tecnica', 'LIKE', '%' . $busqueda . '%');
            })
            ->orderBy('nombre_tecnica')
            ->paginate($paginacion);
    }

    /**
     * Inhabilita una técnica.
     */
    public function inhabilitar($id)
    {
        return DB::table('tecnica')
            ->where('id_tecnica', $id)
            ->update([
                'estatus' => '2',
                'fecha_actualizacion' => Carbon::now()
            ]);
    }

    /**
     * Restaura una técnica.
     */
    public function restaurar($id)
    {
        return DB::table('tecnica')
            ->where('id_tecnica', $id)
            ->update([
                'estatus' => '1',
                'fecha_actualizacion' => Carbon::now()
            ]);
    }
}
