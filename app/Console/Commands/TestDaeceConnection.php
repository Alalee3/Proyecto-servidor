<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;

class TestDaeceConnection extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'daece:test-connection';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Prueba la conexión a la base de datos DAECE y lista las tablas del esquema public';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        $this->info('Iniciando prueba de conexión con pgsql_daece...');

        try {
            // Intentar obtener la conexión para verificar disponibilidad
            $connection = DB::connection('pgsql_daece');
            $connection->getPdo();

            $this->info('Conexión establecida exitosamente.');

            // Consultar los nombres de las tablas en el esquema 'public'
            $tables = $connection->select("
                SELECT table_name 
                FROM information_schema.tables 
                WHERE table_schema = 'public'
                AND table_type = 'BASE TABLE'
                ORDER BY table_name;
            ");

            if (empty($tables)) {
                $this->warn('No se encontraron tablas convencionales en el esquema public.');
                return;
            }

            $this->info('Tablas encontradas:');
            foreach ($tables as $table) {
                $this->line("- {$table->table_name}");
            }

        } catch (\Exception $e) {
            $this->error('Error al conectar o consultar la base de datos: ' . $e->getMessage());
        }
    }
}
