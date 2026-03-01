<?php

namespace App\Repositories\Evento;

use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class EventoCreateRepo
{
    public function crear(array $data)
    {
        if (empty($data['id_calendario'])) {
            $activo = DB::table('calendario_academico')->where('estatus', '1')->first();
            if (!$activo) {
                // Si no hay nada activo, lanzamos una excepción o retornamos un valor que evite el insert
                throw new \Exception('No se puede registrar el evento porque no existe un calendario académico activo.');
            }
            $data['id_calendario'] = $activo->id_calendario_academico;
        }

        $evento = \App\Models\Evento::create([
            'id_calendario' => $data['id_calendario'],
            'dia_inicio_evento' => $data['dia_inicio_evento'],
            'dia_fin_evento' => $data['dia_fin_evento'],
            'semana_evento' => $data['semana_evento'],
            'descripcion_evento' => $data['descripcion_evento'],
            'tipo_evento' => $data['tipo_evento'],
            'fecha_creacion' => Carbon::now(),
            'estatus' => '1',
        ]);

        return $evento->getKey();
    }

    public function existeEventoConDescripcion(string $descripcion, ?int $idCalendario): bool
    {
        return DB::table('evento')
            ->where('id_calendario', $idCalendario)
            ->where('descripcion_evento', $descripcion)
            ->where('estatus', '!=', '3')
            ->exists();
    }
}
