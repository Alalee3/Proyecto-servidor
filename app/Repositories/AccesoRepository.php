<?php

namespace App\Repositories;

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;

class AccesoRepository
{
    /**
     * Verifica si el usuario autenticado tiene un rol específico y está activo.
     *
     * @param int $rolId El ID del rol a verificar (ej. 1 para Coordinador, 2 para Profesor).
     * @return bool
     */
    public function checkRole(int $rolId): bool
    {
        // Verifica si el usuario actual está autenticado
        if (!Auth::check()) {
            return false;
        }

        DB::enableQueryLog();

        // Busca en la tabla 'usuario_rol' si el usuario tiene el rol y está activo
        return DB::table('usuario_rol')
            ->where('id_users', Auth::id()) // ID del usuario autenticado
            ->where('id_rol', $rolId)         // ID del rol que se está buscando
            ->where('estatus', 1)             // Verifica que el estatus del rol sea activo (1)
            ->exists();                       // Retorna true si encuentra una coincidencia, false en caso contrario
    }

    // Puedes mantener estas funciones para claridad o eliminarlas si solo usas checkRole
    public function checkCoordinador(): bool
    {
        return $this->checkRole(1); // El rol_id para Coordinador
    }

    public function checkProfesor(): bool
    {
        return $this->checkRole(2); // El rol_id para Profesor
    }
}
