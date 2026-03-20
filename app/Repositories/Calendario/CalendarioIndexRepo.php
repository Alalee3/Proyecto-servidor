<?php

namespace App\Repositories\Calendario;

use Illuminate\Support\Facades\DB;

class CalendarioIndexRepo
{
    public function listar($busqueda = '', $paginacion = 5)
    {
        $calendarios = DB::table('calendario_academico')
            ->select('id_calendario_academico', 'id_lapso_academico', 'semana_calendario_academico', 'dia_inicio_calendario_academico', 'dia_fin_calendario_academico', 'estatus')
            ->when($busqueda, function ($consulta, $busqueda) {
                $consulta->where('semana_calendario_academico', 'LIKE', '%' . $busqueda . '%');
            })
            ->orderBy('id_lapso_academico', 'desc')
            ->orderBy('semana_calendario_academico', 'asc')
            ->paginate($paginacion);

        // Obtener nombres de lapsos desde la base de datos externa DAECE
        $idLapsos = $calendarios->pluck('id_lapso_academico')->filter()->unique()->toArray();
        $lapsosDaece = DB::connection('pgsql_daece')->table('lapso_academico')
            ->whereIn('lap_codigo', $idLapsos)
            ->pluck('lap_nombre', 'lap_codigo');

        // Mapear los nombres a la colección
        $calendarios->getCollection()->transform(function ($calendario) use ($lapsosDaece) {
            $calendario->nombre_lapso = $lapsosDaece[$calendario->id_lapso_academico] ?? 'No definido (DAECE)';
            return $calendario;
        });

        return $calendarios;
    }

    public function inhabilitar($id)
    {
        $calendario = \App\Models\CalendarioAcademico::find($id);
        if ($calendario) {
            return $calendario->update(['estatus' => '3']);
        }
        return false;
    }

    public function restaurar($id)
    {
        $calendario = \App\Models\CalendarioAcademico::where('id_calendario_academico', $id)->where('estatus', '3')->first();
        if ($calendario) {
            return $calendario->update(['estatus' => '1']);
        }
        return false;
    }
}
