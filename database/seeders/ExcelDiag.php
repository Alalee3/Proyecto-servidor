<?php
$host = '127.0.0.1';
$db   = 'hp_23_excel';
$user = 'root';
$pass = ''; // usually empty in xampp
$charset = 'utf8mb4';

$dsn = "mysql:host=$host;dbname=$db;charset=$charset";
$options = [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    PDO::ATTR_EMULATE_PREPARES   => false,
];

try {
    $pdo = new PDO($dsn, $user, $pass, $options);
} catch (\PDOException $e) {
    throw new \PDOException($e->getMessage(), (int)$e->getCode());
}

$stmt = $pdo->query("SELECT * FROM calendario_academico ORDER BY id_calendario_academico DESC LIMIT 1");
$cal = $stmt->fetch();

$query = "
    SELECT e.nombre_evento, d.dia_inicio_detalle_evento, d.dia_fin_detalle_evento, e.id_especial_evento
    FROM detalle_evento d
    JOIN evento e ON d.id_evento = e.id_evento
    WHERE d.id_calendario_academico = ?
";

$stmt = $pdo->prepare($query);
$stmt->execute([$cal['id_calendario_academico']]);
$eventos = $stmt->fetchAll();

foreach ($eventos as $ev) {
    if (stripos($ev['nombre_evento'], 'vacacion') !== false || stripos($ev['nombre_evento'], 'vacación') !== false) {
        echo "MATCH: {$ev['nombre_evento']} | {$ev['dia_inicio_detalle_evento']} a {$ev['dia_fin_detalle_evento']} | especial={$ev['id_especial_evento']}\n";
    }
}
