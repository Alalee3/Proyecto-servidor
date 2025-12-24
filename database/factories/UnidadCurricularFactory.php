<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use App\Models\Pnfs;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\UnidadCurricular>
 */
class UnidadCurricularFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {

        $codigo = $this->faker->unique()->regexify('[A-Z]{3}[0-9]{3}');
        return [
            'codigo' => $codigo,
            'pnf_id' => Pnfs::inRandomOrder()->first()->pnf_id, // Asigna un PNF aleatorio o null si no hay PNFs
            'semestre' => $this->faker->numberBetween(1, 8), // Semestre del 1 al 10
            'nombre' => $this->faker->unique()->sentence(3, true), // Nombre de la unidad curricular
            'descripcion' => $this->faker->paragraph(2), // Descripción más larga
            'proposito' => $this->faker->sentence(6), // Propósito
            'unidades_credito' => $this->faker->numberBetween(2, 6), // Unidades de crédito entre 2 y 6
        ];
    }
}
