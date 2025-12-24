<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>Planificación Académica</title>
    <style>
        body {
            font-family: DejaVu Sans, sans-serif;
            font-size: 8px;
            margin: 0;
            padding: 0;
        }

        .table-responsive {
            width: 100%;
            overflow-x: hidden;
            padding: 0;
            margin: 0;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 10px;
            font-size: 8px;
            table-layout: fixed;
            max-width: 100%;
        }

        th,
        td {
            border: 1px solid #333;
            padding: 1px 2px;
            text-align: left;
            vertical-align: top;
            word-break: break-word;
            overflow-wrap: break-word;
        }

        th {
            background: #f0f0f0;
        }

        .section-title {
            font-weight: bold;
            margin-top: 10px;
            font-size: 9px;
        }

        .header {
            text-align: center;
            margin-bottom: 10px;
        }

        ul {
            margin: 0;
            padding-left: 15px;
        }

        /* Nuevo estilo para solucionar el problema */
        .bibliografia-col {
            text-align: left !important;
        }
    </style>
</head>

<body>
    <div class="header">
        <table>
            <tr>
                <td colspan="3"><strong>PNF:</strong> {{ $planificacion['pnf_nombre'] ?? '' }}</td>
                <td colspan="3"><strong>Unidad curricular:</strong>
                    {{ $planificacion['nombre_unidad_curricular'] ?? '' }}</td>
                <td><strong>Trayecto:</strong>
                    @php
                        $trayecto = $planificacion['trayecto'] ?? '';
                    @endphp
                    {{ $trayecto === '0' ? 'Inicial' : $trayecto }}
                </td>
                <td><strong>Semestre:</strong>
                    @php
                        $semestre =
                            isset($planificacion['nombre_seccion']) && strlen($planificacion['nombre_seccion']) > 0
                                ? substr($planificacion['nombre_seccion'], 0, 1)
                                : '';
                    @endphp
                    {{ $semestre === '0' ? 'Introductorio' : $semestre }}
                </td>
                <td><strong>Sección:</strong> {{ $planificacion['nombre_seccion'] ?? '' }}</td>
            </tr>
            <tr>
                <td colspan="4"><strong>Coordinador(a) de eje:</strong>
                    {{ $planificacion['coordinador_nombre'] ?? '' }} {{ $planificacion['coordinador_apellido'] ?? '' }}
                    C.I. {{ $planificacion['coordinador_cedula'] ?? '' }}
                </td>
                <td><strong>Horas semanales:</strong> {{ $planificacion['horas_semanales'] ?? '' }}</td>
                <td colspan="2"><strong>Lapso académico:</strong> {{ $planificacion['nombre_lapso'] ?? '' }}</td>
                <td><strong>Código:</strong> {{ $planificacion['unidad_codigo'] ?? '' }}</td>
                <td><strong>Créditos:</strong> {{ $planificacion['unidades_credito'] ?? '' }}</td>
            </tr>
            <tr>
                <td colspan="9"><strong>Profesores que administran la unidad curricular:</strong>
                    {{ $planificacion['docente_nombre'] ?? '' }} {{ $planificacion['docente_apellido'] ?? '' }} C.I.
                    {{ $planificacion['cedula'] ?? '' }}</td>
            </tr>
        </table>
    </div>

    <div class="section-title">Propósito de la unidad curricular</div>
    <div style="margin-bottom: 10px;">
        {{ $planificacion['proposito'] ?? '' }}
    </div>

    <div class="table-responsive">
        <table>
            <thead>
                <tr>
                    <th rowspan="2" style="width:7%; text-align:center; vertical-align:middle;">Semana<br>(Horas y/o
                        minutos)</th>
                    <th rowspan="2" style="width:14%; text-align:center;">Temática
                        general<br>Unidad/objetivo/contenido</th>
                    <th colspan="2" style="width:20%; text-align:center;">Estrategias pedagógicas</th>
                    <th rowspan="2" style="width:15%; text-align:center;">Indicadores de logros</th>
                    <th rowspan="2" style="width:13%; text-align:center;">Técnicas /<br>Instrumentos y tipos de
                        Evaluación</th>
                    <th rowspan="2" style="width:7%; text-align:center;">Forma de Participación</th>
                    <th rowspan="2" style="width:5%; text-align:center;">Ponderación</th>
                    <th rowspan="2" style="width:10%; text-align:center;">Bibliografía Sugerida</th>
                </tr>
                <tr>
                    <th style="text-align:center;">Actividad/ Técnica</th>
                    <th style="text-align:center;">Recursos</th>
                </tr>
            </thead>
            <tbody>
                @php
                    $totalFilas = 0;
                    foreach ($planificacion['cortes'] as $corte) {
                        $numContenidos = count($corte['contenidos'] ?? []);
                        $numEvaluaciones = count($corte['evaluaciones'] ?? []);
                        $totalFilas += max($numContenidos, $numEvaluaciones, 1);
                    }
                    $bibliografiaMostrada = false;
                    $filaActual = 0;
                @endphp
                @foreach ($planificacion['cortes'] as $corte)
                    @php
                        $numContenidos = count($corte['contenidos'] ?? []);
                        $numEvaluaciones = count($corte['evaluaciones'] ?? []);
                        $maxFilas = max($numContenidos, $numEvaluaciones, 1);
                    @endphp
                    @for ($i = 0; $i < $maxFilas; $i++)
                        <tr class="{{ $i === 0 ? 'borde-corte' : 'sin-borde-sup' }}">
                            @if ($i === 0)
                                <td rowspan="{{ $maxFilas }}" style="text-align: center; font-weight:bold;">
                                    @if (!empty($corte['evaluaciones']))
                                        <ul style="margin:0; padding-left:12px; font-size:7px;">
                                            @foreach ($corte['evaluaciones'] as $eval)
                                                @if (!empty($eval['fecha_evaluacion']))
                                                    <li>
                                                        {{ $eval['fecha_evaluacion'] }}
                                                        @if (!empty($eval['evaluacion']))
                                                            - {{ $eval['evaluacion'] }}
                                                        @endif
                                                    </li>
                                                @endif
                                            @endforeach
                                        </ul>
                                    @endif
                                </td>
                            @endif
                            @if ($i === 0)
                                <td rowspan="{{ $maxFilas }}">
                                    @if (!empty($corte['contenidos']))
                                        <ul style="margin:0; padding-left:12px;">
                                            @foreach ($corte['contenidos'] as $contenido)
                                                <li>
                                                    {{ $contenido['titulo_contenido'] ?? '' }}
                                                    @if (!empty($contenido['descripcion_contenido']))
                                                        <br><span
                                                            style="font-size:7px;">{{ $contenido['descripcion_contenido'] }}</span>
                                                    @endif
                                                </li>
                                            @endforeach
                                        </ul>
                                    @endif
                                </td>
                            @endif
                            @if ($i === 0)
                                <td rowspan="{{ $maxFilas }}">
                                    {{ $corte['evaluaciones'][$i]['actividad'] ?? '' }}
                                    @if ($i === 0 && !empty($corte['estrategias']))
                                        <ul style="margin:0; padding-left:12px;">
                                            @foreach ($corte['estrategias'] as $estrategia)
                                                <li>{{ $estrategia['estrategia'] }}</li>
                                            @endforeach
                                        </ul>
                                    @endif
                                </td>
                            @endif
                            @if ($i === 0)
                                <td rowspan="{{ $maxFilas }}">
                                    @if (!empty($corte['recursos']))
                                        <ul>
                                            @foreach ($corte['recursos'] as $recurso)
                                                <li>{{ $recurso['recurso'] }}</li>
                                            @endforeach
                                        </ul>
                                    @endif
                                </td>
                            @endif
                            @if ($i === 0)
                                <td rowspan="{{ $maxFilas }}">
                                    @if (!empty($corte['contenidos'][$i]['indicadores_logros']))
                                        <ul>
                                            @foreach ($corte['contenidos'] as $contenido)
                                                @if (!empty($contenido['indicadores_logros']))
                                                    @foreach ($contenido['indicadores_logros'] as $indicador)
                                                        <li>{{ $indicador['descripcion_indicador'] }}</li>
                                                    @endforeach
                                                @endif
                                            @endforeach
                                        </ul>
                                    @endif
                                </td>
                            @endif
                            @if ($i === 0)
                                <td rowspan="{{ $maxFilas }}">
                                    @if (!empty($corte['evaluaciones']))
                                        @foreach ($corte['evaluaciones'] as $eval)
                                            {{ $eval['tecnica'] ?? '' }}<br>
                                        @endforeach
                                    @endif
                                </td>
                            @endif
                            @if ($i === 0)
                                <td rowspan="{{ $maxFilas }}">
                                    @if (!empty($corte['evaluaciones']))
                                        @foreach ($corte['evaluaciones'] as $eval)
                                            @if (($eval['forma_participacion'] ?? null) == 1)
                                                Individual
                                            @elseif(($eval['forma_participacion'] ?? null) == 2)
                                                En pareja
                                            @elseif(($eval['forma_participacion'] ?? null) == 3)
                                                Grupal
                                            @endif
                                            <br>
                                        @endforeach
                                    @endif
                                </td>
                            @endif
                            @if ($i === 0)
                                <td rowspan="{{ $maxFilas }}" style="text-align:center;">
                                    @if (!empty($corte['evaluaciones']))
                                        @foreach ($corte['evaluaciones'] as $eval)
                                            {{ isset($eval['ponderacion']) && $eval['ponderacion'] !== '' ? $eval['ponderacion'] . '%' : '' }}<br>
                                        @endforeach
                                    @endif
                                </td>
                            @endif
                            @if ($filaActual === 0)
                                <td rowspan="{{ $totalFilas }}" class="bibliografia-col" style="vertical-align:top;">
                                    @if (!empty($planificacion['bibliografias']))
                                        <ul style="margin:0;">
                                            @foreach ($planificacion['bibliografias'] as $biblio)
                                                <li>{{ $biblio['bibliografia'] }}</li>
                                            @endforeach
                                        </ul>
                                    @else
                                        <span>No hay bibliografía registrada.</span>
                                    @endif
                                </td>
                            @endif
                        </tr>
                        @php $filaActual++; @endphp
                    @endfor
                @endforeach
            </tbody>
        </table>
    </div>

</body>

</html>
