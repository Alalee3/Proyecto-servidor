<?php

namespace App\Repositories\Tema;

use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class TemaCreateRepo
{
    public function select_unidades_curriculares()
    {
        return DB::connection('external_db')->table('unidad_curricular')
            ->select('ucu_codigo as id', 'ucu_nombre as nombre')
            ->where('ucu_estatus', 'A')
            ->get();
    }

    public function crear(array $data)
    {
        return DB::transaction(function () use ($data) {
            $tema = \App\Models\Tema::create([
                'id_unidad_curricular' => $data['id_unidad_curricular'],
                'titulo_tema' => $data['titulo_tema'],
                'unidad_tema' => $data['unidad_tema'],
                'estatus' => '1',
            ]);
            $temaId = $tema->id_tema_unidad;

            foreach ($data['objetivos'] as $objetivo) {
                if (!empty($objetivo['titulo_objetivo'])) {
                    DB::table('objetivo')->insert([
                        'id_tema_unidad' => $temaId,
                        'titulo_objetivo' => $objetivo['titulo_objetivo'],
                        'estatus' => '1',
                    ]);
                }
            }

            return $temaId;
        });
    }
}
