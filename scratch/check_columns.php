<?php
require __DIR__.'/../vendor/autoload.php';
$app = require_once __DIR__.'/../bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

use Illuminate\Support\Facades\DB;

$columns = DB::select('SHOW COLUMNS FROM detalle_contenido');
foreach ($columns as $col) {
    echo $col->Field . " - " . $col->Type . "\n";
}
echo "----\n";
$columns = DB::select('SHOW COLUMNS FROM unidad_corte');
foreach ($columns as $col) {
    echo $col->Field . " - " . $col->Type . "\n";
}
