<?php
require __DIR__.'/../vendor/autoload.php';
$app = require_once __DIR__.'/../bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

use Illuminate\Support\Facades\DB;

function importSql($connection, $filePath) {
    echo "Importing '$filePath' into connection '$connection'...\n";
    if (!file_exists($filePath)) {
        echo "Error: File not found: $filePath\n";
        return;
    }

    try {
        $sql = file_get_contents($filePath);
        // Laravel's DB::unprepared is good for running multiple statements
        DB::connection($connection)->unprepared($sql);
        echo "Successfully imported '$filePath'.\n";
    } catch (\Exception $e) {
        echo "Error importing '$filePath': " . $e->getMessage() . "\n";
    }
}

// 1. Import hp_15.sql into the default 'mysql' connection (hp_15)
importSql('mysql', __DIR__.'/../database/hp_15.sql');

// 2. Import emulacion_sogac_2.sql into 'emulacion_sogac_2' connection
importSql('emulacion_sogac_2', __DIR__.'/../database/emulacion_sogac_2.sql');

echo "\nDone.\n";
