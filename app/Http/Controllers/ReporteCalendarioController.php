<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
use App\Exports\CalendarioExport;
use Maatwebsite\Excel\Facades\Excel;

class ReporteCalendarioController extends Controller
{
    /**
     * Genera el reporte del último calendario académico activo.
     */
    public function reporteUltimoCalendario()
    {
        $calendario = DB::table('calendario_academico')
            ->where('estatus', 1)
            ->orderBy('id_calendario_academico', 'desc')
            ->first();

        if (!$calendario) {
            return redirect()->back()->with('error', 'No existe ningún calendario académico activo para imprimir.');
        }

        return $this->generarExcel($calendario);
    }

    /**
     * Genera el reporte de un calendario específico por ID.
     */
    public function reporteCalendario($id)
    {
        $calendario = DB::table('calendario_academico')
            ->where('id_calendario_academico', $id)
            ->first();

        if (!$calendario) {
            return redirect()->back()->with('error', 'El calendario solicitado no existe.');
        }

        return $this->generarExcel($calendario);
    }

    /**
     * Lógica compartida para generar el archivo Excel multi-año.
     */
    private function generarExcel($calendario)
    {
        $startYear = Carbon::parse($calendario->dia_inicio_calendario_academico)->year;
        $endYear   = Carbon::parse($calendario->dia_fin_calendario_academico)->year;

        // Obtener TODOS los eventos del calendario
        $eventosRaw = DB::table('evento')
            ->join('detalle_evento', 'evento.id_evento', '=', 'detalle_evento.id_evento')
            ->leftJoin('color', 'evento.id_color', '=', 'color.id_color')
            ->select(
                'evento.id_evento',
                'evento.nombre_evento as descripcion_evento',
                'detalle_evento.dia_inicio_detalle_evento as dia_inicio_evento',
                'detalle_evento.dia_fin_detalle_evento as dia_fin_evento',
                'color.codigo_color'
            )
            ->where('detalle_evento.id_calendario_academico', $calendario->id_calendario_academico)
            ->where('evento.estatus', 1)
            ->get();

        // Construir paleta de colores por evento
        $eventColors = [];
        $palette = ['#007BFF', '#28A745', '#DC3545', '#FD7E14', '#6610F2'];
        foreach ($eventosRaw as $index => $eventoItem) {
            $color = $eventoItem->codigo_color ?? $palette[$index % count($palette)];
            $eventColors[$eventoItem->id_evento] = $color;
        }

        // Construir mapa de días con eventos por AÑO
        // eventDaysByYear[2025]['2025-03-10'] = ['ids'=>[...], 'nombres'=>[...]]
        $eventDaysByYear = [];
        for ($y = $startYear; $y <= $endYear; $y++) {
            $eventDaysByYear[$y] = [];
        }

        foreach ($eventosRaw as $eventoItem) {
            $start = Carbon::parse($eventoItem->dia_inicio_evento);
            $end   = Carbon::parse($eventoItem->dia_fin_evento);

            while ($start <= $end) {
                $y = $start->year;
                if (isset($eventDaysByYear[$y])) {
                    $dateStr = $start->format('Y-m-d');
                    if (!isset($eventDaysByYear[$y][$dateStr])) {
                        $eventDaysByYear[$y][$dateStr] = ['ids' => [], 'nombres' => []];
                    }
                    $eventDaysByYear[$y][$dateStr]['ids'][]     = $eventoItem->id_evento;
                    $eventDaysByYear[$y][$dateStr]['nombres'][] = $eventoItem->descripcion_evento;
                }
                $start->addDay();
            }
        }

        $years = range($startYear, $endYear);

        return Excel::download(new CalendarioExport([
            'calendario'      => $calendario,
            'years'           => $years,
            'startYear'       => $startYear,
            'endYear'         => $endYear,
            'eventDaysByYear' => $eventDaysByYear,
            'eventColors'     => $eventColors,
            'eventos'         => $eventosRaw,
            // Compatibilidad con código legacy que use $year y $eventDays
            'year'            => $startYear,
            'eventDays'       => $eventDaysByYear[$startYear] ?? [],
        ]), 'calendario_academico_' . $startYear . '-' . $endYear . '.xlsx');
    }
}
