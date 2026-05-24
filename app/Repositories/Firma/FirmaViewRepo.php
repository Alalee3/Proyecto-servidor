<?php

namespace App\Repositories\Firma;

use App\Models\Firma;

class FirmaViewRepo
{
    /**
     * Obtiene los detalles de una firma.
     */
    public function mostrar($id)
    {
        $firma = Firma::with('usuario')->find($id);
        if ($firma) {
            Firma::logMostrar($firma);
        }
        return $firma;
    }
}
