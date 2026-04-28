<?php

namespace App\Exports;

use Illuminate\Contracts\View\View;
use Maatwebsite\Excel\Concerns\FromView;
use Maatwebsite\Excel\Concerns\ShouldAutoSize;
use Maatwebsite\Excel\Concerns\WithStyles;
use Maatwebsite\Excel\Concerns\WithDrawings;
use Maatwebsite\Excel\Concerns\WithEvents;
use Maatwebsite\Excel\Events\AfterSheet;
use PhpOffice\PhpSpreadsheet\Worksheet\Drawing;
use PhpOffice\PhpSpreadsheet\Worksheet\Worksheet;
use PhpOffice\PhpSpreadsheet\Cell\Coordinate;

class CalendarioExport implements FromView, ShouldAutoSize, WithStyles, WithDrawings, WithEvents
{
    protected $data;

    public function __construct($data)
    {
        $this->data = $data;
    }

    public function view(): View
    {
        return view('exports.calendario', $this->data);
    }

    public function styles(Worksheet $sheet)
    {
        return [
            // Estilos para el título principal en la fila 10
            10 => ['font' => ['bold' => true, 'size' => 14]],
        ];
    }

    public function drawings()
    {
        $drawing = new Drawing();
        $drawing->setName('Header');
        $drawing->setDescription('Header de Reporte');
        $drawing->setPath(public_path('img/reportes.jpg'));
        $drawing->setHeight(110); // Ajustar altura
        $drawing->setCoordinates('A1'); // Colocar en A1

        return $drawing;
    }

    /**
     * Registra eventos para manipular la hoja después de generada.
     */
    public function registerEvents(): array
    {
        return [
            AfterSheet::class => function(AfterSheet $event) {
                $sheet      = $event->sheet->getDelegate();
                $data       = $this->data;
                $calendario = $data['calendario'];
                $years      = $data['years'] ?? [$data['year']];
                $eventDaysByYear = $data['eventDaysByYear'] ?? [$data['year'] => ($data['eventDays'] ?? [])];
                $eventColors = $data['eventColors'] ?? [];

                $startDate = \Carbon\Carbon::parse($calendario->dia_inicio_calendario_academico)->startOfDay();
                $endDate   = \Carbon\Carbon::parse($calendario->dia_fin_calendario_academico)->endOfDay();

                // La fila 15 es donde comienza el primer bloque de meses (tras las 9 filas vacías + 2 de título + 1 subtítulo + 2 separadores)
                $currentBaseRow = 15;

                foreach ($years as $year) {
                    $eventDays = $eventDaysByYear[$year] ?? [];

                    // Calcular meses válidos para este año
                    $mesesValidos = [];
                    foreach (range(1, 12) as $mes) {
                        $primerDiaMes = \Carbon\Carbon::create($year, $mes, 1)->startOfDay();
                        $ultimoDiaMes = $primerDiaMes->copy()->endOfMonth()->endOfDay();
                        if ($primerDiaMes <= $endDate && $ultimoDiaMes >= $startDate) {
                            $mesesValidos[] = $mes;
                        }
                    }
                    $mesesChunks = array_chunk($mesesValidos, 3);

                    foreach ($mesesChunks as $chunkIndex => $chunk) {
                        // Cada chunk ocupa: 1 fila separadora + 1 nombre mes + 1 cabecera días + 6 filas semanas = 9 filas
                        $baseRow = $currentBaseRow + ($chunkIndex * 9);

                        foreach ($chunk as $mPos => $m) {
                            $currentMonth   = \Carbon\Carbon::create($year, $m, 1);
                            $daysInMonth    = $currentMonth->daysInMonth;
                            $startDayOfWeek = $currentMonth->dayOfWeek;

                            // BaseCol: A=1, I=9, Q=17
                            $baseCol = 1 + ($mPos * 8);

                            for ($numFila = 0; $numFila < 6; $numFila++) {
                                for ($col = 0; $col < 7; $col++) {
                                    $diaNum = ($numFila * 7 + $col) - $startDayOfWeek + 1;

                                    if ($diaNum >= 1 && $diaNum <= $daysInMonth) {
                                        $cellDate = \Carbon\Carbon::create($year, $m, $diaNum)->startOfDay();
                                        $dateStr  = $cellDate->format('Y-m-d');

                                        if (isset($eventDays[$dateStr])) {
                                            $eventNames  = $eventDays[$dateStr]['nombres'];
                                            $commentText = "Eventos:\n\n";
                                            foreach ($eventNames as $i => $name) {
                                                $commentText .= ($i + 1) . ".- " . $name . "\n";
                                            }

                                            $excelRow  = $baseRow + $numFila;
                                            $excelCol  = $baseCol + $col;
                                            $cellCoord = Coordinate::stringFromColumnIndex($excelCol) . $excelRow;

                                            $sheet->getComment($cellCoord)
                                                  ->getText()
                                                  ->createTextRun($commentText);

                                            $height = 40 + (count($eventNames) * 15);
                                            $sheet->getComment($cellCoord)->setWidth('200pt');
                                            $sheet->getComment($cellCoord)->setHeight($height . 'pt');
                                        }
                                    }
                                }
                            }
                        }
                    }

                    // Avanzar el baseRow para el próximo año:
                    // Se avanza exactamente por el número de filas de los chunks procesados
                    $currentBaseRow += (count($mesesChunks) * 9);
                }
            },
        ];
    }
}
