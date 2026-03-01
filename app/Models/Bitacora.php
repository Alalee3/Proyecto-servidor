<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Bitacora extends Model
{
    protected $table = 'bitacora';
    protected $primaryKey = 'id_bitacora';

    public $timestamps = false;

    protected $fillable = [
        'id_users',
        'modulo_afectado_bitacora',
        'tabla_afectada_bitacora',
        'id_registro_afectado_bitacora',
        'accion_bitacora',
        'valores_anteriores_bitacora',
        'valores_nuevos_bitacora',
        'ip_origen_bitacora',
        'fecha_creacion',
        'estatus',
    ];

    /**
     * Los atributos que deben ser convertidos.
     *
     * @var array
     */
    protected $casts = [
        'valores_anteriores_bitacora' => 'array',
        'valores_nuevos_bitacora' => 'array',
    ];
}
