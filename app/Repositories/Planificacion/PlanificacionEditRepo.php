<?php

namespace App\Repositories\Planificacion;

use Illuminate\Support\{Facades\DB, Facades\Log};

class PlanificacionEditRepo
{
    /**
     * Guarda (actualiza) una planificación existente y sus detalles.
     */
    public function updatePlanificacion(int $planificacionId, array $data): bool
    {
        DB::beginTransaction();
        try {
            // --- SINCRONIZACIÓN DE BIBLIOGRAFÍAS ---
            $currentBibliografias = DB::table('detalle_bibliografia')
                ->where('planificacion_id', $planificacionId)
                ->where('estatus', 1)
                ->pluck('bibliografia_id')
                ->toArray();

            $newBibliografias = collect($data['bibliografias'])->pluck('bibliografia_id')->toArray();

            $toDeactivateBibliografias = array_diff($currentBibliografias, $newBibliografias);
            if (!empty($toDeactivateBibliografias)) {
                DB::table('detalle_bibliografia')
                    ->where('planificacion_id', $planificacionId)
                    ->whereIn('bibliografia_id', $toDeactivateBibliografias)
                    ->update(['estatus' => 2]);
            }

            foreach ($newBibliografias as $bibliografiaId) {
                $existing = DB::table('detalle_bibliografia')
                    ->where('planificacion_id', $planificacionId)
                    ->where('bibliografia_id', $bibliografiaId)
                    ->first();

                if ($existing) {
                    if ($existing->estatus == 2) {
                        DB::table('detalle_bibliografia')
                            ->where('planificacion_id', $planificacionId)
                            ->where('bibliografia_id', $bibliografiaId)
                            ->update(['estatus' => 1]);
                    }
                } else {
                    DB::table('detalle_bibliografia')->insert([
                        'planificacion_id' => $planificacionId,
                        'bibliografia_id' => $bibliografiaId,
                        'estatus' => 1,
                        'fecha_creacion' => now(),
                    ]);
                }
            }


            // --- SINCRONIZACIÓN DE CORTES (detalle_actividad) ---
            $oldActiveCortes = DB::table('detalle_planificacion as dp')
                ->join('detalle_actividad as da', 'dp.detalle_id', '=', 'da.detalle_id')
                ->where('dp.planificacion_id', $planificacionId)
                ->whereIn('da.estatus', [1, 3])
                ->select('da.detalle_id', 'da.corte', 'da.objetivo', 'da.contenido', 'da.estatus')
                ->get()
                ->keyBy('detalle_id');

            $newCortes = collect($data['cortes']);
            $processedOldCorteIds = [];

            foreach ($newCortes as $corteData) {
                $corteNumero = $corteData['numero'];
                $foundOldCorte = null;

                foreach ($oldActiveCortes as $oldCorte) {
                    if ($oldCorte->corte == $corteNumero && $oldCorte->estatus != 3) {
                        $foundOldCorte = $oldCorte;
                        break;
                    }
                }

                $detalleId = null;
                if ($foundOldCorte) {
                    $detalleId = $foundOldCorte->detalle_id;
                    $processedOldCorteIds[] = $detalleId;

                    DB::table('detalle_actividad')
                        ->where('detalle_id', $detalleId)
                        ->update([
                            'objetivo' => $corteData['objetivo'],
                            'contenido' => $corteData['contenido'],
                            'estatus' => 2,
                        ]);

                    DB::table('detalle_planificacion')
                        ->where('planificacion_id', $planificacionId)
                        ->where('detalle_id', $detalleId)
                        ->update(['estatus' => 1]);

                    DB::table('motivos_rechazo')
                        ->where('detalle_id', $detalleId)
                        ->where('estatus', 1)
                        ->update(['estatus' => 2]);
                } else {
                    $detalleId = DB::table('detalle_actividad')->insertGetId([
                        'corte' => $corteData['numero'],
                        'objetivo' => $corteData['objetivo'],
                        'contenido' => $corteData['contenido'],
                        'estatus' => 2,
                        'fecha_creacion' => now(),
                    ]);

                    DB::table('detalle_planificacion')->insert([
                        'planificacion_id' => $planificacionId,
                        'detalle_id' => $detalleId,
                        'estatus' => 1,
                        'fecha_creacion' => now(),
                    ]);
                }

                $this->syncCorteDetails('detalle_recursos', 'recurso_id', $detalleId, $corteData['recursos'], 'recurso_id');
                $this->syncCorteDetails('detalle_estrategias', 'estrategia_id', $detalleId, $corteData['estrategias'], 'estrategia_id');
                $this->syncCorteDetails('detalle_evaluacion', 'evaluacion_id', $detalleId, $corteData['evaluaciones'], 'evaluacion_id', ['tecnica_id', 'ponderacion', 'fecha_evaluacion', 'forma_participacion']);

                $currentContenidos = DB::table('detalle_contenidos')
                    ->where('detalle_id', $detalleId)
                    ->where('estatus', 1)
                    ->pluck('contenido_id')
                    ->toArray();
                $newContenidosIds = collect($corteData['contenidos'])->pluck('contenido_id')->toArray();

                $toDeactivateContenidos = array_diff($currentContenidos, $newContenidosIds);
                if (!empty($toDeactivateContenidos)) {
                    DB::table('detalle_contenidos')
                        ->where('detalle_id', $detalleId)
                        ->whereIn('contenido_id', $toDeactivateContenidos)
                        ->update(['estatus' => 2]);
                }

                foreach ($corteData['contenidos'] as $contenido) {
                    $contenidoId = $contenido['contenido_id'];
                    $existingContenido = DB::table('detalle_contenidos')
                        ->where('detalle_id', $detalleId)
                        ->where('contenido_id', $contenidoId)
                        ->first();

                    if ($existingContenido) {
                        if ($existingContenido->estatus == 2) {
                            DB::table('detalle_contenidos')
                                ->where('detalle_id', $detalleId)
                                ->where('contenido_id', $contenidoId)
                                ->update(['estatus' => 1]);
                        }
                    } else {
                        DB::table('detalle_contenidos')->insert([
                            'detalle_id' => $detalleId,
                            'contenido_id' => $contenidoId,
                            'estatus' => 1,
                            'fecha_creacion' => now(),
                        ]);
                    }

                    $this->syncContenidoIndicadores($contenidoId, $contenido['indicadores_logros']);
                }
            }

            foreach ($oldActiveCortes as $oldCorteId => $oldCorteData) {
                if (!in_array($oldCorteId, $processedOldCorteIds)) {
                    $hasActiveRejectionMotivo = DB::table('motivos_rechazo')
                        ->where('detalle_id', $oldCorteId)
                        ->where('estatus', 1)
                        ->exists();

                    if ($oldCorteData->estatus == 3 && $hasActiveRejectionMotivo) {
                        DB::table('detalle_actividad')
                            ->where('detalle_id', $oldCorteId)
                            ->update(['estatus' => 3]);

                        DB::table('motivos_rechazo')
                            ->where('detalle_id', $oldCorteId)
                            ->where('estatus', 1)
                            ->update(['estatus' => 2]);
                    } else {
                        DB::table('detalle_actividad')
                            ->where('detalle_id', $oldCorteId)
                            ->update(['estatus' => 2]);
                    }
                    DB::table('detalle_planificacion')
                        ->where('detalle_id', $oldCorteId)
                        ->where('planificacion_id', $planificacionId)
                        ->update(['estatus' => 2]);
                }
            }

            DB::table('planificacion')
                ->where('planificacion_id', $planificacionId)
                ->whereIn('estatus', [1, 3])
                ->update(['estatus' => 2]);

            DB::commit();
            return true;
        } catch (\Exception $e) {
            DB::rollBack();
            Log::error("Error al actualizar planificación: " . $e->getMessage());
            return false;
        }
    }

