<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Barryvdh\DomPDF\Facade\Pdf;
use Carbon\Carbon;

class ReporteCalendarioController extends Controller
{
    /**
     * Genera el reporte del último calendario académico.
     */
    public function reporteUltimoCalendario()
    {
        $calendario = DB::table('calendario_academico')
            ->orderBy('id_calendario_academico', 'desc')
            ->first();

        if (!$calendario) {
            return redirect()->back()->with('error', 'No existe ningún calendario académico para imprimir.');
        }

        // Obtener nombre del lapso desde DAECE
        $lapso = DB::connection('external_db')->table('lapso_academico')
            ->where('lap_codigo', $calendario->id_lapso_academico)
            ->first();
        
        $calendario->nombre_lapso = $lapso ? $lapso->lap_nombre : 'No definido (DAECE)';

        $pdf = Pdf::loadView('livewire.pages.calendario.pdf-calendario', [
            'calendario' => $calendario
        ]);

        return $pdf->stream('calendario_academico.pdf');
    }
}
