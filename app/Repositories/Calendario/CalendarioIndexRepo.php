<?php

namespace App\Repositories\Calendario;

use Illuminate\Support\Facades\DB;

class CalendarioIndexRepo
{
    public function listar($busqueda = '', $paginacion = 5)
    {
        $calendarios = DB::table('calendario_academico')
            ->select('id_calendario_academico', 'semana_calendario_academico', 'dia_inicio_calendario_academico', 'dia_fin_calendario_academico', 'estatus')
            ->when($busqueda, function ($consulta, $busqueda) {
                $consulta->where('semana_calendario_academico', 'LIKE', '%' . $busqueda . '%');
            })
            ->orderBy('semana_calendario_academico', 'asc')
            ->paginate($paginacion);

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

    public function hayCalendarioActivo(): bool
    {
        return DB::table('calendario_academico')
            ->where('estatus', '1')
            ->exists();
    }
}
