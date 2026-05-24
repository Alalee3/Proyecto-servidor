<?php

namespace App\Repositories\Firma;

use App\Models\Firma;

class FirmaCreateRepo
{
    /**
     * Crea una nueva firma para el usuario actualmente autenticado.
     */
    public function crear(array $datos)
    {
        $firma = Firma::create([
            'id_usuario' => auth()->user()->usu_codigo,
            'foto_firma' => $datos['foto_firma'] ?? null,
            'estatus' => '1'
        ]);

        return $firma->id_firma;
    }
}
