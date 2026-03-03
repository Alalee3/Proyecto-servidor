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
    /**
     * Verifica si el usuario autenticado tiene un permiso específico a través de sus roles activos.
     *
     * @param string $permissionName Nombre exacto del permiso (ej: 'Listar Evento').
     * @return bool
     */
    public function checkPermission(string $permissionName): bool
    {
        if (!Auth::check()) {
            return false;
        }

        // Buscamos si existe una relación activa entre el usuario, sus roles y el permiso solicitado
        return DB::table('usuario_rol as ur')
            ->join('rol_permiso as rp', 'ur.id_rol', '=', 'rp.id_rol')
            ->join('permiso as p', 'rp.id_permiso', '=', 'p.id_permiso')
            ->where('ur.id_users', Auth::id())
            ->where('ur.estatus', '1')        // El rol asignado al usuario debe estar activo
            ->where('p.nombre_permiso', $permissionName)
            ->where('p.estatus', '1')         // El permiso debe existir y estar activo
            ->where('rp.estatus', '1')        // La vinculación rol-permiso debe estar activa
            ->exists();
    }

    public function checkCoordinador(): bool
    {
        return $this->checkRole(1); // El rol_id para Coordinador
    }

    public function checkProfesor(): bool
    {
        return $this->checkRole(2); // El rol_id para Profesor
    }
}
