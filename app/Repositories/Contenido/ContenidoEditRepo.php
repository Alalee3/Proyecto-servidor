<?php

namespace App\Repositories\Contenido;

use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class ContenidoEditRepo
{
    public function mostrar($id)
    {
        $contenido = \App\Models\Contenido::find($id);

        if ($contenido) {
            \App\Models\Contenido::logMostrar($contenido);

            // Preparar datos para el formulario (compatibilidad)
            $idTema = DB::table('objetivo')
                ->where('id_objetivo', $contenido->id_objetivo)
                ->value('id_tema_unidad');

            $formContent = (object) [
                'id' => $contenido->id_contenido,
                'id_tema' => $idTema,
                'titulo_contenido' => $contenido->titulo_contenido,
                'id_objetivo' => DB::table('detalle_objetivo')
                    ->where('id_contenido', $id)
                    ->where('estatus', '1')
                    ->pluck('id_objetivo')
                    ->toArray()
            ];

            return $formContent;
        }

        return null;
    }

    public function editar($id, array $data)
    {
        return DB::transaction(function () use ($id, $data) {
            $firstObjetivo = !empty($data['id_objetivo']) ? $data['id_objetivo'][0] : null;

            // Actualizar contenido principal
            $contenidoUpdated = \App\Models\Contenido::find($id);
            if ($contenidoUpdated) {
                $contenidoUpdated->update([
                    'id_objetivo' => $firstObjetivo,
                    'titulo_contenido' => $data['titulo_contenido'],
                    'fecha_actualizacion' => Carbon::now(),
                ]);
            }

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
