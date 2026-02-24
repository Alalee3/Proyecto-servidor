<?php

namespace App\Repositories\Bitacora;

use Illuminate\Support\Facades\DB;

class BitacoraIndexRepo
{
    public function listar($busqueda = '', $paginacion = 10)
    {
        return DB::table('bitacora as b')
            ->leftJoin('users as u', 'b.id_users', '=', 'u.id')
            ->select(
                'b.id_bitacora',
                'u.name as usuario_nombre',
                'b.tabla_afectada_bitacora as tabla',
                'b.id_registro_afectado_bitacora as registro_id',
                'b.accion_bitacora as accion',
                'b.valores_anteriores_bitacora as anteriores',
                'b.valores_nuevos_bitacora as nuevos',
                'b.ip_origen_bitacora as ip',
                'b.fecha_creacion as fecha',
                'b.estatus'
            )
            ->when($busqueda, function ($consulta, $busqueda) {
                $consulta->where(function ($q) use ($busqueda) {
                    $q->where('u.name', 'LIKE', '%' . $busqueda . '%')
                        ->orWhere('b.tabla_afectada_bitacora', 'LIKE', '%' . $busqueda . '%')
                        ->orWhere('b.accion_bitacora', 'LIKE', '%' . $busqueda . '%')
                        ->orWhere('b.ip_origen_bitacora', 'LIKE', '%' . $busqueda . '%');
                });
            })
            ->orderBy('b.fecha_creacion', 'desc')
            ->paginate($paginacion);
    }
}
