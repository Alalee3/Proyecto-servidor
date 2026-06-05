<?php
require __DIR__ . '/../vendor/autoload.php';
$app = require_once __DIR__ . '/../bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

use Illuminate\Support\Facades\DB;

$payload = 'eyJpdiI6InFSS09RTkhOaVwvUExcL0tJcDRKNlhhQT09IiwidmFsdWUiOiJuVkFqaDVGeG4xVDUwdFZvNzFxaWNhbjk1UDJjcWRCK0NIbWE5em9leTVDeWVXcXNBNlhNVHRLSnFrdFZcL255WG5vSXV4NjArNFgxTklsVDFZQlBsRVR2R3R6NVVvQkJVZHg1OEFjcDdWZGwxWWYxcGd4bFQ2S01XbWJQem0rSUlXMzZidzArRzFHT2dxU3BUTGdJcndBYzBFT0FrVko5alRqMWllczI2cTBLdUx1RVlsWGljTFRXTkc1cjI3d3BVIiwibWFjIjoiMWM3ZDMxMmQ3MzJiNDRlZDVkYTliYjQ5NDkyNWIzODBiNzNkODA1YzAyOWE2NTBjYWM5YzY5YzQ5NTA5MGIzYSIsInRhZyI6IiJ9';

try {
    $sogacKey = env('SOGAC_ACCESS_KEY');
    $cleanSogacKey = base64_decode(str_replace('base64:', '', $sogacKey));
    $encrypter = new \Illuminate\Encryption\Encrypter($cleanSogacKey, config('app.cipher'));
    $decrypted = $encrypter->decryptString($payload);
    $data = json_decode($decrypted, true);
    echo "Decrypted Data:\n";
    print_r($data);
    
    // Check signature
    $cleanSogacKeyStr = str_replace('base64:', '', env('SOGAC_ACCESS_KEY'));
    $seed = $data['cedula'] . $data['fecha_creacion'] . $cleanSogacKeyStr;
    $firmaServidor = hash('sha256', $seed);
    echo "Firma Servidor: $firmaServidor\n";
    echo "Firma Recibida: " . $data['firma_validacion'] . "\n";
    if ($firmaServidor === $data['firma_validacion']) {
        echo "Firma MATCH!\n";
    } else {
        echo "Firma MISMATCH!\n";
    }

    $usuarioRepo = new \App\Repositories\UsuarioRepository();
    $rolesList = $usuarioRepo->getRolesInformaticoPorCedula($data['cedula']);
    echo "Roles List:\n";
    print_r($rolesList->toArray());
} catch (\Exception $e) {
    echo "Error: " . $e->getMessage() . "\n" . $e->getTraceAsString() . "\n";
}
