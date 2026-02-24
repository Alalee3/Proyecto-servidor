<?php

namespace App\Repositories\Bitacora;

use Illuminate\Support\Facades\DB;

class BitacoraViewRepo
{
    public function mostrar($id)
    {
        return DB::table('bitacora as b')
            ->leftJoin('users as u', 'b.id_users', '=', 'u.id')
            ->select(
                'b.id_bitacora',
                'u.name as usuario_nombre',
                'u.email as usuario_correo',
                'b.tabla_afectada_bitacora as tabla',
                'b.id_registro_afectado_bitacora as registro_id',
                'b.accion_bitacora as accion',
                'b.valores_anteriores_bitacora as anteriores',
                'b.valores_nuevos_bitacora as nuevos',
                'b.ip_origen_bitacora as ip',
                'b.fecha_creacion as fecha'
            )
            ->where('b.id_bitacora', $id)
            ->first();
    }
}