    private function syncCorteDetails(string $tableName, string $foreignIdColumn, int $detalleId, array $newData, string $newIdKey, array $additionalColumns = [])
    {
        $currentIds = DB::table($tableName)
            ->where('detalle_id', $detalleId)
            ->where('estatus', 1)
            ->pluck($foreignIdColumn)
            ->toArray();

        $newIds = collect($newData)->pluck($newIdKey)->toArray();

        $toDeactivate = array_diff($currentIds, $newIds);
        if (!empty($toDeactivate)) {
            DB::table($tableName)
                ->where('detalle_id', $detalleId)
                ->whereIn($foreignIdColumn, $toDeactivate)
                ->update(['estatus' => 2]);
        }

        foreach ($newData as $item) {
            $itemId = $item[$newIdKey];
            if (empty($itemId))
                continue;

            $existing = DB::table($tableName)
                ->where('detalle_id', $detalleId)
                ->where($foreignIdColumn, $itemId)
                ->first();

            $insertData = [
                'detalle_id' => $detalleId,
                $foreignIdColumn => $itemId,
                'estatus' => 1,
            ];

            foreach ($additionalColumns as $col) {
                if (isset($item[$col])) {
                    $insertData[$col] = $item[$col];
                }
            }

            if ($existing) {
                if ($existing->estatus == 2) {
                    DB::table($tableName)
                        ->where('detalle_id', $detalleId)
                        ->where($foreignIdColumn, $itemId)
                        ->update($insertData);
                } else {
                    $updateOnlyAdditional = false;
                    foreach ($additionalColumns as $col) {
                        if (isset($item[$col]) && $existing->$col != $item[$col]) {
                            $updateOnlyAdditional = true;
                            break;
                        }
                    }
                    if ($updateOnlyAdditional) {
                        $updateData = [];
                        foreach ($additionalColumns as $col) {
                            if (isset($item[$col])) {
                                $updateData[$col] = $item[$col];
                            }
                        }
                        DB::table($tableName)
                            ->where('detalle_id', $detalleId)
                            ->where($foreignIdColumn, $itemId)
                            ->update($updateData);
                    }
                }
            } else {
                $insertData['fecha_creacion'] = now();
                DB::table($tableName)->insert($insertData);
            }
        }
    }

