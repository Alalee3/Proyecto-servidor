<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Planificación Necesita Modificación</title>
    <style>
        body { font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif; line-height: 1.6; color: #333; }
        .container { max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #e0e0e0; border-radius: 8px; background-color: #fffaf0; }
        .header { text-align: center; margin-bottom: 20px; }
        .header h1 { color: #c2410c; }
        .content { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); }
        .reason-box { background: #fee2e2; border-left: 4px solid #ef4444; padding: 10px; margin: 10px 0; border-radius: 4px; }
        .footer { margin-top: 20px; font-size: 0.85em; text-align: center; color: #6b7280; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Acción Requerida: Modificación de Planificación</h1>
        </div>
        <div class="content">
            <p>Estimado/a profesor/a <strong>{{ $profesor->per_nombres }} {{ $profesor->per_apellidos }}</strong>,</p>
            
            <p>Le informamos que su planificación académica ha sido revisada y se han detectado elementos que <strong>necesitan ser modificados o corregidos</strong>.</p>
            
            <p><strong>Detalles de la Planificación:</strong></p>
            <ul>
                <li><strong>Unidad Curricular:</strong> {{ $planificacion->nombre_unidad_curricular ?? 'N/A' }}</li>
                <li><strong>Sección:</strong> {{ $planificacion->nombre_seccion ?? 'N/A' }}</li>
            </ul>

            <p><strong>Unidades con observaciones:</strong></p>
            @foreach($motivos as $m)
                <div class="reason-box">
                    <strong>Unidad {{ $m['numero'] }}:</strong> {{ $m['motivo'] }}
                </div>
            @endforeach

            <p>Por favor, ingrese al sistema SOGAT, realice las correcciones indicadas y vuelva a enviar su planificación para una nueva revisión.</p>

            <p>Atentamente,<br>Coordinación Académica UPTP</p>
        </div>
        <div class="footer">
            <p>Este es un correo automático generado por el Sistema SOGAC. Por favor, no responda a este mensaje.</p>
        </div>
    </div>
</body>
</html>
