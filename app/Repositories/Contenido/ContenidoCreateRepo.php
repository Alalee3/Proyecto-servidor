<?php

namespace App\Repositories\Contenido;

use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class ContenidoCreateRepo
{
    public function select_temas()
    {
        return DB::table('tema_unidad')
            ->select('id_tema_unidad as id', 'titulo_tema as nombre')
            ->where('estatus', '1')
            ->orderBy('titulo_tema')
            ->get();
    }

    public function select_objetivos_por_tema($idTema)
    {
        return DB::table('objetivo')
            ->select('id_objetivo as id', 'titulo_objetivo as nombre')
            ->where('id_tema_unidad', $idTema)
            ->where('estatus', '1')
            ->orderBy('id_objetivo')
            ->get();
    }

    public function crear(array $data)
    {
        return DB::transaction(function () use ($data) {
            // Insertar el contenido principal
            // Tomamos el primer objetivo para la relación directa en la tabla contenido (si existe)
            $firstObjetivo = !empty($data['id_objetivo']) ? $data['id_objetivo'][0] : null;

            $contenido = \App\Models\Contenido::create([
                'titulo_contenido' => $data['titulo_contenido'],
                'id_objetivo' => $firstObjetivo,
                'fecha_creacion' => Carbon::now(),
                'estatus' => '1',
            ]);
            $idContenido = $contenido->id_contenido;

            // Insertar múltiples objetivos en la tabla de detalles (detalle_objetivo)
            foreach ($data['id_objetivo'] as $idObjetivo) {
                DB::table('detalle_objetivo')->insert([
                    'id_contenido' => $idContenido,
                    'id_objetivo' => $idObjetivo,
                    'fecha_creacion' => Carbon::now(),
                    'estatus' => '1',
                ]);
            }

            return $idContenido;
        });
    }
}
