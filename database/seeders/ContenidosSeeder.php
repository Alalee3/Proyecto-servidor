<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ContenidosSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $contenidos = [
            ['titulo' => 'Introducción a la Programación', 'descripcion' => 'Conceptos básicos de algoritmos y lógica.'],
            ['titulo' => 'Bases de Datos Relacionales', 'descripcion' => 'Diseño y normalización de bases de datos.'],
            ['titulo' => 'Desarrollo Web Frontend', 'descripcion' => 'HTML, CSS y JavaScript.'],
            ['titulo' => 'Desarrollo Web Backend', 'descripcion' => 'PHP, Laravel y APIs.'],
            ['titulo' => 'Ingeniería de Software', 'descripcion' => 'Metodologías ágiles y ciclo de vida del software.'],
        ];

        foreach ($contenidos as $contenido) {
            DB::table('contenidos')->insert([
                'titulo' => $contenido['titulo'],
                'descripcion' => $contenido['descripcion'],
                'estatus' => 1,
                'fecha_creacion' => now(),
            ]);
        }
    }
}
