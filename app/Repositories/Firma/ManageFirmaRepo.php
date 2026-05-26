<?php

namespace App\Repositories\Firma;

use App\Models\Firma;
use Illuminate\Support\Facades\DB;

class ManageFirmaRepo
{
    /**
     * Obtiene la firma actual activa del usuario.
     */
    public function obtenerFirmaActual($idUsuario)
    {
        return Firma::where('id_usuario', $idUsuario)
            ->where('estatus', '1')
            ->first();
    }

    /**
     * Guarda o actualiza la firma del usuario.
     */
    public function guardarFirma($idUsuario, $pngData)
    {
        DB::transaction(function () use ($idUsuario, $pngData) {
            Firma::updateOrCreate(
                ['id_usuario' => $idUsuario],
                [
                    'foto_firma' => $pngData,
                    'estatus' => '1'
                ]
            );
        });
    }
}
