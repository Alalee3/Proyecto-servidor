<?php

namespace App\Repositories\CalendarioAcademico;

use Illuminate\Support\Facades\DB;

class CalendarioAcademicoIndexRepo
{
    public function listar($busqueda = '', $paginacion = 5)
    {
        return DB::table('calendario_academico')
            ->leftJoin('lapso_academico', 'calendario_academico.id_lapso_academico', '=', 'lapso_academico.id_lapso_academico')
            ->select(
                'calendario_academico.id_calendario_academico',
                'calendario_academico.semana_calendario_academico as semana',
                'calendario_academico.dia_inicio_calendario_academico as dia_inicio',
                'calendario_academico.dia_fin_calendario_academico as dia_fin',
                'calendario_academico.estatus',
                'lapso_academico.nombre_lapso_academico as nombre_lapso'
            )
            ->when($busqueda, function ($consulta, $busqueda) {
                $consulta->where('lapso_academico.nombre_lapso_academico', 'LIKE', '%' . $busqueda . '%')
                    ->orWhere('calendario_academico.semana_calendario_academico', 'LIKE', '%' . $busqueda . '%');
            })
            ->orderBy('calendario_academico.dia_inicio_calendario_academico', 'desc')
            ->paginate($paginacion);
    }
}
