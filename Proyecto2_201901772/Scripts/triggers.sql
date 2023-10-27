USE SISTEMA_CONTROL_FIUSAC;
# -------------------------------------------- TABLA ACTA -----------------------------------------------------------
DROP TRIGGER IF EXISTS insertActa;
DELIMITER $$
CREATE TRIGGER insertActa AFTER INSERT ON ACTA
FOR EACH ROW
BEGIN
    INSERT INTO HISTORIAL_TRANSACCIONES
        (descripcion, tipo)
    VALUES
        ('Se ha realizado una acción en la tabla ACTA', 'INSERT');
END;
$$
DELIMITER ;

DROP TRIGGER IF EXISTS updateActa;
DELIMITER $$
CREATE TRIGGER updateActa AFTER UPDATE ON ACTA
FOR EACH ROW
BEGIN
    INSERT INTO HISTORIAL_TRANSACCIONES
        (descripcion, tipo)
    VALUES
        ('Se ha realizado una acción en la tabla ACTA', 'UPDATE');
END;
$$
DELIMITER ;

DROP TRIGGER IF EXISTS deleteActa;
DELIMITER $$
CREATE TRIGGER deleteActa AFTER DELETE ON ACTA
FOR EACH ROW
BEGIN
    INSERT INTO HISTORIAL_TRANSACCIONES
        (descripcion, tipo)
    VALUES
        ('Se ha realizado una acción en la tabla ACTA', 'DELETE');
END;
$$
DELIMITER ;

# -------------------------------------------- TABLA ASIGNACION_CURSO ------------------------------------------------
DROP TRIGGER IF EXISTS insertAsignacionCurso;
DELIMITER $$
CREATE TRIGGER insertAsignacionCurso AFTER INSERT ON ASIGNACION_CURSO
FOR EACH ROW
BEGIN
    INSERT INTO HISTORIAL_TRANSACCIONES
        (descripcion, tipo)
    VALUES
        ('Se ha realizado una acción en la tabla ASIGNACION_CURSO', 'INSERT');
END;
$$
DELIMITER ;

DROP TRIGGER IF EXISTS updateAsignacionCurso;
DELIMITER $$
CREATE TRIGGER updateAsignacionCurso AFTER UPDATE ON ASIGNACION_CURSO
FOR EACH ROW
BEGIN
    INSERT INTO HISTORIAL_TRANSACCIONES
        (descripcion, tipo)
    VALUES
        ('Se ha realizado una acción en la tabla ASIGNACION_CURSO', 'UPDATE');
END;
$$
DELIMITER ;

DROP TRIGGER IF EXISTS deleteAsignacionCurso;
DELIMITER $$
CREATE TRIGGER deleteAsignacionCurso AFTER DELETE ON ASIGNACION_CURSO
FOR EACH ROW
BEGIN
    INSERT INTO HISTORIAL_TRANSACCIONES
        (descripcion, tipo)
    VALUES
        ('Se ha realizado una acción en la tabla ASIGNACION_CURSO', 'DELETE');
END;
$$
DELIMITER ;

# -------------------------------------------- TABLA ASIGNADOS_CURSO_HABILITADO --------------------------------------
DROP TRIGGER IF EXISTS insertAsignadosCursoHabilitado;
DELIMITER $$
CREATE TRIGGER insertAsignadosCursoHabilitado AFTER INSERT ON ASIGNADOS_CURSO_HABILITADO
FOR EACH ROW
BEGIN
    INSERT INTO HISTORIAL_TRANSACCIONES
        (descripcion, tipo)
    VALUES
        ('Se ha realizado una acción en la tabla ASIGNADOS_CURSO_HABILITADO', 'INSERT');
END;
$$
DELIMITER ;

DROP TRIGGER IF EXISTS updateAsignadosCursoHabilitado;
DELIMITER $$
CREATE TRIGGER updateAsignadosCursoHabilitado AFTER UPDATE ON ASIGNADOS_CURSO_HABILITADO
FOR EACH ROW
BEGIN
    INSERT INTO HISTORIAL_TRANSACCIONES
        (descripcion, tipo)
    VALUES
        ('Se ha realizado una acción en la tabla ASIGNADOS_CURSO_HABILITADO', 'UPDATE');
END;
$$
DELIMITER ;

