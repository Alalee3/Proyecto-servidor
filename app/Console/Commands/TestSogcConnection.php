<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;

class TestSogcConnection extends Command
{
    /**
     * El nombre y la firma del comando.
     *
     * @var string
     */
    protected $signature = 'sogc:test-connection';

    /**
     * La descripción del comando.
     *
     * @var string
     */
    protected $description = 'Prueba la conexión a la base de datos de emulación SOGC y lista sus tablas';

    /**
     * Ejecuta el comando.
     */
    public function handle()
    {
        $this->info('Iniciando prueba de conexión con mysql_sogc (Emulación)...');

        try {
            // Verificar conexión
            $connection = DB::connection('mysql_sogc');
            $connection->getPdo();

            $this->info('Conexión establecida exitosamente.');

            // Consultar tablas (Sintaxis MySQL)
            $tables = $connection->select("SHOW TABLES");

            if (empty($tables)) {
                $this->warn('No se encontraron tablas en la base de datos emulacion_sogc.');
                return;
            }

            $this->info('Tablas encontradas:');
            // En MySQL, el resultado de SHOW TABLES tiene una llave dinámica 'Tables_in_database'
            // Accedemos de forma genérica al primer valor del objeto
            foreach ($tables as $table) {
                $tableArray = (array) $table;
                $tableName = reset($tableArray);
                $this->line("- {$tableName}");
            }

        } catch (\Exception $e) {
            $this->error('Error al conectar o consultar la base de datos: ' . $e->getMessage());
        }
    }
}
