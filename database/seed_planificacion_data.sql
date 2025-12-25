-- Script de Generación de Datos de Prueba para SAUPA
-- Genera un registro de cada dependencia necesaria para crear una Planificación

START TRANSACTION;

-- 1. Lapso Académico
INSERT INTO `lapso_academico` (`nombre_lapso_academico`, `fecha_inicio_lapso_academico`, `fecha_fin_lapso_academico`, `fecha_creacion`, `estatus`)
VALUES ('Lapso 2025-I', '2025-01-01', '2025-06-30', NOW(), '1');
SET @id_lapso = LAST_INSERT_ID();

-- 2. PNF
INSERT INTO `pnf` (`nombre_pnf`, `fecha_creacion`, `estatus`)
VALUES ('PNF Prueba Ingeniería', NOW(), '1');
SET @id_pnf = LAST_INSERT_ID();

-- 3. Malla Académica
INSERT INTO `malla_academica` (`id_pnf`, `nombre_malla_academica`, `fecha_creacion`, `estatus`)
VALUES (@id_pnf, 'Malla 2025', NOW(), '1');
SET @id_malla = LAST_INSERT_ID();

-- 4. Unidad Curricular
INSERT INTO `unidad_curricular` (
    `nombre_unidad_curricular`, 
    `id_malla_academica`, 
    `trayecto_unidad_curricular`, 
    `duracion_unidad_curricular`, 
    `tipo_unidad_curricular`, 
    `proposito_unidad_curricular`, 
    `unidades_credito_unidad_curricular`, 
    `horas_semanales_unidad_curricular`, 
    `fecha_creacion`, 
    `estatus`
)
VALUES (
    'Programación Avanzada', 
    @id_malla, 
    '1', -- Trayecto
    12,  -- Duración (semanas?)
    '1', -- Tipo (Obligatoria?)
    'Aprender técnicas avanzadas de desarrollo.', 
    '3', -- UC
    '4', -- Horas semanales
    NOW(), 
    '1'
);
SET @id_uc = LAST_INSERT_ID();

-- 5. Sección
INSERT INTO `seccion` (`nombre_seccion`, `id_lapso_academico`, `fecha_creacion`, `estatus`)
VALUES ('A01', @id_lapso, NOW(), '1');
SET @id_seccion = LAST_INSERT_ID();

-- 6. Detalle Profesor Asignado (Asumiendo Usuario ID 1 'Nasser J.' existe, si no, usar NULL o crear uno)
-- Primero verificamos si existe el usuario 1, si no, usamos un fallback (esto es difícil en script puro sin lógica, asumimos ID 1 dado el dump)
SET @id_user = 1; 

INSERT INTO `detalle_profesor_asignado` (`id_unidad_curricular`, `id_users`, `id_seccion`, `fecha_creacion`, `estatus`)
VALUES (@id_uc, @id_user, @id_seccion, NOW(), '1');
SET @id_prof_asignado = LAST_INSERT_ID();

-- 7. Contenido
INSERT INTO `contenido` (`id_unidad_curricular`, `titulo_contenido`, `descripcion_contenido`, `corte_contenido`, `fecha_creacion`, `estatus`)
VALUES (@id_uc, 'Introducción a Algoritmos', 'Conceptos básicos y avanzados.', '1', NOW(), '1');
SET @id_contenido = LAST_INSERT_ID();

-- 8. Tema
INSERT INTO `tema` (`titulo_tema`, `descripcion_tema`, `id_contenido`, `fecha_creacion`, `estatus`)
VALUES ('Complejidad Algorítmica', 'Big O, Omega, Theta', @id_contenido, NOW(), '1');
SET @id_tema = LAST_INSERT_ID();

-- 9. Recurso
INSERT INTO `recurso` (`nombre_recurso`, `fecha_creacion`, `estatus`)
VALUES ('Video Beam', NOW(), '1');

-- 10. Estrategia Pedagógica
INSERT INTO `estrategia_pedagogica` (`nombre_estrategia_pedagogica`, `fecha_creacion`, `estatus`)
VALUES ('Aprendizaje Basado en Proyectos', NOW(), '1');

-- 11. Técnica de Evaluación
INSERT INTO `tecnica` (`nombre_tecnica`, `fecha_creacion`, `estatus`)
VALUES ('Prueba Escrita', NOW(), '1');

-- 12. Bibliografía
INSERT INTO `bibliografia` (`nombre_bibliografia`, `fecha_creacion`, `estatus`)
VALUES ('Clean Code - Robert C. Martin', NOW(), '1');

-- 13. Indicador de Logro
INSERT INTO `indicador_logro` (`nombre_indicador_logro`, `fecha_creacion`, `estatus`)
VALUES ('Domina la sintaxis básica', NOW(), '1');

-- 14. Evaluación
INSERT INTO `evaluacion` (`nombre_evaluacion`, `fecha_creacion`, `estatus`)
VALUES ('Parcial 1', NOW(), '1');

COMMIT;

SELECT * FROM `detalle_profesor_asignado` WHERE `id_detalle_profesor_asignado` = @id_prof_asignado;