DROP TRIGGER IF EXISTS deleteAsignadosCursoHabilitado;
DELIMITER $$
CREATE TRIGGER deleteAsignadosCursoHabilitado AFTER DELETE ON ASIGNADOS_CURSO_HABILITADO
FOR EACH ROW
BEGIN
    INSERT INTO HISTORIAL_TRANSACCIONES
        (descripcion, tipo)
    VALUES
        ('Se ha realizado una acción en la tabla ASIGNADOS_CURSO_HABILITADO', 'DELETE');
END;
$$
DELIMITER ;

# -------------------------------------------- TABLA CARRERA ---------------------------------------------------------
DROP TRIGGER IF EXISTS insertCarrera;
DELIMITER $$
CREATE TRIGGER insertCarrera AFTER INSERT ON CARRERA
FOR EACH ROW
BEGIN
    INSERT INTO HISTORIAL_TRANSACCIONES
        (descripcion, tipo)
    VALUES
        ('Se ha realizado una acción en la tabla CARRERA', 'INSERT');
END;
$$
DELIMITER ;

DROP TRIGGER IF EXISTS updateCarrera;
DELIMITER $$
CREATE TRIGGER updateCarrera AFTER UPDATE ON CARRERA
FOR EACH ROW
BEGIN
    INSERT INTO HISTORIAL_TRANSACCIONES
        (descripcion, tipo)
    VALUES
        ('Se ha realizado una acción en la tabla CARRERA', 'UPDATE');
END;
$$
DELIMITER ;

DROP TRIGGER IF EXISTS deleteCarrera;
DELIMITER $$
CREATE TRIGGER deleteCarrera AFTER DELETE ON CARRERA
FOR EACH ROW
BEGIN
    INSERT INTO HISTORIAL_TRANSACCIONES
        (descripcion, tipo)
    VALUES
        ('Se ha realizado una acción en la tabla CARRERA', 'DELETE');
END;
$$
DELIMITER ;

# -------------------------------------------- TABLA CICLO -----------------------------------------------------------
DROP TRIGGER IF EXISTS insertCiclo;
DELIMITER $$
CREATE TRIGGER insertCiclo AFTER INSERT ON CICLO
FOR EACH ROW
BEGIN
    INSERT INTO HISTORIAL_TRANSACCIONES
        (descripcion, tipo)
    VALUES
        ('Se ha realizado una acción en la tabla CICLO', 'INSERT');
END;
$$
DELIMITER ;

DROP TRIGGER IF EXISTS updateCiclo;
DELIMITER $$
CREATE TRIGGER updateCiclo AFTER UPDATE ON CICLO
FOR EACH ROW
BEGIN
    INSERT INTO HISTORIAL_TRANSACCIONES
        (descripcion, tipo)
    VALUES
        ('Se ha realizado una acción en la tabla CICLO', 'UPDATE');
END;
$$
DELIMITER ;

DROP TRIGGER IF EXISTS deleteCiclo;
DELIMITER $$
CREATE TRIGGER deleteCiclo AFTER DELETE ON CICLO
FOR EACH ROW
BEGIN
    INSERT INTO HISTORIAL_TRANSACCIONES
        (descripcion, tipo)
    VALUES
        ('Se ha realizado una acción en la tabla CICLO', 'DELETE');
END;
$$
DELIMITER ;

# -------------------------------------------- TABLA CICLO_ANIO -------------------------------------------------------
DROP TRIGGER IF EXISTS insertCicloAnio;
DELIMITER $$
CREATE TRIGGER insertCicloAnio AFTER INSERT ON CICLO_ANIO
FOR EACH ROW
BEGIN
    INSERT INTO HISTORIAL_TRANSACCIONES
        (descripcion, tipo)
    VALUES
        ('Se ha realizado una acción en la tabla CICLO_ANIO', 'INSERT');
END;
$$
DELIMITER ;

DROP TRIGGER IF EXISTS updateCicloAnio;
DELIMITER $$
CREATE TRIGGER updateCicloAnio AFTER UPDATE ON CICLO_ANIO
FOR EACH ROW
BEGIN
    INSERT INTO HISTORIAL_TRANSACCIONES
        (descripcion, tipo)
    VALUES
        ('Se ha realizado una acción en la tabla CICLO_ANIO', 'UPDATE');
END;
$$
DELIMITER ;

DROP TRIGGER IF EXISTS deleteCicloAnio;
DELIMITER $$
CREATE TRIGGER deleteCicloAnio AFTER DELETE ON CICLO_ANIO
FOR EACH ROW
BEGIN
    INSERT INTO HISTORIAL_TRANSACCIONES
        (descripcion, tipo)
    VALUES
        ('Se ha realizado una acción en la tabla CICLO_ANIO', 'DELETE');
