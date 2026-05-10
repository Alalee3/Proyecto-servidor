<table>
    {{-- Filas vacías iniciales para la imagen de cabecera --}}
    @for($i = 0; $i < 9; $i++)
        <tr>
            <td></td>
        </tr>
    @endfor

    @php
        $startDate = \Carbon\Carbon::parse($calendario->dia_inicio_calendario_academico)->startOfDay();
        $endDate = \Carbon\Carbon::parse($calendario->dia_fin_calendario_academico)->endOfDay();
        $mesesNombres = ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'];
        $eventosSorted = $eventos->sortBy('dia_inicio_evento')->values();
        $totalEventos = count($eventosSorted);
        $eventoIndex = 0;
        $isFirstYear = true;
    @endphp

    {{-- Título General con Rango de Años --}}
    <thead style="font-weight: bold;">
        <tr>
            <th colspan="23" style="text-align: center; font-size: 14pt;">CALENDARIO ACADÉMICO {{ $startYear }} -
                {{ $endYear }}</th>
        </tr>
        <tr>
            <th colspan="23" style="text-align: center;"><strong>Vigencia:</strong>
                {{ \Carbon\Carbon::parse($calendario->dia_inicio_calendario_academico)->format('d/m/Y') }} hasta
                {{ \Carbon\Carbon::parse($calendario->dia_fin_calendario_academico)->format('d/m/Y') }}</th>
        </tr>
    </thead>

    @php
        // Recopilar todos los meses válidos de todos los años en una sola lista plana
        $listaMesesCompleta = [];
        foreach ($years as $yearLoop) {
            foreach (range(1, 12) as $mes) {
                $primerDiaMes = \Carbon\Carbon::create($yearLoop, $mes, 1)->startOfDay();
                $ultimoDiaMes = $primerDiaMes->copy()->endOfMonth()->endOfDay();
                if ($primerDiaMes <= $endDate && $ultimoDiaMes >= $startDate) {
                    $listaMesesCompleta[] = [
                        'year' => $yearLoop,
                        'month' => $mes
                    ];
                }
            }
        }
        $mesesChunks = array_chunk($listaMesesCompleta, 3);
    @endphp

    <tbody>
        @foreach($mesesChunks as $chunkIndex => $chunk)
            <tr>
                <td colspan="31"></td>
            </tr>
            {{-- Nombres de meses --}}
            <tr style="font-weight: bold;">
                @foreach($chunk as $item)
                    @php 
                        $m = $item['month']; 
                        $y = $item['year'];
                    @endphp
                    <td colspan="7" style="text-align: center; border: 0.5px solid #000; background-color: #f2f2f2;">
                        {{ $mesesNombres[$m - 1] }} {{ $y }}</td>
                    <td style="width: 20px;"></td>
                @endforeach
                @if($chunkIndex == 0)
                    <td colspan="7" style="text-align: center; background-color: #f2f2f2; border: 1px solid #000;">EVENTOS DEL
                        CALENDARIO</td>
                @else
                    <td colspan="7"></td>
                @endif
            </tr>

            {{-- Cabecera días --}}
            <tr style="background-color: #f9f9f9; font-weight: bold;">
                @foreach($chunk as $item)
                    <td style="border: 0.5px solid #000; text-align: center;">D</td>
                    <td style="border: 0.5px solid #000; text-align: center;">L</td>
                    <td style="border: 0.5px solid #000; text-align: center;">M</td>
                    <td style="border: 0.5px solid #000; text-align: center;">M</td>
                    <td style="border: 0.5px solid #000; text-align: center;">J</td>
                    <td style="border: 0.5px solid #000; text-align: center;">V</td>
                    <td style="border: 0.5px solid #000; text-align: center;">S</td>
                    <td></td>
                @endforeach
                @if($chunkIndex == 0)
                    <td colspan="4" style="border: 1px solid #000; background-color: #f2f2f2;">Evento</td>
                    <td colspan="3" style="border: 1px solid #000; background-color: #f2f2f2;">Fecha</td>
                @else
                    <td colspan="7"></td>
                @endif
            </tr>

            {{-- Semanas --}}
            @for($numFila = 0; $numFila < 6; $numFila++)
                <tr>
                    @foreach($chunk as $item)
                        @php
                            $yLoop = $item['year'];
                            $mLoop = $item['month'];
                            $eventDays = $eventDaysByYear[$yLoop] ?? [];
                            $currentMonth = \Carbon\Carbon::create($yLoop, $mLoop, 1);
                            $daysInMonth = $currentMonth->daysInMonth;
                            $startDayOfWeek = $currentMonth->dayOfWeek;
                        @endphp
                        @for($col = 0; $col < 7; $col++)
                            @php
                                $diaNum = ($numFila * 7 + $col) - $startDayOfWeek + 1;
                                $cellDate = null;
                                if ($diaNum >= 1 && $diaNum <= $daysInMonth) {
                                    $cellDate = \Carbon\Carbon::create($yLoop, $mLoop, $diaNum)->startOfDay();
                                }
                                $isVigente = ($cellDate && $cellDate->between($startDate, $endDate));
                                $eventData = ($cellDate && isset($eventDays[$cellDate->format('Y-m-d')])) ? $eventDays[$cellDate->format('Y-m-d')] : null;
                                $eventId = $eventData ? $eventData['ids'][0] : null;
                                $isWeekend = ($col == 0 || $col == 6);

                                if ($eventId) {
                                    $bgColor = $eventColors[$eventId] ?? '#ffffff';
                                    $textColor = $isWeekend ? '#DC3545' : '#ffffff';
                                } elseif ($isVigente && $isWeekend) {
                                    $bgColor = '#ffffff';
                                    $textColor = '#DC3545';
                                } else {
                                    $bgColor = '#ffffff';
                                    $textColor = $isVigente ? '#000000' : ($cellDate ? '#bbbbbb' : '#ffffff');
                                }
                            @endphp
                            <td
                                style="border: 0.5px solid #000; text-align: center; background-color: {{ $bgColor }}; color: {{ $textColor }}; {{ ($isVigente && !$eventId) ? 'font-weight: bold;' : '' }}">
                                {{ ($diaNum >= 1 && $diaNum <= $daysInMonth) ? $diaNum : '' }}
                            </td>
                        @endfor
                        <td></td>
                    @endforeach

                    {{-- Eventos --}}
                    @if($eventoIndex < $totalEventos)
                        @php $evento = $eventosSorted[$eventoIndex]; @endphp
                        <td
                            style="border: 0.5px solid #000; background-color: {{ $eventColors[$evento->id_evento] ?? '#ffffff' }}; width: 10px;">
                        </td>
                        <td colspan="3" style="border: 0.5px solid #000; font-size: 8pt;">{{ $evento->descripcion_evento }}</td>
                        <td colspan="3" style="border: 0.5px solid #000; font-size: 8pt; text-align: center;">
                            {{ \Carbon\Carbon::parse($evento->dia_inicio_evento)->format('d/m/Y') }} -
                            {{ \Carbon\Carbon::parse($evento->dia_fin_evento)->format('d/m/Y') }}
                        </td>
                        @php $eventoIndex++; @endphp
                    @else
                        <td colspan="7"></td>
                    @endif
                </tr>
            @endfor
        @endforeach

        {{-- Eventos restantes --}}
        @while($eventoIndex < $totalEventos)
            <tr>
                <td colspan="24"></td>
                @php $evento = $eventosSorted[$eventoIndex]; @endphp
                <td
                    style="border: 0.5px solid #000; background-color: {{ $eventColors[$evento->id_evento] ?? '#ffffff' }}; width: 10px;">
                </td>
                <td colspan="3" style="border: 0.5px solid #000; font-size: 8pt;">{{ $evento->descripcion_evento }}</td>
                <td colspan="3" style="border: 0.5px solid #000; font-size: 8pt; text-align: center;">
                    {{ \Carbon\Carbon::parse($evento->dia_inicio_evento)->format('d/m/Y') }} -
                    {{ \Carbon\Carbon::parse($evento->dia_fin_evento)->format('d/m/Y') }}
                </td>
                @php $eventoIndex++; @endphp
            </tr>
        @endwhile
    </tbody>
</table>