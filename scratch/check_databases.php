<?php
require __DIR__.'/../vendor/autoload.php';
$app = require_once __DIR__.'/../bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

function listTables($connection) {
    echo "Tables in connection '$connection':\n";
    try {
        $tables = DB::connection($connection)->select('SHOW TABLES');
        foreach ($tables as $table) {
            echo "- " . current((array)$table) . "\n";
        }
    } catch (\Exception $e) {
        echo "Error: " . $e->getMessage() . "\n";
    }
    echo "\n";
}

listTables('mysql');
listTables('emulacion_sogac_2');
