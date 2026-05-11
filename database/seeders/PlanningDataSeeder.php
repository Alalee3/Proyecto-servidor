<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class PlanningDataSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // --- 1. RECURSOS EDUCATIVOS ---
        $recursos = [
            ['nombre_recurso' => 'Video Beam / Proyector'],
            ['nombre_recurso' => 'Pizarra Acrílica y Marcadores'],
            ['nombre_recurso' => 'Laboratorio de Computación'],
            ['nombre_recurso' => 'Plataforma Moodle / Aula Virtual'],
            ['nombre_recurso' => 'Internet / Conexión Wi-Fi'],
            ['nombre_recurso' => 'Material Impreso (Guías/Libros)'],
            ['nombre_recurso' => 'Software Especializado (IDE/Simuladores)'],
            ['nombre_recurso' => 'Infografías y Mapas Mentales'],
            ['nombre_recurso' => 'Laptops / Tablets'],
            ['nombre_recurso' => 'Videos Educativos / YouTube'],
        ];
        foreach ($recursos as $r) {
            DB::table('recurso')->updateOrInsert(['nombre_recurso' => $r['nombre_recurso']], $r);
        }

        // --- 2. ESTRATEGIAS PEDAGÓGICAS (tecnica_actividad) ---
        $estrategias = [
            ['nombre_tecnica_actividad' => 'Aprendizaje Basado en Proyectos (ABP)'],
            ['nombre_tecnica_actividad' => 'Clase Magistral Participativa'],
            ['nombre_tecnica_actividad' => 'Debate y Discusión Dirigida'],
            ['nombre_tecnica_actividad' => 'Resolución de Problemas / Algoritmos'],
            ['nombre_tecnica_actividad' => 'Estudio de Casos Reales'],
            ['nombre_tecnica_actividad' => 'Aula Invertida (Flipped Classroom)'],
            ['nombre_tecnica_actividad' => 'Gamificación Educativa'],
            ['nombre_tecnica_actividad' => 'Aprendizaje Cooperativo'],
        ];
        foreach ($estrategias as $e) {
            DB::table('tecnica_actividad')->updateOrInsert(['nombre_tecnica_actividad' => $e['nombre_tecnica_actividad']], $e);
        }

        // --- 3. TÉCNICAS DE EVALUACIÓN ---
        $tecnicasEval = [
            ['nombre_tecnica_evaluacion' => 'Observación Directa'],
            ['nombre_tecnica_evaluacion' => 'Análisis de Producción Escrita'],
            ['nombre_tecnica_evaluacion' => 'Exposición Oral'],
            ['nombre_tecnica_evaluacion' => 'Prueba Práctica en Computador'],
            ['nombre_tecnica_evaluacion' => 'Portafolio de Evidencias'],
            ['nombre_tecnica_evaluacion' => 'Defensa de Proyecto'],
            ['nombre_tecnica_evaluacion' => 'Cuestionario / Examen'],
            ['nombre_tecnica_evaluacion' => 'Rúbricas de Evaluación'],
            ['nombre_tecnica_evaluacion' => 'Mapa Mental / Conceptual'],
        ];
        foreach ($tecnicasEval as $te) {
            DB::table('tecnica_evaluacion')->updateOrInsert(['nombre_tecnica_evaluacion' => $te['nombre_tecnica_evaluacion']], $te);
        }

        // --- 4. INSTRUMENTOS DE EVALUACIÓN ---
        $instrumentos = [
            ['nombre_instrumento' => 'Escala de Estimación'],
            ['nombre_instrumento' => 'Lista de Cotejo'],
            ['nombre_instrumento' => 'Rúbrica Holística'],
            ['nombre_instrumento' => 'Guía de Observación'],
            ['nombre_instrumento' => 'Prueba Objetiva'],
        ];
        foreach ($instrumentos as $inst) {
            DB::table('instrumento')->updateOrInsert(['nombre_instrumento' => $inst['nombre_instrumento']], $inst);
        }

        // --- 5. TIPOS DE EVALUACIÓN ---
        $tiposEval = [
            ['nombre_tipo_evaluacion' => 'Evaluación Diagnóstica'],
            ['nombre_tipo_evaluacion' => 'Evaluación Formativa'],
            ['nombre_tipo_evaluacion' => 'Evaluación Sumativa'],
            ['nombre_tipo_evaluacion' => 'Autoevaluación'],
            ['nombre_tipo_evaluacion' => 'Coevaluación'],
            ['nombre_tipo_evaluacion' => 'Heteroevaluación'],
        ];
        foreach ($tiposEval as $tve) {
            DB::table('tipo_evaluacion')->updateOrInsert(['nombre_tipo_evaluacion' => $tve['nombre_tipo_evaluacion']], $tve);
        }

        // --- 6. BIBLIOGRAFÍAS ---
        $bibliografias = [
            ['nombre_bibliografia' => 'Pressman, R. S. (2010). Ingeniería del software: un enfoque práctico.'],
            ['nombre_bibliografia' => 'Sommerville, I. (2011). Ingeniería de software.'],
            ['nombre_bibliografia' => 'Martin, R. C. (2008). Clean Code.'],
            ['nombre_bibliografia' => 'Tanenbaum, A. S. (2012). Redes de Computadoras.'],
        ];
        foreach ($bibliografias as $b) {
            DB::table('bibliografia')->updateOrInsert(['nombre_bibliografia' => $b['nombre_bibliografia']], $b);
        }

        // --- 7. TEMAS, OBJETIVOS Y CONTENIDOS (Para múltiples Unidades Curriculares) ---
        $materiasIds = ['1', '2', '3', '4', '5', '6']; // IDs detectados en SOGAC
        
        $unidadesMaster = [
            ['u' => '1', 't' => 'Unidad 1: Fundamentos y Evolución', 'objs' => [
                ['o' => 'Comprender los conceptos básicos y el ciclo de vida.', 'cont' => ['Definiciones', 'Modelos de Proceso']]
            ]],
            ['u' => '2', 't' => 'Unidad 2: Análisis y Requisitos', 'objs' => [
                ['o' => 'Identificar y documentar requisitos del sistema.', 'cont' => ['Elicitación', 'IEEE 830']]
            ]],
            ['u' => '3', 't' => 'Unidad 3: Diseño y Arquitectura', 'objs' => [
                ['o' => 'Aplicar patrones de diseño y modelado UML.', 'cont' => ['Diagramas de Clase', 'Patrones']]
            ]],
            ['u' => '4', 't' => 'Unidad 4: Calidad y Pruebas', 'objs' => [
                ['o' => 'Asegurar la calidad mediante pruebas sistemáticas.', 'cont' => ['Caja Blanca/Negra', 'SQA']]
            ]],
        ];

        foreach ($materiasIds as $materiaId) {
            foreach ($unidadesMaster as $uData) {
                // Tema
                DB::table('tema_unidad')->updateOrInsert(
                    ['titulo_tema' => $uData['t'] . " (Mat: $materiaId)"],
                    ['id_unidad_curricular' => $materiaId, 'unidad_tema' => $uData['u'], 'estatus' => '1']
                );
                $temaId = DB::table('tema_unidad')->where('titulo_tema', $uData['t'] . " (Mat: $materiaId)")->value('id_tema_unidad');

                foreach ($uData['objs'] as $objData) {
                    // Objetivo
                    DB::table('objetivo')->updateOrInsert(
                        ['titulo_objetivo' => $objData['o'] . " - T$temaId"],
                        ['id_tema_unidad' => $temaId, 'estatus' => '1']
                    );
                    $objId = DB::table('objetivo')->where('titulo_objetivo', $objData['o'] . " - T$temaId")->value('id_objetivo');

                    foreach ($objData['cont'] as $contTxt) {
                        // Contenido
                        DB::table('contenido')->updateOrInsert(
                            ['titulo_contenido' => $contTxt],
                            ['estatus' => '1']
                        );
                        $contId = DB::table('contenido')->where('titulo_contenido', $contTxt)->value('id_contenido');

                        // Relación
                        DB::table('detalle_objetivo')->updateOrInsert(
                            ['id_contenido' => $contId, 'id_objetivo' => $objId],
                            ['estatus' => '1']
                        );
                    }
                }
            }
        }

        // --- 8. PERMISOS DEL SISTEMA ---
        $permisos = [
            ['nombre_permiso' => 'Listar de Planificacion'],
            ['nombre_permiso' => 'Crear de Planificacion'],
            ['nombre_permiso' => 'Editar de Planificacion'],
            ['nombre_permiso' => 'Ver Detalles de Planificacion'],
            ['nombre_permiso' => 'Aprobar Planificaciones'],
            ['nombre_permiso' => 'Configurar Calendario'],
            ['nombre_permiso' => 'Ver Bitacora'],
            ['nombre_permiso' => 'Gestionar Catalogos'],
        ];
        foreach ($permisos as $p) {
            DB::table('permiso')->updateOrInsert(['nombre_permiso' => $p['nombre_permiso']], $p);
        }
    }
}