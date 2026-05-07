<?php

namespace App\Repositories\Planificacion;

use Illuminate\Support\{Facades\DB, Facades\Log};

class PlanificacionEditRepo
{
    /**
     * Guarda (actualiza) una planificación existente y sus detalles.
     */
    protected $createRepo;

    public function __construct()
    {
        $this->createRepo = new \App\Repositories\Planificacion\PlanificacionCreateRepo();
    }

    public function updatePlanificacion(int $planificacionId, array $data): bool
    {
        DB::beginTransaction();
        try {
            // --- SINCRONIZACIÓN DE UNIDADES (tabla 'unidad_corte') ---
            $oldActiveCortes = DB::table('unidad_corte')
                ->where('id_planificacion', $planificacionId)
                ->whereIn('estatus', ['1', '2', '3']) // Activos, Pendientes o Rechazados
                ->get()
                ->keyBy('id_unidad_corte');

            $newUnidades = collect($data['unidades']);
            $processedOldCorteIds = [];

            foreach ($newUnidades as $unidadData) {
                $corteNumero = $unidadData['numero'];
                $foundOldCorte = null;

                // Buscar orden existente por número
                foreach ($oldActiveCortes as $oldCorte) {
                    if ($oldCorte->numero_unidad_corte == $corteNumero && $oldCorte->estatus != '3') {
                        $foundOldCorte = $oldCorte;
                        break;
                    }
                }

                // Si no encontramos uno activo (ej. estaba rechazado, o no existía), buscamos por ID si viniere, pero aquí nos basamos en numero
                if (!$foundOldCorte) {
                    // Buscar unidad rechazada para reactivar/actualizar
                    $foundOldCorte = DB::table('unidad_corte')
                        ->where('id_planificacion', $planificacionId)
                        ->where('numero_unidad_corte', $corteNumero)
                        ->first();
                }

                // Si el corte está Aprobado (1), no lo tocamos.
                // Pendiente (2) SÍ lo tocamos porque es un borrador.
                if ($foundOldCorte && $foundOldCorte->estatus == '1') {
                    $processedOldCorteIds[] = $foundOldCorte->id_unidad_corte;
                    continue;
                }

                $corteId = null;
                if ($foundOldCorte) {
                    $corteId = $foundOldCorte->id_unidad_corte;
                    $processedOldCorteIds[] = $corteId;

                    $corteModel = \App\Models\UnidadCorte::find($corteId);
                    if ($corteModel) {
                        $corteModel->update([
                            'indicador_logro_unidad_corte' => $unidadData['indicadores_logro'] ?? null,
                            'estatus' => '2', // Reactivar a pendiente/guardado
                            'descripcion_motivo_rechazo_unidad_corte' => null // Limpiar motivos de rechazo previos
                        ]);
                    }
                } else {
                    $corteModel = \App\Models\UnidadCorte::create([
                        'id_planificacion' => $planificacionId,
                        'numero_unidad_corte' => $corteNumero,
                        'indicador_logro_unidad_corte' => $unidadData['indicadores_logro'] ?? null,
                        'estatus' => '2',
                    ]);
                    $corteId = $corteModel->getKey();
                }

                $evaluacionesData = array_map(function ($eval) {
                    $tipoEvalId = $this->createRepo->findOrCreateTipoEvaluacion($eval['evaluacion_id']);
                    $tecnicaEvalId = $this->createRepo->findOrCreateTecnicaEvaluacion($eval['tecnica_id']);

                    return [
                        'id_tipo_evaluacion' => $tipoEvalId,
                        'id_tecnica_evaluacion' => $tecnicaEvalId,
                        'ponderacion_detalle_evaluacion' => $eval['ponderacion'],
                        'fecha_evaluacion_detalle_evaluacion' => $eval['fecha_evaluacion'],
                        'forma_participacion_detalle_evaluacion' => $eval['forma_participacion'],
                        'integrantes_detalle_evaluacion' => ($eval['forma_participacion'] == '2') ? ($eval['integrantes'] ?? null) : 1,
                    ];
                }, $unidadData['evaluaciones']);

                $this->syncCorteDetails(
                    'detalle_evaluacion',
                    'id_tipo_evaluacion',
                    $corteId,
                    $evaluacionesData,
                    'id_tipo_evaluacion',
                    ['id_tecnica_evaluacion', 'ponderacion_detalle_evaluacion', 'fecha_evaluacion_detalle_evaluacion', 'forma_participacion_detalle_evaluacion', 'integrantes_detalle_evaluacion']
                );

                // --- Sincronizar Estrategias, Recursos y Contenidos ---
                $this->syncEstrategiasCorte($corteId, $unidadData['estrategias']);

                $recursos = [];
                foreach ($unidadData['estrategias'] as $est) {
                    foreach ($est['recursos'] as $rec) {
                        $recursos[] = $rec;
                    }
                }
                $this->syncRecursosCorte($corteId, $recursos);

                $contenidos = [];
                foreach ($unidadData['objetivos'] as $obj) {
                    foreach ($obj['contenidos'] as $cont) {
                        $contenidos[] = $cont;
                    }
                }
                $this->syncContenidosCorte($corteId, $contenidos);

                // --- Sincronizar Bibliografías por Corte ---
                $this->syncBibliografiasCorte($corteId, $unidadData['bibliografias'] ?? []);
            }

            // Unidades antiguas que no están en la nueva data (marcar eliminados?)
            // En este caso, si el usuario quita una unidad de la UI (aunque no se permite borrar cortes usualmente, solo vaciar), lo marcamos inactivo
            foreach ($oldActiveCortes as $oldCorteId => $oldCorteData) {
                if (!in_array($oldCorteId, $processedOldCorteIds)) {
                    $corteToDelete = \App\Models\UnidadCorte::find($oldCorteId);
                    if ($corteToDelete) {
                        $corteToDelete->update(['estatus' => '2']);
                    }
                }
            }

            // Actualizar estatus general de la planificación a 'En Revisión' (2) si estaba Aprobada(1), Rechazada(3) o Incompleta(4)
            $planificacionToUpdate = \App\Models\Planificacion::find($planificacionId);
            if ($planificacionToUpdate && in_array($planificacionToUpdate->estatus, ['1', '3', '4'])) {
                $planificacionToUpdate->update(['estatus' => '2']);
            }

            DB::commit();
            return true;
        } catch (\Exception $e) {
            DB::rollBack();
            Log::error("Error al actualizar planificación: " . $e->getMessage() . " trace: " . $e->getTraceAsString());
            return false;
        }
    }

