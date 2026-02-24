<?php

namespace App\Traits;

use App\Models\Bitacora;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Request;

trait Auditable
{
    /**
     * Se ejecuta automáticamente al arrancar el modelo.
     */
    protected static function bootAuditable()
    {
        // Evento: Al crear un registro
        static::created(function ($model) {
            static::audit($model, 'CREAR', null, $model->getAttributes());
        });

        // Evento: Al actualizar un registro
        static::updated(function ($model) {
            // Solo auditamos si hubo cambios reales
            if ($model->getChanges()) {
                static::audit($model, 'MODIFICAR', $model->getOriginal(), $model->getChanges());
            }
        });

        // Evento: Al eliminar un registro
        static::deleted(function ($model) {
            static::audit($model, 'ELIMINAR', $model->getOriginal(), null);
        });
    }

    /**
     * Permite registrar manualmente una acción de visualización (MOSTRAR).
     */
    public static function logMostrar($model)
    {
        static::audit($model, 'MOSTRAR', $model->getAttributes(), null);
    }

    /**
     * Centraliza la inserción en la tabla bitacora.
     */
    public static function audit($model, $accion, $anteriores, $nuevos)
    {
        Bitacora::create([
            'id_users' => Auth::id() ?? 1, // ID 1 o null si es un proceso de consola
            'tabla_afectada_bitacora' => $model->getTable(),
            'id_registro_afectado_bitacora' => $model->getKey(),
            'accion_bitacora' => $accion,
            'valores_anteriores_bitacora' => $anteriores ? json_encode($anteriores) : null,
            'valores_nuevos_bitacora' => $nuevos ? json_encode($nuevos) : null,
            'ip_origen_bitacora' => Request::ip(),
            'fecha_creacion' => now(),
            'estatus' => 1,
        ]);
    }
}
