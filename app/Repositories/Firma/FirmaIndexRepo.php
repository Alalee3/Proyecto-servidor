<?php

namespace App\Repositories\Firma;

use App\Models\Firma;

class FirmaIndexRepo
{
    /**
     * Lista las firmas con búsqueda y paginación.
     */
    public function listar($busqueda = '', $paginacion = 5)
    {
        return Firma::with('usuario')
            ->when($busqueda, function ($consulta, $busqueda) {
                $consulta->whereHas('usuario', function ($q) use ($busqueda) {
                    $q->where('usu_nombre', 'LIKE', '%' . $busqueda . '%');
                });
            })
            ->orderBy('id_firma', 'desc')
            ->paginate($paginacion);
    }

    /**
     * Inhabilita una firma.
     */
    public function inhabilitar($id)
    {
        $firma = Firma::find($id);
        if ($firma) {
            return $firma->update(['estatus' => '3']);
        }
        return false;
    }

    /**
     * Restaura una firma.
     */
    public function restaurar($id)
    {
        $firma = Firma::where('id_firma', $id)->where('estatus', '3')->first();
        if ($firma) {
            return $firma->update(['estatus' => '1']);
        }
        return false;
    }
}
