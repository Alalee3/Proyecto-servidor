<?php

namespace App\Repositories\Planificacion;

use Illuminate\Support\{Facades\DB, Facades\Log};

class PlanificacionViewRepo
{
    /**
     * Obtiene todos los detalles de una planificación específica.
     */
    public function getDetallesPlanificacion(int $planificacionId): ?array
    {
        $planificacion = DB::table('planificacion as p')
            ->select(
                'p.planificacion_id',
                'p.estatus',
                'u.id as docente_id',
                'u.name as docente_nombre',
                'u.apellido as docente_apellido',
                'u.cedula',
                'u.telefono'
            )
            ->join('users as u', 'p.docente_id', '=', 'u.id')
            ->where('p.planificacion_id', $planificacionId)
            ->first();

        if (!$planificacion) {
            return null;
        }

        $resultado = (array) $planificacion;

        $resultado['bibliografias'] = DB::table('detalle_bibliografia as db')
            ->join('bibliografias as b', 'db.bibliografia_id', '=', 'b.bibliografia_id')
            ->where('db.planificacion_id', $planificacionId)
            ->where('db.estatus', 1)
            ->select('b.bibliografia_id', 'b.bibliografia')
            ->get()
            ->map(fn($item) => (array) $item)
            ->toArray();

        $resultado['cortes'] = DB::table('detalle_actividad as da')
            ->join('detalle_planificacion as dp', 'da.detalle_id', '=', 'dp.detalle_id')
            ->where('dp.planificacion_id', $planificacionId)
            ->select('da.detalle_id', 'da.corte', 'da.estatus')
            ->orderBy('da.corte')
            ->get()
            ->map(function ($corte) {
                $corteArray = (array) $corte;

                $ultimoMotivoRechazo = DB::table('motivos_rechazo')
                    ->where('motivos_rechazo.detalle_id', $corte->detalle_id)
                    ->orderBy('motivos_rechazo.fecha_creacion', 'desc')
                    ->select('motivos_rechazo.motivo')
                    ->where('motivos_rechazo.estatus', 1)
                    ->first();

                $corteArray['ultimo_motivo_rechazo'] = $ultimoMotivoRechazo ? $ultimoMotivoRechazo->motivo : null;

                $corteArray['recursos'] = DB::table('detalle_recursos as dr')
                    ->join('recursos as r', 'dr.recurso_id', '=', 'r.recurso_id')
                    ->where('dr.detalle_id', $corte->detalle_id)
                    ->where('dr.estatus', 1)
                    ->select('r.recurso_id', 'r.recurso')
                    ->get()
                    ->map(fn($item) => (array) $item)
                    ->toArray();

                $corteArray['estrategias'] = DB::table('detalle_estrategias as de')
                    ->join('estrategias_pedagogicas as e', 'de.estrategia_id', '=', 'e.estrategia_id')
                    ->where('de.detalle_id', $corte->detalle_id)
                    ->where('de.estatus', 1)
                    ->select('e.estrategia_id', 'e.estrategia')
                    ->get()
                    ->map(fn($item) => (array) $item)
                    ->toArray();

                $corteArray['contenidos'] = DB::table('detalle_contenidos as dc')
                    ->join('contenidos as c', 'dc.contenido_id', '=', 'c.contenido_id')
                    ->where('dc.detalle_id', $corte->detalle_id)
                    ->where('dc.estatus', 1)
                    ->select('c.contenido_id', 'dc.detalle_contenido_id', 'c.titulo as titulo_contenido', 'c.descripcion as descripcion_contenido')
                    ->get()
                    ->map(function ($contenido) {
                        $contenidoArray = (array) $contenido;
                        $indicadores = DB::table('contenido_indicadores as ci')
                            ->join('indicadores_logros as il', 'ci.indicador_id', '=', 'il.indicador_id')
                            ->where('ci.detalle_contenido_id', $contenido->detalle_contenido_id)
                            ->where('ci.estatus', 1)
                            ->select('il.indicador_id', 'il.indicador as descripcion_indicador')
                            ->get()
                            ->map(fn($item) => (array) $item)
                            ->toArray();

                        $contenidoArray['indicadores_logros'] = array_values(array_unique($indicadores, SORT_REGULAR));
                        return $contenidoArray;
                    })
                    ->toArray();

                $corteArray['evaluaciones'] = DB::table('detalle_evaluacion as dev')
                    ->leftJoin('evaluaciones as eva', 'dev.evaluacion_id', '=', 'eva.evaluacion_id')
                    ->leftJoin('tecnicas as tec', 'dev.tecnica_id', '=', 'tec.tecnica_id')
                    ->where('dev.detalle_id', $corte->detalle_id)
                    ->where('dev.estatus', 1)
                    ->select(
                        'dev.evaluacion_id',
                        'eva.evaluacion',
                        'dev.tecnica_id',
                        'tec.tecnica',
                        'dev.ponderacion',
                        'dev.fecha_evaluacion',
                        'dev.forma_participacion'
                    )
                    ->get()
                    ->map(fn($item) => (array) $item)
                    ->toArray();

                return $corteArray;
            })
            ->toArray();

        $coordinador = DB::table('users as u')
            ->join('usuario_rol as ur', 'u.id', '=', 'ur.id_users')
            ->where('ur.id_rol', 1)
            ->select('u.name', 'u.apellido', 'u.cedula')
            ->first();

        if ($coordinador) {
            $resultado['coordinador_nombre'] = $coordinador->name;
            $resultado['coordinador_apellido'] = $coordinador->apellido;
            $resultado['coordinador_cedula'] = $coordinador->cedula;
        } else {
            $resultado['coordinador_nombre'] = $resultado['coordinador_apellido'] = $resultado['coordinador_cedula'] = '';
        }

        return $resultado;
    }
}