END;
$$
DELIMITER ;

# -------------------------------------------- TABLA CURSO -----------------------------------------------------------
DROP TRIGGER IF EXISTS insertCurso;
DELIMITER $$
CREATE TRIGGER insertCurso AFTER INSERT ON CURSO
FOR EACH ROW
BEGIN
    INSERT INTO HISTORIAL_TRANSACCIONES
        (descripcion, tipo)
    VALUES
        ('Se ha realizado una acción en la tabla CURSO', 'INSERT');
END;
$$
DELIMITER ;

DROP TRIGGER IF EXISTS updateCurso;
DELIMITER $$
CREATE TRIGGER updateCurso AFTER UPDATE ON CURSO
FOR EACH ROW
BEGIN
    INSERT INTO HISTORIAL_TRANSACCIONES
        (descripcion, tipo)
    VALUES
        ('Se ha realizado una acción en la tabla CURSO', 'UPDATE');
END;
$$
DELIMITER ;

DROP TRIGGER IF EXISTS deleteCurso;
DELIMITER $$
CREATE TRIGGER deleteCurso AFTER DELETE ON CURSO
FOR EACH ROW
BEGIN
    INSERT INTO HISTORIAL_TRANSACCIONES
        (descripcion, tipo)
    VALUES
        ('Se ha realizado una acción en la tabla CURSO', 'DELETE');
END;
$$
DELIMITER ;

# -------------------------------------------- TABLA CURSO_HABILITADO -------------------------------------------------
DROP TRIGGER IF EXISTS insertCursoHabilitado;
DELIMITER $$
CREATE TRIGGER insertCursoHabilitado AFTER INSERT ON CURSO_HABILITADO
FOR EACH ROW
BEGIN
    INSERT INTO HISTORIAL_TRANSACCIONES
        (descripcion, tipo)
    VALUES
        ('Se ha realizado una acción en la tabla CURSO_HABILITADO', 'INSERT');
END;
$$
DELIMITER ;

DROP TRIGGER IF EXISTS updateCursoHabilitado;
DELIMITER $$
CREATE TRIGGER updateCursoHabilitado AFTER UPDATE ON CURSO_HABILITADO
FOR EACH ROW
BEGIN
    INSERT INTO HISTORIAL_TRANSACCIONES
        (descripcion, tipo)
    VALUES
        ('Se ha realizado una acción en la tabla CURSO_HABILITADO', 'UPDATE');
END;
$$
DELIMITER ;

DROP TRIGGER IF EXISTS deleteCursoHabilitado;
DELIMITER $$
CREATE TRIGGER deleteCursoHabilitado AFTER DELETE ON CURSO_HABILITADO
FOR EACH ROW
BEGIN
    INSERT INTO HISTORIAL_TRANSACCIONES
        (descripcion, tipo)
    VALUES
        ('Se ha realizado una acción en la tabla CURSO_HABILITADO', 'DELETE');
END;
$$
DELIMITER ;

# -------------------------------------------- TABLA DOCENTE ---------------------------------------------------------
DROP TRIGGER IF EXISTS insertDocente;
DELIMITER $$
CREATE TRIGGER insertDocente AFTER INSERT ON DOCENTE
FOR EACH ROW
BEGIN
    INSERT INTO HISTORIAL_TRANSACCIONES
        (descripcion, tipo)
    VALUES
        ('Se ha realizado una acción en la tabla DOCENTE', 'INSERT');
END;
$$
DELIMITER ;

DROP TRIGGER IF EXISTS updateDocente;
DELIMITER $$
CREATE TRIGGER updateDocente AFTER UPDATE ON DOCENTE
FOR EACH ROW
BEGIN
    INSERT INTO HISTORIAL_TRANSACCIONES
        (descripcion, tipo)
    VALUES
        ('Se ha realizado una acción en la tabla DOCENTE', 'UPDATE');
END;
$$
DELIMITER ;

DROP TRIGGER IF EXISTS deleteDocente;
DELIMITER $$
CREATE TRIGGER deleteDocente AFTER DELETE ON DOCENTE
FOR EACH ROW
BEGIN
    INSERT INTO HISTORIAL_TRANSACCIONES
        (descripcion, tipo)
    VALUES
        ('Se ha realizado una acción en la tabla DOCENTE', 'DELETE');
