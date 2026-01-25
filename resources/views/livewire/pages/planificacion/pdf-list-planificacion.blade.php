<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Reporte de Planificaciones</title>
    <style>
        body { font-family: sans-serif; font-size: 10pt; }
        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th, td { border: 1px solid #ccc; padding: 6px; text-align: left; }
        th { background-color: #f2f2f2; }
        .header { text-align: center; margin-bottom: 20px; }
        .status { font-weight: bold; }
        .status-1 { color: green; }
        .status-2 { color: orange; }
        .status-3 { color: red; }
    </style>
</head>
<body>
    <div class="header">
        <h1>Reporte General de Planificaciones</h1>
        <p>Fecha de emisión: {{ now()->format('d/m/Y H:i') }}</p>
    </div>

    <table>
        <thead>
            <tr>
                <th>Docente</th>
                <th>Unidad Curricular</th>
                <th>Sección</th>
                <th>Trayecto</th>
                <th>PNF</th>
                <th>Estatus</th>
            </tr>
        </thead>
        <tbody>
            @foreach($planificaciones as $p)
                <tr>
                    <td>{{ $p->docente_nombre }} {{ $p->docente_apellido }}</td>
                    <td>{{ $p->nombre_unidad_curricular }}</td>
                    <td>{{ $p->nombre_seccion }}</td>
                    <td>Trayecto {{ $p->trayecto_unidad_curricular }}</td>
                    <td>{{ $p->nombre_pnf }}</td>
                    <td class="status status-{{ $p->estatus }}">
                        @if($p->estatus == 1) Aprobado 
                        @elseif($p->estatus == 2) Pendiente
                        @elseif($p->estatus == 3) Rechazado
                        @else Desconocido
                        @endif
                    </td>
                </tr>
            @endforeach
        </tbody>
    </table>
</body>
</html>
