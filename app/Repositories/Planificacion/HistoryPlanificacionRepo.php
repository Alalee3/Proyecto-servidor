<?php

namespace App\Repositories\Planificacion;

use Illuminate\Support\{Facades\DB, Facades\Log, Facades\Auth};

class HistoryPlanificacionRepo
{
    /**
     * Obtiene una lista paginada del historial de planificaciones del docente actual.
     */
    public function listarHistorial(array $filters = [], int $perPage = 10)
    {
        $dbSogc = config('database.connections.emulacion_sogac_2.database');
        $userId = Auth::id();

        $query = DB::table('planificacion as p')
            ->join("$dbSogc.seccion_unidad_docente as sud", 'p.id_profesor_asignado', '=', 'sud.sud_codigo')
            ->join("$dbSogc.usuario as u", 'sud.sud_ced_docente', '=', 'u.usu_cedula')
            ->join("$dbSogc.persona as per", 'u.usu_cedula', '=', 'per.per_cedula')
            ->join("$dbSogc.unidad_curricular as uc", 'sud.sud_cod_unidad', '=', 'uc.ucu_codigo')
            ->join("$dbSogc.seccion as s", 'sud.sud_cod_seccion', '=', 's.sec_codigo')
            ->join("$dbSogc.lapso_academico as la", 's.sec_cod_lapso_academico', '=', 'la.lap_codigo')
            ->leftJoin("$dbSogc.semestre as sem", 's.sec_cod_semestre', '=', 'sem.sem_codigo')
            ->leftJoin("$dbSogc.trayecto as tr", 'sem.sem_cod_trayecto', '=', 'tr.tra_codigo')
            ->select(
                'p.id_planificacion as planificacion_id',
                'uc.ucu_nombre as nombre_unidad_curricular',
                's.sec_nombre as nombre_seccion',
                'la.lap_nombre as nombre_lapso',
                'p.estatus',
                'p.tipo_planificacion',
                'p.proposito_unidad',
                'sem.sem_nombre as nombre_semestre',
                'tr.tra_nombre as nombre_trayecto'
            )
            ->where('u.usu_codigo', $userId)
            ->distinct();

        if (isset($filters['search_term']) && !empty($filters['search_term'])) {
            $query->where(function ($q) use ($filters) {
                $q->where('uc.ucu_nombre', 'like', '%' . $filters['search_term'] . '%')
                    ->orWhere('s.sec_nombre', 'like', '%' . $filters['search_term'] . '%')
                    ->orWhere('la.lap_nombre', 'like', '%' . $filters['search_term'] . '%');
            });
        }

        $query->orderByDesc('p.id_planificacion');

        return $query->paginate($perPage);
    }

    /**
     * Clona una planificación e inserta todos sus detalles con las nuevas fechas de evaluación.
     */
    public function duplicarPlanificacion(int $sourcePlanificacionId, int $newProfesorAsignadoId, array $evaluacionesFechas, string $proposito, array $tiposSeccion): int
    {
        DB::beginTransaction();

        try {
            // 1. Crear el nuevo registro principal de planificacion
            // Se crea inicialmente con estatus '4' (Borrador) para permitir revisión del docente, o '2' (Pendiente)
            // Guardamos como '4' (Borrador) para que pueda previsualizarla y darle guardar formal en el listado regular
            $newPlanificacionId = DB::table('planificacion')->insertGetId([
                'id_profesor_asignado' => $newProfesorAsignadoId,
                'estatus' => '4', // Borrador / Incompleta
                'tipo_planificacion' => json_encode($tiposSeccion),
                'proposito_unidad' => $proposito,
            ]);

            // 2. Obtener todas las unidades (cortes) de la planificación origen
            $unidadesOrigen = DB::table('unidad_corte')
                ->where('id_planificacion', $sourcePlanificacionId)
                ->get();

            foreach ($unidadesOrigen as $unidad) {
                $oldUnidadId = $unidad->id_unidad_corte; // Primary Key de unidad_corte en BD

                // Crear nueva unidad_corte
                $newUnidadId = DB::table('unidad_corte')->insertGetId([
                    'id_planificacion' => $newPlanificacionId,
                    'numero_unidad_corte' => $unidad->numero_unidad_corte,
                    'indicador_logro_unidad_corte' => $unidad->indicador_logro_unidad_corte,
                    'id_tecnica_actividad' => $unidad->id_tecnica_actividad,
                    'descripcion_actividad_unidad_corte' => $unidad->descripcion_actividad_unidad_corte,
                    'estatus' => '2', // Pendiente
                ]);

                // 3. Clonar recursos asociados
                $recursos = DB::table('detalle_recurso')
                    ->where('id_unidad_corte', $oldUnidadId)
                    ->where('estatus', '1')
                    ->get();

                foreach ($recursos as $recurso) {
                    DB::table('detalle_recurso')->insert([
                        'id_unidad_corte' => $newUnidadId,
                        'id_recurso' => $recurso->id_recurso,
                        'estatus' => '1',
                    ]);
                }

                // 4. Clonar contenidos asociados
                $contenidos = DB::table('detalle_contenido')
                    ->where('id_unidad_corte', $oldUnidadId)
                    ->where('estatus', '1')
                    ->get();

                foreach ($contenidos as $contenido) {
                    DB::table('detalle_contenido')->insert([
                        'id_unidad_corte' => $newUnidadId,
                        'id_contenido' => $contenido->id_contenido,
                        'estatus' => '1',
                    ]);
                }

                // 5. Clonar referencias bibliográficas
                $bibliografias = DB::table('detalle_bibliografia')
                    ->where('id_unidad_corte', $oldUnidadId)
                    ->where('estatus', '1')
                    ->get();

                foreach ($bibliografias as $bib) {
                    DB::table('detalle_bibliografia')->insert([
                        'id_unidad_corte' => $newUnidadId,
                        'id_bibliografia' => $bib->id_bibliografia,
                        'estatus' => '1',
                    ]);
                }

                // 6. Clonar evaluaciones actualizando la fecha
                $evaluaciones = DB::table('detalle_evaluacion')
                    ->where('id_unidad_corte', $oldUnidadId)
                    ->where('estatus', '!=', '3') // No copiamos rechazadas
                    ->get();

                foreach ($evaluaciones as $eval) {
                    $oldEvalId = $eval->id_detalle_evaluacion;
                    
                    // Buscar la nueva fecha en el array mapeado
                    $nuevaFecha = $evaluacionesFechas[$oldEvalId] ?? $eval->fecha_evaluacion_detalle_evaluacion;

                    DB::table('detalle_evaluacion')->insert([
                        'id_unidad_corte' => $newUnidadId,
                        'id_tipo_evaluacion' => $eval->id_tipo_evaluacion,
                        'id_tecnica_evaluacion' => $eval->id_tecnica_evaluacion,
                        'id_instrumento' => $eval->id_instrumento,
                        'ponderacion_detalle_evaluacion' => $eval->ponderacion_detalle_evaluacion,
                        'integrantes_detalle_evaluacion' => $eval->integrantes_detalle_evaluacion,
                        'fecha_evaluacion_detalle_evaluacion' => $nuevaFecha,
                        'forma_participacion_detalle_evaluacion' => $eval->forma_participacion_detalle_evaluacion,
                        'estatus' => '2', // Pendiente
                    ]);
                }
            }

            DB::commit();
            return $newPlanificacionId;
        } catch (\Exception $e) {
            DB::rollBack();
            Log::error("Error al duplicar planificación: " . $e->getMessage());
            throw $e;
        }
    }
}
