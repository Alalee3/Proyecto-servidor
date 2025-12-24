<?php

namespace App\Repositories\Estrategia;

use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class EstrategiaIndexRepo
{
    /**
     * Lista las estrategias pedagógicas con búsqueda y paginación.
     */
    public function listar($busqueda = '', $paginacion = 5)
    {
        return DB::table('estrategia_pedagogica')
            ->select('id_estrategia_pedagogica', 'nombre_estrategia_pedagogica as nombre', 'estatus')
            ->when($busqueda, function ($consulta, $busqueda) {
                $consulta->where('nombre_estrategia_pedagogica', 'LIKE', '%' . $busqueda . '%');
            })
            ->orderBy('nombre_estrategia_pedagogica')
            ->paginate($paginacion);
    }

    /**
     * Inhabilita una estrategia pedagógica.
     */
    public function inhabilitar($id)
    {
        return DB::table('estrategia_pedagogica')
            ->where('id_estrategia_pedagogica', $id)
            ->update([
                'estatus' => '2',
                'fecha_actualizacion' => Carbon::now()
            ]);
    }

    /**
     * Restaura una estrategia pedagógica.
     */
    public function restaurar($id)
    {
        return DB::table('estrategia_pedagogica')
            ->where('id_estrategia_pedagogica', $id)
            ->update([
                'estatus' => '1',
                'fecha_actualizacion' => Carbon::now()
            ]);
    }
}
