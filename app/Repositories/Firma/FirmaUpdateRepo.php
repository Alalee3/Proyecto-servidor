<?php

namespace App\Repositories\Firma;

use App\Models\Firma;

class FirmaUpdateRepo
{
    /**
     * Obtiene una firma por su ID.
     */
    public function obtenerPorId($id)
    {
        return Firma::with('usuario')->find($id);
    }

    /**
     * Actualiza la imagen de firma de una firma existente.
     * El usuario asignado no se modifica (pertenece al usuario autenticado).
     */
    public function actualizar($id, array $datos)
    {
        $firma = Firma::find($id);
        if ($firma) {
            $updateData = [];
            if (isset($datos['foto_firma'])) {
                $updateData['foto_firma'] = $datos['foto_firma'];
            }
            if (!empty($updateData)) {
                $firma->update($updateData);
            }
            return $firma;
        }
        return null;
    }
}
