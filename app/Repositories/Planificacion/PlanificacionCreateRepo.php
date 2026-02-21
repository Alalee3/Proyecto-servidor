<?php

namespace App\Repositories\Planificacion;

use Illuminate\Support\{Facades\DB, Facades\Log, Facades\Auth};

class PlanificacionCreateRepo
{
    public function select_tabla($tableName, $idColumnName, $displayColumnName, $whereConditions = [], $orderByColumn = null, $orderByDirection = 'asc')
    {
        try {
            $query = DB::table($tableName)->select($idColumnName, $displayColumnName);

            foreach ($whereConditions as $condition) {
                $query->where(...$condition);
            }

            return $orderByColumn ? $query->orderBy($orderByColumn, $orderByDirection)->get() : $query->get();
        } catch (\Exception $e) {
            Log::error("Error en select_tabla para {$tableName}: {$e->getMessage()}");
            throw $e;
        }
    }

    public function select_tecnica()
    {
        return $this->select_tabla('tecnica_evaluacion', 'id_tecnica', 'nombre_tecnica_evaluacion', [['estatus', '1']]);
    }

    public function select_tecnica_actividad()
    {
        return $this->select_tabla('tecnica_actividad', 'id_tecnica_actividad', 'nombre_tecnica_actividad', [['estatus', '1']]);
    }

    public function select_recursos()
    {
        return $this->select_tabla('recurso', 'id_recurso', 'nombre_recurso', [['estatus', '1']]);
    }


    public function select_evaluaciones()
    {
        return $this->select_tabla('evaluacion', 'id_evaluacion', 'nombre_evaluacion', [['estatus', '1']]);
    }

    public function select_bibliografias()
    {
        return $this->select_tabla('bibliografia', 'id_bibliografia', 'nombre_bibliografia', [['estatus', '1']]);
    }

    public function select_temas_por_unidad($idUnidadCurricular = null)
    {
        $query = DB::table('tema_unidad')
            ->where('estatus', '1');

        if ($idUnidadCurricular) {
            $query->where('id_unidad_curricular', $idUnidadCurricular);
        }

        return $query->select('id_tema_unidad', 'titulo_tema', 'unidad_tema')
            ->orderBy('id_tema_unidad')
            ->get();
    }

    public function select_contenidos($idUnidadCurricular = null)
    {
        $query = DB::table('contenido as c')
            ->join('objetivo as o', 'c.id_objetivo', '=', 'o.id_objetivo')
            ->join('tema_unidad as t', 'o.id_tema_unidad', '=', 't.id_tema_unidad')
            ->where('c.estatus', '1')
            ->where('t.estatus', '1');

        if ($idUnidadCurricular) {
            $query->where('t.id_unidad_curricular', $idUnidadCurricular);
        }

        return $query->select(
            'c.id_contenido',
            'c.titulo_contenido',
            'c.id_objetivo',
            'o.id_tema_unidad',
            't.unidad_tema'
        )
            ->orderBy('c.id_contenido')
            ->get();
    }

    public function select_objetivos($idUnidadCurricular = null)
    {
        $query = DB::table('objetivo as o')
            ->join('tema_unidad as t', 'o.id_tema_unidad', '=', 't.id_tema_unidad')
            ->where('o.estatus', '1')
            ->where('t.estatus', '1');

        if ($idUnidadCurricular) {
            $query->where('t.id_unidad_curricular', $idUnidadCurricular);
        }

        return $query->select(
            'o.id_objetivo',
            'o.titulo_objetivo',
            'o.id_tema_unidad',
            't.unidad_tema'
        )
            ->orderBy('o.id_objetivo')
            ->get();
    }

    // Nueva función vital: Obtener las asignaciones del docente logueado
    public function getAsignacionesDocente($userId = null)
    {
        $query = DB::table('detalle_profesor_asignado as dpa')
            ->join('unidad_curricular as uc', 'dpa.id_unidad_curricular', '=', 'uc.id_unidad_curricular')
            ->join('seccion as s', 'dpa.id_seccion', '=', 's.id_seccion')
            ->join('users as u', 'dpa.id_users', '=', 'u.id')
            ->where('dpa.estatus', '1');

        if ($userId) {
            $query->where('dpa.id_users', $userId);
        }

        return $query->select(
                'dpa.id_detalle_profesor_asignado',
                'uc.nombre_unidad_curricular',
                'uc.trayecto_unidad_curricular',
                's.nombre_seccion',
                'u.name',
                'u.apellido'
            )
            ->get()
            ->map(function ($asignacion) {
                $trayecto = $asignacion->trayecto_unidad_curricular ? "T{$asignacion->trayecto_unidad_curricular}" : 'S/T';
                $docente = "{$asignacion->name} {$asignacion->apellido}";
                $asignacion->descripcion_completa = "{$asignacion->nombre_unidad_curricular} ({$trayecto}) - Sección {$asignacion->nombre_seccion} | Docente: {$docente}";
                return $asignacion;
            });
    }
}
