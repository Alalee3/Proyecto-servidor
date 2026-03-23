<?php

namespace App\Models;

class Rol extends DaeceModel
{
    protected $table = 'rol';
    protected $primaryKey = 'rol_codigo';
    protected $fillable = ['rol_nombre', 'rol_estatus'];

    /**
     * Relación con los usuarios que tienen este rol.
     */
    public function usuarios()
    {
        return $this->hasMany(User::class, 'usu_cod_rol', 'rol_codigo');
    }
}
