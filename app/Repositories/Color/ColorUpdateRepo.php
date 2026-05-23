<?php

namespace App\Repositories\Color;

use App\Models\Color;

class ColorUpdateRepo
{
    /**
     * Obtiene un color por su ID.
     */
    public function obtenerPorId($id)
    {
        return Color::find($id);
    }

    /**
     * Actualiza un color existente.
     */
    public function actualizar($id, array $datos)
    {
        $color = Color::find($id);
        if ($color) {
            $color->update([
                'nombre_color' => $datos['nombre_color'],
                'codigo_color' => $datos['codigo_color']
            ]);
            return $color;
        }
        return null;
    }
}
