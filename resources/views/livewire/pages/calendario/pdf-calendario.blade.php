<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Reporte de Calendario Académico</title>
    <style>
        @page {
            margin: 140px 30px 60px 30px;
        }
        header {
            position: fixed;
            top: -120px;
            left: 0px;
            right: 0px;
            height: 100px;
            text-align: center;
        }
        footer {
            position: fixed;
            bottom: -40px;
            left: 0px;
            right: 0px;
            height: 40px;
            text-align: center;
            font-size: 7pt;
            color: #333;
            border-top: 1px solid #000;
        }
        .footer-text {
            margin: 1px 0;
            line-height: 1.1;
        }
        body {
            font-family: sans-serif;
            font-size: 10pt;
            line-height: 1.5;
            color: #000;
        }
        .title {
            text-align: center;
            font-weight: bold;
            font-size: 14pt;
            margin-bottom: 20px;
            text-transform: uppercase;
        }
        .info-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .info-table td {
            padding: 10px;
            border: 1px solid #000;
        }
        .label {
            font-weight: bold;
            background-color: #f2f2f2;
            width: 30%;
        }
    </style>
</head>
<body>
    <header>
        <img src="{{ public_path('img/reportes.jpg') }}" style="width: 100%; height: auto; max-height: 100px;">
    </header>

    <footer>
        <div class="footer-text">U.P.T.P. - Avenida Circunvalación Sur, sector Bellas Artes, diagonal a la Cruz Roja.
            Acarigua Edo. Portuguesa, República Bolivariana de Venezuela. R.I.F.: G-20010200-4.</div>
        <div class="footer-text">Zona postal 3301, Apartado N° 108. Teléfonos: (0255) 623.7538 - 623.7519 - 623.6085 |
            http://uptp.sytes.net</div>
        <div class="footer-text">{{ now()->format('d/m/Y h:i a') }} - Reporte de Calendario</div>
    </footer>

    <div class="title">REPORTE DE CALENDARIO ACADÉMICO</div>

    <table class="info-table">
        <tr>
            <td class="label">Lapso Académico:</td>
            <td>{{ $calendario->nombre_lapso }}</td>
        </tr>
        <tr>
            <td class="label">Fecha de Inicio:</td>
            <td>{{ \Carbon\Carbon::parse($calendario->dia_inicio_calendario_academico)->format('d/m/Y') }}</td>
        </tr>
        <tr>
            <td class="label">Fecha de Fin:</td>
            <td>{{ \Carbon\Carbon::parse($calendario->dia_fin_calendario_academico)->format('d/m/Y') }}</td>
        </tr>
    </table>

</body>
</html>
