<?php

namespace App\Repositories\Tema;

use Illuminate\Support\Facades\DB;

class TemaIndexRepo
{
    public function listar($busqueda = '', $paginacion = 5)
    {
        return DB::table('tema_unidad as t')
            ->join('unidad_curricular as uc', 't.id_unidad_curricular', '=', 'uc.id_unidad_curricular')
            ->select(
                't.id_tema_unidad',
                't.titulo_tema',
                'uc.nombre_unidad_curricular',
                't.estatus'
            )
            ->when($busqueda, function ($query, $busqueda) {
                return $query->where(function ($q) use ($busqueda) {
                    $q->where('t.titulo_tema', 'LIKE', '%' . $busqueda . '%')
                        ->orWhere('uc.nombre_unidad_curricular', 'LIKE', '%' . $busqueda . '%')
                        // Búsqueda por objetivos asociados
                        ->orWhereExists(function ($sub) use ($busqueda) {
                            $sub->select(DB::raw(1))
                                ->from('objetivo as o')
                                ->whereColumn('o.id_tema_unidad', 't.id_tema_unidad')
                                ->where('o.titulo_objetivo', 'LIKE', '%' . $busqueda . '%')
                                ->where('o.estatus', '1');
                        });
                });
            })
            ->orderBy('t.fecha_creacion', 'desc')
            ->paginate($paginacion);
    }

    public function inhabilitar($id)
    {
        $tema = \App\Models\Tema::find($id);
        if ($tema) {
            return $tema->update([
                'estatus' => '3',
                'fecha_actualizacion' => now()
            ]);
        }
        return false;
    }

    public function restaurar($id)
    {
        $tema = \App\Models\Tema::where('id_tema_unidad', $id)->where('estatus', '3')->first();
        if ($tema) {
            return $tema->update([
                'estatus' => '1',
                'fecha_actualizacion' => now()
            ]);
        }
        return false;
    }
}
