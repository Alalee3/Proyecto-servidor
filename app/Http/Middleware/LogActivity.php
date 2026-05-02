<?php

namespace App\Http\Middleware;

use Closure;
use App\Models\Bitacora;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class LogActivity
{
    /**
     * Maneja la petición entrante.
     * 
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @param  string  $action  (MOSTRAR, REPORTE, etc.)
     * @return mixed
     */
    public function handle(Request $request, Closure $next, $action)
    {
        // Ejecutamos la acción primero
        $response = $next($request);

        // Si el usuario está autenticado, auditamos la acción
        if (Auth::check()) {
            Bitacora::create([
                'id_usuario' => Auth::user()->usu_cedula ?? Auth::id(),
                'modulo_afectado_bitacora' => ucfirst($request->segment(1)) ?? 'General',
                'tabla_afectada_bitacora' => $request->segment(1) ?? 'N/A', // Captura el primer segmento de la URL
                'id_registro_afectado_bitacora' => (string) ($request->segment(2) ?? '0'), // Intenta capturar un ID si existe en la URL
                'accion_bitacora' => strtoupper($action),
                'valores_anteriores_bitacora' => null,
                'valores_nuevos_bitacora' => null,
                'ip_origen_bitacora' => $request->ip(),
                'fecha_creacion' => now(),
                'estatus' => '1',
            ]);
        }

        return $response;
    }
}
