<?php
require __DIR__.'/../vendor/autoload.php';
$app = require_once __DIR__.'/../bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

use Illuminate\Support\Facades\DB;

$count = DB::table('planificacion')->count();
echo "Count: $count\n";
$items = DB::table('planificacion')->get();
foreach ($items as $item) {
    print_r($item);
}
