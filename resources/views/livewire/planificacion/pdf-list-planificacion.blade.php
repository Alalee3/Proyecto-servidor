<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Reporte General de Planificaciones</title>
    <style>
        body { font-family: DejaVu Sans, sans-serif; font-size: 12px; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 10px; }
        th, td { border: 1px solid #333; padding: 4px; text-align: left; }
        th { background: #f0f0f0; }
        .header { text-align: center; margin-bottom: 20px; }
    </style>
</head>
<body>
    <div class="header">
        <h2>Reporte General de Planificaciones</h2>
    </div>
    <table>
        <thead>
            <tr>
                <th>Docente</th>
                <th>Sección</th>
                <th>Unidad Curricular</th>
                <th>Lapso Académico</th>
                <th>Estatus</th>
            </tr>
        </thead>
        <tbody>
            @foreach($planificaciones as $planificacion)
                <tr>
                    <td>{{ $planificacion->docente_nombre }} {{ $planificacion->docente_apellido }}</td>
                    <td>{{ $planificacion->seccion }}</td>
                    <td>{{ $planificacion->unidad_curricular }}</td>
                    <td>{{ $planificacion->lapso }}</td>
                    <td>
                        @if ($planificacion->estatus == 1)
                            Aprobada
                        @elseif($planificacion->estatus == 2)
                            Pendiente
                        @elseif($planificacion->estatus == 3)
                            Rechazada
                        @else
                            Desconocido
                        @endif
                    </td>
                </tr>
            @endforeach
        </tbody>
    </table>
</body>
</html> 