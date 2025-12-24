<?php

namespace App\Repositories\Planificacion;

use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\{Facades\DB, Facades\Auth, Facades\Log};

class PlanificacionIndexRepo
{
    /**
     * Obtiene una lista paginada de planificaciones con filtros.
     */
    public function listar(array $filters = [], int $perPage = 10, bool $onlyCurrentUserAndRole = false): LengthAwarePaginator
    {
        $query = DB::table('planificacion as p')
            ->join('detalle_profesor_asignado as dpa', 'p.id_profesor_asignado', '=', 'dpa.id_detalle_profesor_asignado')
            ->join('users as u', 'dpa.id_users', '=', 'u.id')
            ->join('unidad_curricular as uc', 'dpa.id_unidad_curricular', '=', 'uc.id_unidad_curricular')
            ->join('seccion as s', 'dpa.id_seccion', '=', 's.id_seccion')
            ->join('malla_academica as ma', 'uc.id_malla_academica', '=', 'ma.id_malla_academica')
            ->join('pnf', 'ma.id_pnf', '=', 'pnf.id_pnf')
            ->select(
                'p.id_planificacion as planificacion_id',
                'u.name as docente_nombre',
                'u.apellido as docente_apellido',
                'p.estatus',
                'uc.nombre_unidad_curricular',
                's.nombre_seccion',
                'pnf.nombre_pnf',
                'uc.trayecto_unidad_curricular'
            );

        if (isset($filters['search_term']) && !empty($filters['search_term'])) {
            $query->where(function ($q) use ($filters) {
                $q->where('u.name', 'like', '%' . $filters['search_term'] . '%')
                    ->orWhere('u.apellido', 'like', '%' . $filters['search_term'] . '%')
                    ->orWhere('uc.nombre_unidad_curricular', 'like', '%' . $filters['search_term'] . '%')
                    ->orWhere('pnf.nombre_pnf', 'like', '%' . $filters['search_term'] . '%');
            });
        }

        if ($onlyCurrentUserAndRole && Auth::check()) {
            // Nota: La lógica de roles puede necesitar ajuste según la nueva tabla de roles si cambió
            // Asumimos que id_users sigue siendo la clave foránea en detalle_profesor_asignado
            $userId = Auth::id();

            // Filtrar por el usuario logueado en la tabla de asignación
            $query->where('dpa.id_users', $userId);
        }

        $query->orderByDesc('p.id_planificacion');

        return $query->paginate($perPage);
    }

    /**
     * Aprueba una planificación y todos sus cortes asociados.
     */
    public function aprobarPlanificacion(int $planificacionId): bool
    {
        DB::beginTransaction();
        try {
            DB::table('planificacion')
                ->where('id_planificacion', $planificacionId)
                ->update(['estatus' => 1]);

            // Nota: Se debe verificar si 'detalle_planificacion' y 'detalle_actividad' existen en la nueva BD
            // Según el SQL proporcionado, NO existen tablas con esos nombres exactos.
            // Las tablas parecen ser 'corte', 'estrategia_pedagogica', 'detalle_evaluacion', etc.
            // Por ahora, solo actualizamos el estatus de la planificación para cumplir con el requerimiento inmediato del Listado.
            // Se requerirá una revisión más profunda para aprobar cascada en la nueva estructura.

            DB::commit();
            return true;
        } catch (\Exception $e) {
            DB::rollBack();
            Log::error("Error al aprobar planificación: " . $e->getMessage());
            return false;
        }
    }

    /**
     * Rechaza una planificación completa.
     */
    public function rechazarPlanificacionConCortes(int $planificacionId, array $cortesRechazados): bool
    {
        DB::beginTransaction();
        try {
            // Lógica simplificada para el refactor inicial del listado
            DB::table('planificacion')
                ->where('id_planificacion', $planificacionId)
                ->update(['estatus' => 3]);

            // TODO: Implementar lógica de rechazo detallada para la nueva estructura de Cortes y Evaluaciones

            DB::commit();
            return true;
        } catch (\Exception $e) {
            DB::rollBack();
            Log::error("Error al rechazar planificación: " . $e->getMessage());
            return false;
        }
    }

    public function eliminarMotivoRechazoPorCorte($detalleId)
    {
        // TODO: Ajustar a la nueva estructura de 'motivo_rechazo' y 'corte'
        return true;
    }
}
