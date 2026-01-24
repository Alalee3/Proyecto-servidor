<?php

namespace App\Repositories\CalendarioAcademico;

use Illuminate\Support\Facades\DB;

class CalendarioAcademicoIndexRepo
{
    public function listar($busqueda = '', $paginacion = 5)
    {
        return DB::table('calendario_academico')
            ->join('lapso_academico', 'calendario_academico.id_lapso_academico', '=', 'lapso_academico.id_lapso_academico')
            ->select(
                'calendario_academico.id_calendario_academico',
                'calendario_academico.semana',
                'calendario_academico.dia_inicio',
                'calendario_academico.dia_fin',
                'calendario_academico.carga_corte',
                'calendario_academico.estatus',
                'lapso_academico.nombre_lapso_academico as nombre_lapso'
            )
            ->when($busqueda, function ($consulta, $busqueda) {
                $consulta->where('lapso_academico.nombre_lapso_academico', 'LIKE', '%' . $busqueda . '%')
                    ->orWhere('calendario_academico.semana', 'LIKE', '%' . $busqueda . '%');
            })
            ->orderBy('calendario_academico.dia_inicio', 'desc')
            ->paginate($paginacion);
    }

    public function inhabilitar($id)
    {
        return DB::table('calendario_academico')
            ->where('id_calendario_academico', $id)
            ->update([
                'estatus' => '3'
            ]);
    }

    public function restaurar($id)
    {
        return DB::table('calendario_academico')
            ->where('id_calendario_academico', $id)
            ->where('estatus', '3')
            ->update([
                'estatus' => '1'
            ]);
    }
}
