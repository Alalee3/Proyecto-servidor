<?php

namespace App\Repositories\Bitacora;

use Illuminate\Support\Facades\DB;

class BitacoraIndexRepo
{
    public function listar($busqueda = '', $paginacion = 10)
    {
        $bitacora = \App\Models\Bitacora::from('bitacora as b')
            ->select(
                'b.id_bitacora',
                'b.id_usuario',
                'b.modulo_afectado_bitacora as modulo',
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
                    $q->where('b.modulo_afectado_bitacora', 'LIKE', '%' . $busqueda . '%')
                        ->orWhere('b.accion_bitacora', 'LIKE', '%' . $busqueda . '%')
                        ->orWhere('b.ip_origen_bitacora', 'LIKE', '%' . $busqueda . '%')
                        ->orWhere('b.id_usuario', 'LIKE', '%' . $busqueda . '%');
                });
            })
            ->orderBy('b.fecha_creacion', 'desc')
            ->paginate($paginacion);

        // Extraer IDs únicos de usuarios para consulta externa
        $userIds = $bitacora->pluck('id_usuario')->filter()->unique();

        if ($userIds->isNotEmpty()) {
            // Consultar nombres en la BD externa (emulacion_sogac_2)
            $usuariosExternos = DB::connection('external_db')
                ->table('usuario')
                ->whereIn('usu_codigo', $userIds)
                ->pluck('usu_nombre', 'usu_codigo');

            // Adjuntar el nombre al resultado
            $bitacora->getCollection()->transform(function ($item) use ($usuariosExternos) {
                $item->usuario_nombre = $usuariosExternos[$item->id_usuario] ?? 'Usuario ' . $item->id_usuario;
                return $item;
            });
        }

        return $bitacora;
    }
}
