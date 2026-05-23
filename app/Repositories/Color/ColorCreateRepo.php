<?php

namespace App\Repositories\Color;

use App\Models\Color;

class ColorCreateRepo
{
    /**
     * Crea un nuevo color.
     */
    public function crear(array $datos)
    {
        $color = Color::create([
            'nombre_color' => $datos['nombre_color'],
            'codigo_color' => $datos['codigo_color'],
            'estatus' => '1'
        ]);

        return $color->id_color;
    }
}
