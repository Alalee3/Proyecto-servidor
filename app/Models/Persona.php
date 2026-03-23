<?php

namespace App\Models;

class Persona extends DaeceModel
{
    protected $table = 'persona';
    protected $primaryKey = 'per_cedula';
    public $incrementing = false;
    protected $keyType = 'string';

    protected $fillable = [
        'per_cedula',
        'per_documento',
        'per_apellidos',
        'per_nombres',
    ];

    /**
     * Accesor para el nombre completo.
     */
    public function getFullNameAttribute()
    {
        return "{$this->per_nombres} {$this->per_apellidos}";
    }
}
