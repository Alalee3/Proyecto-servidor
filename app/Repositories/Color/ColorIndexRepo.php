<?php

namespace App\Repositories\Color;

use App\Models\Color;

class ColorIndexRepo
{
    /**
     * Lista los colores con búsqueda y paginación.
     */
    public function listar($busqueda = '', $paginacion = 5)
    {
        return Color::when($busqueda, function ($consulta, $busqueda) {
                $consulta->where('nombre_color', 'LIKE', '%' . $busqueda . '%')
                         ->orWhere('codigo_color', 'LIKE', '%' . $busqueda . '%');
            })
            ->orderBy('id_color', 'desc')
            ->paginate($paginacion);
    }

    /**
     * Inhabilita un color.
     */
    public function inhabilitar($id)
    {
        $color = Color::find($id);
        if ($color) {
            return $color->update(['estatus' => '3']);
        }
        return false;
    }

    /**
     * Restaura un color.
     */
    public function restaurar($id)
    {
        $color = Color::where('id_color', $id)->where('estatus', '3')->first();
        if ($color) {
            return $color->update(['estatus' => '1']);
        }
        return false;
    }
}
