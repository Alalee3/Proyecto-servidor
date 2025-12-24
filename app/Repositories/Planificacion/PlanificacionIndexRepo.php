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
            ->join('users as u', 'p.docente_id', '=', 'u.id')
            ->select(
                'p.planificacion_id',
                'u.name as docente_nombre',
                'u.apellido as docente_apellido',
                'p.estatus'
            );

        if (isset($filters['search_term']) && !empty($filters['search_term'])) {
            $query->where(function ($q) use ($filters) {
                $q->where('u.name', 'like', '%' . $filters['search_term'] . '%')
                    ->orWhere('u.apellido', 'like', '%' . $filters['search_term'] . '%');
            });
        }

        if ($onlyCurrentUserAndRole && Auth::check()) {
            $userId = Auth::id();
            $roleIdToCheck = 2;

            $query->where('p.docente_id', $userId);
            $query->join('usuario_rol as ur', 'u.id', '=', 'ur.id_users')
                ->where('ur.id_rol', $roleIdToCheck);
        }

        $query->orderByDesc('p.planificacion_id');

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
                ->where('planificacion_id', $planificacionId)
                ->update(['estatus' => 1]);

            $cortesIds = DB::table('detalle_planificacion')
                ->where('planificacion_id', $planificacionId)
                ->pluck('detalle_id');

            if ($cortesIds->isNotEmpty()) {
                DB::table('detalle_actividad')
                    ->whereIn('detalle_id', $cortesIds)
                    ->update(['estatus' => 1]);

                $motivosExistentesActivos = DB::table('motivos_rechazo')
                    ->whereIn('detalle_id', $cortesIds)
                    ->where('estatus', 1)
                    ->exists();

                if ($motivosExistentesActivos) {
                    DB::table('motivos_rechazo')
                        ->whereIn('detalle_id', $cortesIds)
                        ->where('estatus', 1)
                        ->update(['estatus' => 2]);
                }
            }

            DB::commit();
            return true;
        } catch (\Exception $e) {
            DB::rollBack();
            Log::error("Error al aprobar planificación: " . $e->getMessage());
            return false;
        }
    }

    /**
     * Rechaza una planificación completa y sus cortes asociados con motivos individuales.
     */
    public function rechazarPlanificacionConCortes(int $planificacionId, array $cortesRechazados): bool
    {
        DB::beginTransaction();
        try {
            $alMenosUnCorteRechazado = false;
            foreach ($cortesRechazados as $corte) {
                $detalleId = $corte['detalle_id'];
                $motivo = $corte['motivo'];
                if (empty($motivo)) {
                    throw new \Exception("El motivo de rechazo es obligatorio para el corte ID: {$detalleId}");
                }

                DB::table('detalle_actividad')
                    ->where('detalle_id', $detalleId)
                    ->update(['estatus' => 3]);

                DB::table('motivos_rechazo')->insert([
                    'detalle_id' => $detalleId,
                    'motivo' => $motivo,
                    'estatus' => 1,
                    'fecha_creacion' => now(),
                ]);
                $alMenosUnCorteRechazado = true;
            }

            if ($alMenosUnCorteRechazado) {
                DB::table('planificacion')
                    ->where('planificacion_id', $planificacionId)
                    ->where('estatus', '!=', 3)
                    ->update(['estatus' => 3]);
            }
            DB::commit();
            return true;
        } catch (\Exception $e) {
            DB::rollBack();
            Log::error("Error al rechazar planificación con cortes: " . $e->getMessage());
            return false;
        }
    }

    public function eliminarMotivoRechazoPorCorte($detalleId)
    {
        DB::beginTransaction();
        try {
            DB::table('motivos_rechazo')
                ->where('detalle_id', $detalleId)
                ->where('estatus', 1)
                ->update(['estatus' => 2]);

            DB::table('detalle_actividad')
                ->where('detalle_id', $detalleId)
                ->update(['estatus' => 3]);
            DB::commit();
            return true;
        } catch (\Exception $e) {
            DB::rollBack();
            Log::error("Error al eliminar motivo de rechazo del corte: " . $e->getMessage());
            return false;
        }
    }
}
