<?php

namespace App\Repositories\Evento;

use Illuminate\Support\Facades\DB;

class EventoIndexRepo
{
    public function listar($busqueda = '', $paginacion = 5)
    {
        return DB::table('evento')
            ->select('id_evento', 'descripcion_evento', 'dia_inicio_evento', 'dia_fin_evento', 'semana_evento', 'tipo_evento', 'estatus')
            ->when($busqueda, function ($consulta, $busqueda) {
                $consulta->where('descripcion_evento', 'LIKE', '%' . $busqueda . '%');
            })
            ->orderBy('dia_inicio_evento', 'desc')
            ->paginate($paginacion);
    }

    public function inhabilitar($id)
    {
        $evento = \App\Models\Evento::find($id);
        if ($evento) {
            return $evento->update([
                'estatus' => '3'
            ]);
        }
        return false;
    }

    public function restaurar($id)
    {
        $evento = \App\Models\Evento::where('id_evento', $id)->where('estatus', '3')->first();
        if ($evento) {
            return $evento->update([
                'estatus' => '1'
            ]);
        }
        return false;
    }
}
