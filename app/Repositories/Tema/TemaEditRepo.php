<?php

namespace App\Repositories\Tema;

use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class TemaEditRepo
{
    public function mostrar($id)
    {
        $tema = DB::table('tema_unidad')
            ->where('id_tema_unidad', $id)
            ->select(
                'id_tema_unidad as id',
                'id_unidad_curricular',
                'unidad_tema',
                'titulo_tema'
            )
            ->first();

        if ($tema) {
            $tema->objetivos = DB::table('objetivo')
                ->where('id_tema_unidad', $id)
                ->where('estatus', '1')
                ->select('id_objetivo', 'titulo_objetivo')
                ->get()
                ->toArray();
        }

        return $tema;
    }

    public function editar($id, array $data)
    {
        return DB::transaction(function () use ($id, $data) {
            // Actualizar el tema
            DB::table('tema_unidad')
                ->where('id_tema_unidad', $id)
                ->update([
                    'id_unidad_curricular' => $data['id_unidad_curricular'],
                    'unidad_tema' => $data['unidad_tema'],
                    'titulo_tema' => $data['titulo_tema'],
                    'fecha_actualizacion' => Carbon::now(),
                ]);

            // Manejar los objetivos (Eliminar los que ya no están y actualizar/insertar nuevos)
            // Para simplificar en este entorno, inhabilitamos los actuales y re-insertamos los que vienen del form
            DB::table('objetivo')
                ->where('id_tema_unidad', $id)
                ->update(['estatus' => '3', 'fecha_actualizacion' => Carbon::now()]);

            foreach ($data['objetivos'] as $objetivo) {
                // Convertir a array si es un objeto para evitar el error "Cannot use object of type stdClass as array"
                $objArray = (array) $objetivo;
                
                if (!empty($objArray['titulo_objetivo'])) {
                    DB::table('objetivo')->insert([
                        'id_tema_unidad' => $id,
                        'titulo_objetivo' => $objArray['titulo_objetivo'],
                        'fecha_creacion' => Carbon::now(),
                        'estatus' => '1',
                    ]);
                }
            }

            return true;
        });
    }
}
