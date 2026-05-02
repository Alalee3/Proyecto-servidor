<?php

namespace App\Listeners;

use App\Models\Bitacora;
use Illuminate\Auth\Events\Login;
use Illuminate\Auth\Events\Logout;
use Illuminate\Support\Facades\Request;

class AuditSessionActivity
{
    /**
     * Maneja el evento de Login.
     */
    public function handleLogin(Login $event)
    {
        $this->log($event->user, 'LOGIN');
    }

    /**
     * Maneja el evento de Logout.
     */
    public function handleLogout(Logout $event)
    {
        if ($event->user) {
            $this->log($event->user, 'LOGOUT');
        }
    }

    /**
     * Inserta el registro de sesión en la Bitácora.
     */
    protected function log($user, $accion)
    {
        $userId = is_object($user) ? ($user->usu_cedula ?? $user->getAuthIdentifier()) : $user;

        Bitacora::create([
            'id_usuario' => $userId,
            'modulo_afectado_bitacora' => 'Seguridad',
            'tabla_afectada_bitacora' => 'users',
            'id_registro_afectado_bitacora' => (string) $userId,
            'accion_bitacora' => $accion,
            'valores_anteriores_bitacora' => null,
            'valores_nuevos_bitacora' => null,
            'ip_origen_bitacora' => Request::ip(),
            'fecha_creacion' => now(),
            'estatus' => '1',
        ]);
    }
}
