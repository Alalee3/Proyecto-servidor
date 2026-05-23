<?php

namespace App\Repositories\Color;

use App\Models\Color;

class ColorViewRepo
{
    /**
     * Obtiene los detalles de un color.
     */
    public function mostrar($id)
    {
        $color = Color::find($id);
        if ($color) {
            Color::logMostrar($color);
        }
        return $color;
    }
}