    private function syncCorteDetails(string $tableName, string $foreignIdColumn, int $corteId, array $newData, string $newIdKey, array $additionalColumns = [])
    {
        // Desactivar todos los registros actuales para este corte antes de re-insertar
        // Esto permite tener múltiples registros del mismo tipo (ej. varias evaluaciones sumativas)
        DB::table($tableName)
            ->where('id_unidad_corte', $corteId)
            ->update(['estatus' => '2']);

        foreach ($newData as $item) {
            $itemId = $item[$newIdKey] ?? null;
            if (empty($itemId))
                continue;

            $insertData = [
                'id_unidad_corte' => $corteId,
                $foreignIdColumn => $itemId,
                'estatus' => '1',
                //'fecha_creacion' => now(),
            ];

            foreach ($additionalColumns as $col) {
                if (isset($item[$col])) {
                    $insertData[$col] = $item[$col];
                }
            }

            // Insertar siempre como nuevo registro para evitar colisiones de tipo
            // Usamos el modelo para mantener la auditoría
            \App\Models\DetalleEvaluacion::create($insertData);
        }
    }

    private function syncEstrategiasCorte(int $corteId, array $estrategiasData)
    {
        if (!empty($estrategiasData)) {
            $est = $estrategiasData[0]; // Solo una estrategia por unidad en este esquema

            $tecnicaActividadId = !empty($est['tecnica_actividad_id'])
                ? $this->createRepo->findOrCreateTecnicaActividad($est['tecnica_actividad_id'])
                : null;

            DB::table('unidad_corte')
                ->where('id_unidad_corte', $corteId)
                ->update([
                    'id_tecnica_actividad' => $tecnicaActividadId,
                    'descripcion_actividad_unidad_corte' => $est['actividad'] ?: null,
                ]);
        }
    }

    private function syncRecursosCorte(int $corteId, array $recursosData)
    {
        // Desactivar actuales (o eliminar y reinsertar si es más simple para esta tabla pivot)
        DB::table('detalle_recurso')->where('id_unidad_corte', $corteId)->delete();

        foreach ($recursosData as $rec) {
            $recursoName = $rec['recurso_id'] ?? null;
            if (!$recursoName)
                continue;

            $recursoId = $this->createRepo->findOrCreateRecurso($recursoName);

            DB::table('detalle_recurso')->insert([
                'id_unidad_corte' => $corteId,
                'id_recurso' => $recursoId,
                'estatus' => '1',
            ]);
        }
    }

    private function syncContenidosCorte(int $corteId, array $contenidosData)
    {
        // Desactivar actuales
        \App\Models\DetalleContenido::where('id_unidad_corte', $corteId)
            ->update(['estatus' => '2']);

        foreach ($contenidosData as $cont) {
            $contenidoId = $cont['contenido_id'] ?? null;
            if (!$contenidoId)
                continue;

            \App\Models\DetalleContenido::create([
                'id_unidad_corte' => $corteId,
                'id_contenido' => $contenidoId,
                'estatus' => '1',
            ]);
        }
    }

    private function syncBibliografiasCorte(int $corteId, array $bibliografiasData)
    {
        // Desactivar actuales
        \App\Models\DetalleBibliografia::where('id_unidad_corte', $corteId)
            ->update(['estatus' => '2']);

        foreach ($bibliografiasData as $bib) {
            $bibName = $bib['bibliografia_id'] ?? null;
            if (!$bibName)
                continue;

            $bibId = $this->createRepo->findOrCreateBibliografia($bibName);

            \App\Models\DetalleBibliografia::create([
                'id_unidad_corte' => $corteId,
                'id_bibliografia' => $bibId,
                'estatus' => '1',
            ]);
        }
    }
}
