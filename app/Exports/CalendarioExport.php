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
                $sheet = $event->sheet->getDelegate();
                $data = $this->data;
                $year = $data['year'];
                $eventDays = $data['eventDays'] ?? [];
                $calendario = $data['calendario'];
                $startDate = \Carbon\Carbon::parse($calendario->dia_inicio_calendario_academico)->startOfDay();
                $endDate = \Carbon\Carbon::parse($calendario->dia_fin_calendario_academico)->endOfDay();

                // Replicar lógica de meses chunks igual que en la vista blade
                $mesesValidos = [];
                foreach (range(1, 12) as $mes) {
                    $primerDiaMes = \Carbon\Carbon::create($year, $mes, 1)->startOfDay();
                    $ultimoDiaMes = $primerDiaMes->copy()->endOfMonth()->endOfDay();
                    if ($primerDiaMes <= $endDate && $ultimoDiaMes >= $startDate) {
                        $mesesValidos[] = $mes;
                    }
                }
                $mesesChunks = array_chunk($mesesValidos, 3);

                foreach($mesesChunks as $chunkIndex => $chunk) {
                    // BaseRow: Fila 15 es la primera semana del primer chunk (index 0)
                    // Cada bloque de meses (chunk) ocupa exactamente 9 filas
                    $baseRow = 15 + ($chunkIndex * 9); 
                    
                    foreach($chunk as $mPos => $m) {
                        $currentMonth = \Carbon\Carbon::create($year, $m, 1);
                        $daysInMonth = $currentMonth->daysInMonth;
                        $startDayOfWeek = $currentMonth->dayOfWeek; // 0 (Dom) a 6 (Sab)
                        
                        // BaseCol: A=1, I=9, Q=17. Cada mes tiene 7 cols + 1 col de espacio
                        $baseCol = 1 + ($mPos * 8); 

                        for($numFila = 0; $numFila < 6; $numFila++) {
                            for($col = 0; $col < 7; $col++) {
                                $diaNum = ($numFila * 7 + $col) - $startDayOfWeek + 1;
                                
                                if($diaNum >= 1 && $diaNum <= $daysInMonth) {
                                    $cellDate = \Carbon\Carbon::create($year, $m, $diaNum)->startOfDay();
                                    $dateStr = $cellDate->format('Y-m-d');
                                    
                                    if (isset($eventDays[$dateStr])) {
                                        $eventNames = $eventDays[$dateStr]['nombres'];
                                        $commentText = "Eventos:\n\n";
                                        foreach ($eventNames as $i => $name) {
                                            $commentText .= ($i + 1) . ".- " . $name . "\n";
                                        }

                                        $excelRow = $baseRow + $numFila;
                                        $excelCol = $baseCol + $col;
                                        $cellCoord = Coordinate::stringFromColumnIndex($excelCol) . $excelRow;
                                        
                                        // Agregar comentario a la celda
                                        $sheet->getComment($cellCoord)
                                              ->getText()
                                              ->createTextRun($commentText);
                                        
                                        // Ajustar el tamaño del cuadro del comentario según la cantidad de eventos
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
