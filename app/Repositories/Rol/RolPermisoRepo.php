<?php

namespace App\Repositories\Rol;

use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class RolPermisoRepo
{
    public function getRol($rolId)
    {
        return DB::connection('pgsql_daece')
            ->table('rol')
            ->where('rol_codigo', $rolId)
            ->first();
    }

    public function getModules()
    {
        $permisos = DB::table('permiso')
            ->orderBy('nombre_permiso')
            ->get();

        $modules = [];

        foreach ($permisos as $p) {
            if (empty($p->nombre_permiso))
                continue;

            $parts = explode(' ', trim($p->nombre_permiso), 2);

            if (count($parts) < 2) {
                $module = 'General';
                $action = $p->nombre_permiso;
            } else {
                $module = $parts[1]; // El resto del nombre del permiso será el "módulo"
                $action = $parts[0];
            }

            // Format module to be capitalized properly if it isn't
            $module = ucwords($module);

            $modules[$module][] = [
                'id' => $p->id_permiso,
                'action' => $action,
                'full_name' => $p->nombre_permiso,
                'estatus' => $p->estatus
            ];
        }

        // Ordenamos alfabéticamente los módulos
        ksort($modules);

        return $modules;
    }

    public function getRolePermissions($rolId)
    {
        return DB::table('rol_permiso')
            ->where('id_rol', $rolId)
            ->where('estatus', 1)
            ->pluck('id_permiso')
            ->toArray();
    }

    public function saveRolePermissions($rolId, $selectedPermissions)
    {
        DB::beginTransaction();
        try {
            // Desactivar los permisos que ya no están seleccionados
            if (empty($selectedPermissions)) {
                DB::table('rol_permiso')
                    ->where('id_rol', $rolId)
                    ->update(['estatus' => 0, 'fecha_actualizacion' => Carbon::now()]);
            } else {
                DB::table('rol_permiso')
                    ->where('id_rol', $rolId)
                    ->whereNotIn('id_permiso', $selectedPermissions)
                    ->update(['estatus' => 0, 'fecha_actualizacion' => Carbon::now()]);
            }

            // Insertar o activar los permisos seleccionados
            foreach ($selectedPermissions as $idPermiso) {
                $exists = DB::table('rol_permiso')
                    ->where('id_rol', $rolId)
                    ->where('id_permiso', $idPermiso)
                    ->first();

                if ($exists) {
                    DB::table('rol_permiso')
                        ->where('id_rol_permiso', $exists->id_rol_permiso)
                        ->update([
                            'estatus' => 1,
                            'fecha_actualizacion' => Carbon::now()
                        ]);
                } else {
                    DB::table('rol_permiso')->insert([
                        'id_rol' => $rolId,
                        'id_permiso' => $idPermiso,
                        'estatus' => 1,
                        'fecha_creacion' => Carbon::now()
                    ]);
                }
            }

            DB::commit();
            return true;
        } catch (\Exception $e) {
            DB::rollBack();
            return false;
        }
    }
}