    private function syncContenidoIndicadores(int $contenidoId, array $newIndicadores)
    {
        $currentIndicadoresIds = DB::table('contenido_indicadores')
            ->where('contenido_id', $contenidoId)
            ->where('estatus', 1)
            ->pluck('indicador_id')
            ->toArray();

        $newIndicadoresIds = collect($newIndicadores)->pluck('indicador_id')->toArray();

        $toDeactivate = array_diff($currentIndicadoresIds, $newIndicadoresIds);
        if (!empty($toDeactivate)) {
            DB::table('contenido_indicadores')
                ->where('contenido_id', $contenidoId)
                ->whereIn('indicador_id', $toDeactivate)
                ->update(['estatus' => 2]);
        }

        foreach ($newIndicadoresIds as $indicadorId) {
            if (empty($indicadorId))
                continue;

            $existing = DB::table('contenido_indicadores')
                ->where('contenido_id', $contenidoId)
                ->where('indicador_id', $indicadorId)
                ->first();

            if ($existing) {
                if ($existing->estatus == 2) {
                    DB::table('contenido_indicadores')
                        ->where('contenido_id', $contenidoId)
                        ->where('indicador_id', $indicadorId)
                        ->update(['estatus' => 1]); // Activo
                }
            } else {
                DB::table('contenido_indicadores')->insert([
                    'contenido_id' => $contenidoId,
                    'indicador_id' => $indicadorId,
                    'estatus' => 1,
                    'fecha_creacion' => now(),
                ]);
            }
        }
    }
}
