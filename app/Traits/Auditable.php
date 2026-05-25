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
        // Obtenemos el nombre del módulo (puede definirse en el modelo como $moduleName)
        $modulo = property_exists($model, 'moduleName') ? $model->moduleName : class_basename($model);

        // Filtrar campos excluidos de la bitácora (ej: datos binarios como imágenes)
        $exclude = property_exists($model, 'auditExclude') ? (array) $model->auditExclude : [];

        if ($anteriores !== null) {
            $anteriores = array_diff_key($anteriores, array_flip($exclude));
            // Codificar datos binarios a base64 para evitar errores de JSON
            foreach ($anteriores as $key => $val) {
                if (is_string($val) && !mb_check_encoding($val, 'UTF-8')) {
                    $anteriores[$key] = 'base64:' . base64_encode($val);
                }
            }
        }
        if ($nuevos !== null) {
            $nuevos = array_diff_key($nuevos, array_flip($exclude));
            // Codificar datos binarios a base64 para evitar errores de JSON
            foreach ($nuevos as $key => $val) {
                if (is_string($val) && !mb_check_encoding($val, 'UTF-8')) {
                    $nuevos[$key] = 'base64:' . base64_encode($val);
                }
            }
        }

        Bitacora::create([
            'id_usuario' => Auth::user()->usu_cedula ?? (Auth::id() ?? 1),
            'modulo_afectado_bitacora' => $modulo,
            'tabla_afectada_bitacora' => $model->getTable(),
            'id_registro_afectado_bitacora' => (string) $model->getKey(),
            'accion_bitacora' => $accion,
            'valores_anteriores_bitacora' => $anteriores,
            'valores_nuevos_bitacora' => $nuevos,
            'ip_origen_bitacora' => Request::ip(),
            'fecha_creacion' => now(),
            'estatus' => '1',
        ]);
    }
}
