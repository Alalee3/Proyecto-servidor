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

    public function select_tecnicas()
    {
        return $this->select_tabla('tecnicas', 'tecnica_id', 'tecnica', [['estatus', 1]]);
    }

    public function select_recursos()
    {
        return $this->select_tabla('recursos', 'recurso_id', 'recurso', [['estatus', 1]]);
    }

    public function select_estrategias()
    {
        return $this->select_tabla('estrategias_pedagogicas', 'estrategia_id', 'estrategia', [['estatus', 1]]);
    }

    public function select_evaluaciones()
    {
        return $this->select_tabla('evaluaciones', 'evaluacion_id', 'evaluacion', [['estatus', 1]]);
    }

    public function select_indicadores()
    {
        return $this->select_tabla('indicadores_logros', 'indicador_id', 'indicador', [['estatus', 1]]);
    }

    public function select_bibliografias()
    {
        return $this->select_tabla('bibliografias', 'bibliografia_id', 'bibliografia', [['estatus', 1]]);
    }

    public function select_contenidos($unidadCodigo = null)
    {
        $conditions = [['estatus', 1]];
        if ($unidadCodigo) {
            $conditions[] = ['unidad_codigo', $unidadCodigo];
        }

        return $this->select_tabla('contenidos', 'contenido_id', 'titulo', $conditions, 'titulo');
    }

    public function select_secciones()
    {
        return $this->select_tabla('secciones', 'seccion_id', 'seccion', [['estatus', 1]]);
    }

    public function select_unidades_curriculares()
    {
        return DB::table('unidades_curriculares as uc')
            ->join('pnfs as p', 'uc.pnf_id', '=', 'p.pnf_id')
            ->select('uc.*', 'p.nombre as pnf_nombre')
            ->where('uc.estatus', 1)
            ->get();
    }

    public function create($tableName, $data)
    {
        try {
            return DB::table($tableName)->insertGetId($data);
        } catch (\Exception $e) {
            Log::error("Error al insertar en {$tableName}: {$e->getMessage()}");
            throw $e;
        }
    }

    public function adjuntar($tabla, $campo1, $valor1, $campo2, $valor2, $datosAdicionales = [])
    {
        $insercion = [$campo1 => $valor1, $campo2 => $valor2];

        if (!empty($datosAdicionales)) {
            $insercion = array_merge($insercion, $datosAdicionales);
        }

        try {
            DB::table($tabla)->insert($insercion);
            return true;
        } catch (\Exception $e) {
            Log::error("Error al adjuntar en {$tabla}: {$e->getMessage()}");
            throw $e;
        }
    }
}
