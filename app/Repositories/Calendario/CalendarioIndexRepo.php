<?php

namespace App\Repositories\Calendario;

use Illuminate\Support\Facades\DB;

class CalendarioIndexRepo
{
    public function listar($busqueda = '', $paginacion = 5)
    {
        // Inactivar automáticamente los que han vencido
        \App\Models\CalendarioAcademico::inactivarVencidos();

        $calendarios = DB::table('calendario_academico')
            ->select('id_calendario_academico', 'semana_calendario_academico', 'dia_inicio_calendario_academico', 'dia_fin_calendario_academico', 'estatus')
            ->when($busqueda, function ($consulta, $busqueda) {
                $consulta->where('semana_calendario_academico', 'LIKE', '%' . $busqueda . '%');
            })
            ->orderBy('semana_calendario_academico', 'asc')
            ->paginate($paginacion);

        return $calendarios;
    }

    public function hayCalendarioActivo(): bool
    {
        return DB::table('calendario_academico')
            ->where('estatus', '1')
            ->exists();
    }
}
