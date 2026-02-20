<?php

namespace App\Repositories\Contenido;

use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class ContenidoEditRepo
{
    public function mostrar($id)
    {
        $contenido = DB::table('contenido as c')
            ->leftJoin('objetivo as o', 'c.id_objetivo', '=', 'o.id_objetivo')
            ->where('c.id_contenido', $id)
            ->select(
                'c.id_contenido as id',
                'o.id_tema_unidad as id_tema', // Para que el form sepa el tema
                'c.id_objetivo',
                'c.titulo_contenido'
            )
            ->first();

        if ($contenido) {
            $contenido->id_objetivo = DB::table('detalle_objetivo')
                ->where('id_contenido', $id)
                ->where('estatus', '1')
                ->pluck('id_objetivo')
                ->toArray();
        }

        return $contenido;
    }

    public function editar($id, array $data)
    {
        return DB::transaction(function () use ($id, $data) {
            $firstObjetivo = !empty($data['id_objetivo']) ? $data['id_objetivo'][0] : null;

            // Actualizar contenido principal
            DB::table('contenido')
                ->where('id_contenido', $id)
                ->update([
                    'id_objetivo' => $firstObjetivo,
                    'titulo_contenido' => $data['titulo_contenido'],
                    'fecha_actualizacion' => Carbon::now(),
                ]);

            // Sincronizar objetivos en tabla de detalles
            DB::table('detalle_objetivo')
                ->where('id_contenido', $id)
                ->update(['estatus' => '3', 'fecha_actualizacion' => Carbon::now()]);

            foreach ($data['id_objetivo'] as $idObjetivo) {
                DB::table('detalle_objetivo')->insert([
                    'id_contenido' => $id,
                    'id_objetivo' => $idObjetivo,
                    'fecha_creacion' => Carbon::now(),
                    'estatus' => '1',
                ]);
            }

            return true;
        });
    }
}
