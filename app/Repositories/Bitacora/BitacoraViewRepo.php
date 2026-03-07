<?php

namespace App\Repositories\Bitacora;

use Illuminate\Support\Facades\DB;

class BitacoraViewRepo
{
    public function mostrar($id)
    {
        $registro = \App\Models\Bitacora::from('bitacora as b')
            ->select(
                'b.id_bitacora',
                'b.id_usuario',
                'b.modulo_afectado_bitacora as modulo',
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

        if ($registro && $registro->id_usuario) {
            // Buscar datos del usuario en la BD externa
            $usuarioExterno = DB::connection('external_db')
                ->table('usuario')
                ->where('usu_codigo', $registro->id_usuario)
                ->first();

            if ($usuarioExterno) {
                $registro->usuario_nombre = $usuarioExterno->usu_nombre;
                // Si la tabla externa no tiene correo, podrías poner un fallback
                $registro->usuario_correo = $usuarioExterno->usu_nombre . '.';
            } else {
                $registro->usuario_nombre = 'Usuario ' . $registro->id_usuario . ' (No encontrado)';
                $registro->usuario_correo = 'N/A';
            }
        }

        return $registro;
    }
}
