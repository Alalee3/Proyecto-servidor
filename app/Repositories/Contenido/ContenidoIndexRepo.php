<?php

namespace App\Repositories\Contenido;

use Illuminate\Support\Facades\DB;

class ContenidoIndexRepo
{
    public function listar($busqueda = '', $paginacion = 5)
    {
        return DB::table('contenido as c')
            ->join('objetivo as o', 'c.id_objetivo', '=', 'o.id_objetivo')
            ->join('tema_unidad as t', 'o.id_tema_unidad', '=', 't.id_tema_unidad')
            ->join('unidad_curricular as uc', 't.id_unidad_curricular', '=', 'uc.id_unidad_curricular')
            ->select(
                'c.id_contenido',
                'c.titulo_contenido',
                'uc.nombre_unidad_curricular',
                't.titulo_tema',
                'c.estatus'
            )
            ->when($busqueda, function ($query, $busqueda) {
                return $query->where(function ($q) use ($busqueda) {
                    $q->where('c.titulo_contenido', 'LIKE', '%' . $busqueda . '%')
                        ->orWhere('uc.nombre_unidad_curricular', 'LIKE', '%' . $busqueda . '%')
                        ->orWhere('t.titulo_tema', 'LIKE', '%' . $busqueda . '%');
                });
            })
            ->orderBy('c.fecha_creacion', 'desc')
            ->paginate($paginacion);
    }

    public function inhabilitar($id)
    {
        $contenido = \App\Models\Contenido::find($id);
        if ($contenido) {
            return $contenido->update([
                'estatus' => '3',
                'fecha_actualizacion' => now()
            ]);
        }
        return false;
    }

    public function restaurar($id)
    {
        $contenido = \App\Models\Contenido::where('id_contenido', $id)->where('estatus', '3')->first();
        if ($contenido) {
            return $contenido->update([
                'estatus' => '1',
                'fecha_actualizacion' => now()
            ]);
        }
        return false;
    }
}
