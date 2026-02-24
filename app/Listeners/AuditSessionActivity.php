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
        $this->log($event->user->id, 'LOGIN');
    }

    /**
     * Maneja el evento de Logout.
     */
    public function handleLogout(Logout $event)
    {
        if ($event->user) {
            $this->log($event->user->id, 'LOGOUT');
        }
    }

    /**
     * Inserta el registro de sesión en la Bitácora.
     */
    protected function log($userId, $accion)
    {
        Bitacora::create([
            'id_users' => $userId,
            'tabla_afectada_bitacora' => 'users',
            'id_registro_afectado_bitacora' => $userId,
            'accion_bitacora' => $accion,
            'valores_anteriores_bitacora' => null,
            'valores_nuevos_bitacora' => null,
            'ip_origen_bitacora' => Request::ip(),
            'fecha_creacion' => now(),
            'estatus' => 1,
        ]);
    }
}
