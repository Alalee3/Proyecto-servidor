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
        return DB::table('rol')
            ->select('id_rol', 'acceso_rol as acceso')
            ->where('estatus', 1)
            ->get();
    }

    public function listar($busqueda = '', $paginacion = 5)
    {
        return DB::table('users')
            ->select(
                'users.id',
                'users.name',
                'users.apellido',
                'users.estatus',
                // Usamos 'rol.acceso_rol' en GROUP_CONCAT y lo renombramos a 'roles_nombres'
                DB::raw('GROUP_CONCAT(rol.acceso_rol SEPARATOR ", ") as roles_nombres')
            )->where('users.id', '!=', Auth::id())
            ->leftJoin('usuario_rol', function ($join) {
                $join->on('users.id', '=', 'usuario_rol.id_users')
                    ->where('usuario_rol.estatus', 1);
            })
            ->leftJoin('rol', 'usuario_rol.id_rol', '=', 'rol.id_rol')
            ->when($busqueda, function ($consulta, $busqueda) {
                // Aquí solo mantenemos la búsqueda por 'name'
                $consulta->where('users.name', 'LIKE', '%' . $busqueda . '%');
            })
            ->groupBy('users.id', 'users.name', 'users.apellido', 'users.estatus')
            ->orderBy('users.fecha_creacion', 'desc')
            ->paginate($paginacion);
    }

    public function mostrar($id)
    {
        return DB::table('users')
            ->where('users.id', $id)
            ->select('users.id', 'users.name', 'users.apellido', 'users.cedula', 'email', 'users.telefono', 'fecha_creacion', 'users.estatus')
            ->first();
    }

    public function crear($data, $roles)
    {
        DB::beginTransaction();
        try {
            $user = DB::table('users')->insertGetId([
                'name' => $data['name'],
                'apellido' => $data['apellido'],
                'cedula' => $data['cedula'],
                'email' => $data['email'],
                'telefono' => $data['telefono'],
                'password' => $data['password']
            ]);
            foreach ($roles as $rol) {

                DB::table('usuario_rol')->insert([
                    'id_users' => $user,
                    'id_rol' => $rol
                ]);
            }
            DB::commit();
        } catch (Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }
}
