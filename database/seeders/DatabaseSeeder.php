<?php

namespace Database\Seeders;

use App\Models\Pnfs;
use App\Models\User;
use Illuminate\Support\Facades\DB;
// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        $user = User::create([
            'name' => 'Admin',
            'apellido' => 'User',
            'cedula' => '12345678',
            'email' => 'admin@example.com',
            'telefono' => '04121234567',
            'password' => 'password',
            'estatus' => 1
        ]);

        // Crear roles
        DB::table('roles')->insert([
            ['rol_id' => 1, 'acceso' => 'Coordinador', 'estatus' => '1'],
            ['rol_id' => 2, 'acceso' => 'Docente', 'estatus' => '1'],
        ]);

        // Asignar rol de Coordinador al usuario admin
        DB::table('usuario_roles')->insert([
            'usuario_id' => $user->id,
            'rol_id' => 1,
            'estatus' => '1'
        ]);

        if (Pnfs::count() === 0) {
            Pnfs::factory()->count(5)->create();
        }
        $this->call([
            ContenidosSeeder::class,
        ]);
    }
}
