<?php

namespace App\Repositories;

use Exception;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Hash;

class UsuarioRepository
{

    public function select_roles()
    {
        return DB::connection('external_db')
            ->table('rol')
            ->select('rol_codigo as id_rol', 'rol_nombre as acceso')
            //->where('rol_estatus', 'A')
            ->get();
    }

    public function listar($busqueda = '', $paginacion = 5)
    {
        return DB::connection('external_db')
            ->table('usuario as u')
            ->join('persona as p', 'u.usu_cedula', '=', 'p.per_cedula')
            ->join('rol as r', 'u.usu_cod_rol', '=', 'r.rol_codigo')
            ->select(
                'u.usu_codigo as id',
                'p.per_nombres as name',
                'p.per_apellidos as apellido',
                'u.usu_estatus as estatus',
                'r.rol_nombre as roles_nombres'
            )
            ->where('u.usu_codigo', '!=', Auth::id())
            ->when($busqueda, function ($consulta, $busqueda) {
                $consulta->where('p.per_nombres', 'LIKE', '%' . $busqueda . '%')
                    ->orWhere('p.per_apellidos', 'LIKE', '%' . $busqueda . '%')
                    ->orWhere('u.usu_cedula', 'LIKE', '%' . $busqueda . '%');
            })
            ->orderBy('u.usu_codigo', 'desc')
            ->paginate($paginacion);
    }

    public function mostrar($id)
    {
        $user = \App\Models\User::find($id);
        if ($user) {
            \App\Models\User::logMostrar($user);
        }
        return $user;
    }

    public function crear($data, $roles)
    {
        DB::beginTransaction();
        try {
            $user = \App\Models\User::create([
                'name' => $data['name'],
                'apellido' => $data['apellido'],
                'cedula' => $data['cedula'],
                'email' => $data['email'],
                'telefono' => $data['telefono'],
                'password' => $data['password']
            ]);

            foreach ($roles as $rol) {
                DB::table('usuario_rol')->insert([
                    'id_users' => $user->id,
                    'id_rol' => $rol
                ]);
            }
            DB::commit();
        } catch (Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }

    /**
     * Obtiene los roles de un usuario por su cédula.
     */
    public function getRolesPorCedula(string $cedula)
    {
        return DB::connection('emulacion_sogac_2')
            ->table('usuario as u')
            ->join('rol as r', 'u.usu_cod_rol', '=', 'r.rol_codigo')
            ->where('u.usu_cedula', $cedula)
            ->where('u.usu_estatus', 'A')
            ->select('u.usu_cod_rol', 'r.rol_nombre')
            ->get();
    }

    /**
     * Verifica si un usuario tiene el rol 3 activo.
     */
    public function tieneRol3(string $cedula): bool
    {
        return DB::connection('emulacion_sogac_2')
            ->table('usuario')
            ->where('usu_cedula', $cedula)
            ->where('usu_cod_rol', 3)
            ->where('usu_estatus', 'A')
            ->exists();
    }

    /**
     * Obtiene el código de usuario (usu_codigo) para un rol específico.
     */
    public function getUsuCodigo(string $cedula, int $rolId)
    {
        return DB::connection('emulacion_sogac_2')
            ->table('usuario')
            ->where('usu_cedula', $cedula)
            ->where('usu_cod_rol', $rolId)
            ->where('usu_estatus', 'A')
            ->value('usu_codigo');
    }
}
