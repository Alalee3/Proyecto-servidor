<?php

/**
 * Script independiente para inactivar el calendario académico activo.
 * Uso: php inactivar_calendario.php
 */

require __DIR__ . '/vendor/autoload.php';
$app = require_once __DIR__ . '/bootstrap/app.php';

use Illuminate\Support\Facades\DB;
use App\Models\CalendarioAcademico;

// Boot kernel to use Laravel features
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

echo "--------------------------------------------------\n";
echo "SOGAT - SCRIPT DE GESTIÓN DE CALENDARIO\n";
echo "--------------------------------------------------\n";

try {
    // Buscar calendarios activos
    $calendariosActivos = CalendarioAcademico::where('estatus', '1')->get();
    $total = $calendariosActivos->count();

    if ($total > 0) {
        echo "PROCESANDO: Se han encontrado {$total} calendario(s) activo(s).\n";
        
        foreach ($calendariosActivos as $cal) {
            echo " > Inactivando ID: {$cal->id_calendario_academico} (Período: {$cal->dia_inicio_calendario_academico} al {$cal->dia_fin_calendario_academico})\n";
            $cal->update(['estatus' => '3']);
        }
        
        echo "\nÉXITO: Todos los calendarios activos han sido marcados como INACTIVOS (estatus 3).\n";
    } else {
        echo "INFORMACIÓN: No existen calendarios con estatus activo (1) en el sistema.\n";
    }
} catch (\Exception $e) {
    echo "ERROR CRÍTICO: " . $e->getMessage() . "\n";
}

echo "--------------------------------------------------\n";
echo "Proceso finalizado correctamente.\n";
