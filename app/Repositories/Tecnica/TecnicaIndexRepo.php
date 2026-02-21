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
        return DB::table('tecnica_evaluacion')
            ->select('id_tecnica', 'nombre_tecnica_evaluacion as nombre', 'estatus')
            ->when($busqueda, function ($consulta, $busqueda) {
                $consulta->where('nombre_tecnica_evaluacion', 'LIKE', '%' . $busqueda . '%');
            })
            ->orderBy('fecha_creacion', 'desc')
            ->paginate($paginacion);
    }

    /**
     * Inhabilita una técnica.
     */
    public function inhabilitar($id)
    {
        return DB::table('tecnica_evaluacion')
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
        return DB::table('tecnica_evaluacion')
            ->where('id_tecnica', $id)
            ->update([
                'estatus' => '1',
                'fecha_actualizacion' => Carbon::now()
            ]);
    }
}