END;
$$
DELIMITER ;

# -------------------------------------------- TABLA ESTUDIANTE -------------------------------------------------------
DROP TRIGGER IF EXISTS insertEstudiante;
DELIMITER $$
CREATE TRIGGER insertEstudiante AFTER INSERT ON ESTUDIANTE
FOR EACH ROW
BEGIN
    INSERT INTO HISTORIAL_TRANSACCIONES
        (descripcion, tipo)
    VALUES
        ('Se ha realizado una acción en la tabla ESTUDIANTE', 'INSERT');
END;
$$
DELIMITER ;

DROP TRIGGER IF EXISTS updateEstudiante;
DELIMITER $$
CREATE TRIGGER updateEstudiante AFTER UPDATE ON ESTUDIANTE
FOR EACH ROW
BEGIN
    INSERT INTO HISTORIAL_TRANSACCIONES
        (descripcion, tipo)
    VALUES
        ('Se ha realizado una acción en la tabla ESTUDIANTE', 'UPDATE');
END;
$$
DELIMITER ;

DROP TRIGGER IF EXISTS deleteEstudiante;
DELIMITER $$
CREATE TRIGGER deleteEstudiante AFTER DELETE ON ESTUDIANTE
FOR EACH ROW
BEGIN
    INSERT INTO HISTORIAL_TRANSACCIONES
        (descripcion, tipo)
    VALUES
        ('Se ha realizado una acción en la tabla ESTUDIANTE', 'DELETE');
END;
$$
DELIMITER ;

# -------------------------------------------- TABLA HORARIO_CURSO ----------------------------------------------------
DROP TRIGGER IF EXISTS insertHorarioCurso;
DELIMITER $$
CREATE TRIGGER insertHorarioCurso AFTER INSERT ON HORARIO_CURSO
FOR EACH ROW
BEGIN
    INSERT INTO HISTORIAL_TRANSACCIONES
        (descripcion, tipo)
    VALUES
        ('Se ha realizado una acción en la tabla HORARIO_CURSO', 'INSERT');
END;
$$
DELIMITER ;

DROP TRIGGER IF EXISTS updateHorarioCurso;
DELIMITER $$
CREATE TRIGGER updateHorarioCurso AFTER UPDATE ON HORARIO_CURSO
FOR EACH ROW
BEGIN
    INSERT INTO HISTORIAL_TRANSACCIONES
        (descripcion, tipo)
    VALUES
        ('Se ha realizado una acción en la tabla HORARIO_CURSO', 'UPDATE');
END;
$$
DELIMITER ;

DROP TRIGGER IF EXISTS deleteHorarioCurso;
DELIMITER $$
CREATE TRIGGER deleteHorarioCurso AFTER DELETE ON HORARIO_CURSO
FOR EACH ROW
BEGIN
    INSERT INTO HISTORIAL_TRANSACCIONES
        (descripcion, tipo)
    VALUES
        ('Se ha realizado una acción en la tabla HORARIO_CURSO', 'DELETE');
END;
$$
DELIMITER ;

# -------------------------------------------- NOTA ----------------------------------------------------
DROP TRIGGER IF EXISTS insertNota;
DELIMITER $$
CREATE TRIGGER insertNota AFTER INSERT ON NOTA
FOR EACH ROW
BEGIN
    INSERT INTO HISTORIAL_TRANSACCIONES
        (descripcion, tipo)
    VALUES
        ('Se ha realizado una acción en la tabla NOTA', 'INSERT');
END;
$$
DELIMITER ;

DROP TRIGGER IF EXISTS updateNota;
DELIMITER $$
CREATE TRIGGER updateNota AFTER UPDATE ON NOTA
FOR EACH ROW
BEGIN
    INSERT INTO HISTORIAL_TRANSACCIONES
        (descripcion, tipo)
    VALUES
        ('Se ha realizado una acción en la tabla NOTA', 'UPDATE');
END;
$$
DELIMITER ;

DROP TRIGGER IF EXISTS deleteNota;
DELIMITER $$
CREATE TRIGGER deleteNota AFTER DELETE ON NOTA
FOR EACH ROW
BEGIN
    INSERT INTO HISTORIAL_TRANSACCIONES
        (descripcion, tipo)
    VALUES
        ('Se ha realizado una acción en la tabla NOTA', 'DELETE');
END;
$$
DELIMITER ;