<?php

namespace App\Repositories\Calendario;

use App\Models\CalendarioAcademico;
use Exception;

class NotasCalendarioRepo
{
    public function obtenerCalendario($id)
    {
        return CalendarioAcademico::findOrFail($id);
    }

    public function actualizarNotas(CalendarioAcademico $calendario, array $notas)
    {
        try {
            $calendario->update([
                'nota_calendario_academico' => $notas
            ]);
            return true;
        } catch (Exception $e) {
            throw $e;
        }
    }
}
