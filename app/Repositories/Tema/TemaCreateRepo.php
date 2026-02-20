<?php

namespace App\Repositories\Tema;

use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class TemaCreateRepo
{
    public function select_unidades_curriculares()
    {
        return DB::table('unidad_curricular')
            ->select('id_unidad_curricular as id', 'nombre_unidad_curricular as nombre')
            ->where('estatus', '1')
            ->get();
    }

    public function crear(array $data)
    {
        return DB::transaction(function () use ($data) {
            $temaId = DB::table('tema_unidad')->insertGetId([
                'id_unidad_curricular' => $data['id_unidad_curricular'],
                'titulo_tema' => $data['titulo_tema'],
                'unidad_tema' => $data['unidad_tema'],
                'fecha_creacion' => Carbon::now(),
                'fecha_actualizacion' => null,
                'estatus' => '1',
            ]);

            foreach ($data['objetivos'] as $objetivo) {
                if (!empty($objetivo['titulo_objetivo'])) {
                    DB::table('objetivo')->insert([
                        'id_tema_unidad' => $temaId,
                        'titulo_objetivo' => $objetivo['titulo_objetivo'],
                        'fecha_creacion' => Carbon::now(),
                        'estatus' => '1',
                    ]);
                }
            }

            return $temaId;
        });
    }
}
