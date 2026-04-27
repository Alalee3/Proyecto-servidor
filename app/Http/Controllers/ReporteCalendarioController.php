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
     * Lógica compartida para generar el archivo Excel.
     */
    private function generarExcel($calendario)
    {
        // Determinar el año a mostrar (el año del inicio del calendario)
        $year = Carbon::parse($calendario->dia_inicio_calendario_academico)->year;

        // Obtener días con eventos para este año
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

        $eventDays = [];
        $eventColors = [];
        $palette = ['#007BFF', '#28A745', '#DC3545', '#FD7E14', '#6610F2'];

        foreach ($eventosRaw as $index => $eventoItem) {
            $color = $eventoItem->codigo_color ?? $palette[$index % count($palette)];
            $eventColors[$eventoItem->id_evento] = $color;

            $start = Carbon::parse($eventoItem->dia_inicio_evento);
            $end = Carbon::parse($eventoItem->dia_fin_evento);

            while ($start <= $end) {
                if ($start->year == $year) {
                    if (!isset($eventDays[$start->format('Y-m-d')])) {
                        $eventDays[$start->format('Y-m-d')] = [
                            'ids' => [],
                            'nombres' => []
                        ];
                    }
                    $eventDays[$start->format('Y-m-d')]['ids'][] = $eventoItem->id_evento;
                    $eventDays[$start->format('Y-m-d')]['nombres'][] = $eventoItem->descripcion_evento;
                }
                $start->addDay();
            }
        }

        return Excel::download(new CalendarioExport([
            'calendario' => $calendario,
            'year' => $year,
            'eventDays' => $eventDays,
            'eventColors' => $eventColors,
            'eventos' => $eventosRaw
        ]), 'calendario_academico_' . $year . '.xlsx');
    }
}
