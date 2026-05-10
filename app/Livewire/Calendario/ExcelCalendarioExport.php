<?php

namespace App\Livewire\Calendario;

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

class ExcelCalendarioExport implements FromView, ShouldAutoSize, WithStyles, WithDrawings, WithEvents
{
    protected $data;

    public function __construct($data)
    {
        $this->data = $data;
    }

    /**
     * Método estático para gestionar la descarga directamente.
     */
    public static function descargar($id = null)
    {
        $repo = new \App\Repositories\Calendario\CalendarioExcelRepo();
        
        $calendario = $id 
            ? $repo->obtenerPorId($id) 
            : $repo->obtenerUltimoActivo();

        if (!$calendario) {
            return redirect()->back()->with('error', 'El calendario solicitado no existe o no hay calendarios activos.');
        }

        $data = $repo->prepararDataExportacion($calendario);

        return \Maatwebsite\Excel\Facades\Excel::download(
            new self($data),
            'calendario_academico_' . $data['startYear'] . '-' . $data['endYear'] . '.xlsx'
        );
    }

    public function view(): View
    {
        return view('livewire.pages.calendario.excel-calendario', $this->data);
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
            AfterSheet::class => function (AfterSheet $event) {
                $sheet = $event->sheet->getDelegate();
                $data = $this->data;
                $calendario = $data['calendario'];
                $years = $data['years'] ?? [$data['year']];
                $eventDaysByYear = $data['eventDaysByYear'] ?? [$data['year'] => ($data['eventDays'] ?? [])];
                $eventColors = $data['eventColors'] ?? [];
                $listaMesesCompleta = $data['listaMesesCompleta'] ?? [];

                $mesesChunks = array_chunk($listaMesesCompleta, 3);
                $currentBaseRow = 15;

                foreach ($mesesChunks as $chunkIndex => $chunk) {
                    $baseRow = $currentBaseRow + ($chunkIndex * 9);

                    foreach ($chunk as $mPos => $item) {
                        $y = $item['year'];
                        $m = $item['month'];
                        $eventDays = $eventDaysByYear[$y] ?? [];

                        $currentMonth   = \Carbon\Carbon::create($y, $m, 1);
                        $daysInMonth    = $currentMonth->daysInMonth;
                        $startDayOfWeek = $currentMonth->dayOfWeek;

                        // BaseCol: A=1, I=9, Q=17
                        $baseCol = 1 + ($mPos * 8);

                        for ($numFila = 0; $numFila < 6; $numFila++) {
                            for ($col = 0; $col < 7; $col++) {
                                $diaNum = ($numFila * 7 + $col) - $startDayOfWeek + 1;

                                if ($diaNum >= 1 && $diaNum <= $daysInMonth) {
                                    $cellDate = \Carbon\Carbon::create($y, $m, $diaNum)->startOfDay();
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
            },
        ];
    }
}
