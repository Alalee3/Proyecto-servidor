<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Planificación Aceptada</title>
    <style>
        body { font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif; line-height: 1.6; color: #333; }
        .container { max-w-600px; margin: 0 auto; padding: 20px; border: 1px solid #e0e0e0; border-radius: 8px; background-color: #f9fafb; }
        .header { text-align: center; margin-bottom: 20px; }
        .header h1 { color: #1d4ed8; }
        .content { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); }
        .footer { margin-top: 20px; font-size: 0.85em; text-align: center; color: #6b7280; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>¡Planificación Aceptada!</h1>
        </div>
        <div class="content">
            <p>Estimado/a profesor/a <strong>{{ $profesor->per_nombres }} {{ $profesor->per_apellidos }}</strong>,</p>
            
            <p>Le informamos que su planificación académica ha sido revisada y <strong>aceptada en su totalidad</strong> por la coordinación.</p>
            
            <p><strong>Detalles:</strong></p>
            <ul>
                <li><strong>Unidad Curricular:</strong> {{ $planificacion->nombre_unidad_curricular ?? 'N/A' }}</li>
                <li><strong>Sección:</strong> {{ $planificacion->nombre_seccion ?? 'N/A' }}</li>
            </ul>

            <p>Le agradecemos su compromiso y le deseamos mucho éxito en el desarrollo del lapso académico.</p>

            <p>Atentamente,<br>Coordinación Académica UPTP</p>
        </div>
        <div class="footer">
            <p>Este es un correo automático generado por el Sistema SOGAC. Por favor, no responda a este mensaje.</p>
        </div>
    </div>
</body>
</html>
