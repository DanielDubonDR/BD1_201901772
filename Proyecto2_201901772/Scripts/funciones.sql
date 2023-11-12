USE SISTEMA_CONTROL_FIUSAC;

# -------------------------------------------- getLastIdCarrera --------------------------------------------
DROP FUNCTION IF EXISTS getLastIdCarrera;
DELIMITER $$
CREATE FUNCTION getLastIdCarrera()
RETURNS INT DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE ultimo_id INT;

    SELECT MAX(id_carrera) INTO ultimo_id FROM CARRERA;

    RETURN ultimo_id;
END;
$$
DELIMITER ;

# -------------------------------------------- validarTexto --------------------------------------------
DROP FUNCTION IF EXISTS validarTexto;
DELIMITER $$
CREATE FUNCTION validarTexto(texto VARCHAR(200))
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE resultado BOOLEAN;
    SET resultado = FALSE;
    IF texto REGEXP '^[a-zA-ZñÑáéíóúÁÉÍÓÚ ]+$' THEN
        SET resultado = TRUE;
    ELSE
        SET resultado = FALSE;
    END IF;

    IF texto IS NULL OR texto = '' THEN
        SET resultado = FALSE;
    END IF;

    RETURN resultado;
END $$
DELIMITER ;

# -------------------------------------------- nombreCarreraNoRepetido --------------------------------------------
DROP FUNCTION IF EXISTS nombreCarreraNoRepetido;
DELIMITER $$
CREATE FUNCTION nombreCarreraNoRepetido(nombre_carrera VARCHAR(200))
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE resultado BOOLEAN;
    SET resultado = FALSE;
    IF EXISTS(SELECT * FROM CARRERA WHERE nombre = nombre_carrera) THEN
        SET resultado = TRUE;
    END IF;

    RETURN resultado;
END $$
DELIMITER ;

# -------------------------------------------- validarCarnet --------------------------------------------
# 1. El carnet debe tener 9 dígitos
DROP FUNCTION IF EXISTS validarCarnet;
DELIMITER $$
CREATE FUNCTION validarCarnet(carnet BIGINT)
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE resultado BOOLEAN;
    SET resultado = FALSE;
    IF carnet REGEXP '^[0-9]{9}$' THEN
        SET resultado = TRUE;
    ELSE
        SET resultado = FALSE;
    END IF;

    IF carnet IS NULL THEN
        SET resultado = FALSE;
    END IF;

    RETURN resultado;
END;
$$
DELIMITER ;

# -------------------------------------------- validarFecha --------------------------------------------
DROP FUNCTION IF EXISTS validarFecha;
DELIMITER $$
CREATE FUNCTION validarFecha(fecha VARCHAR(10))
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE resultado BOOLEAN;
    SET resultado = FALSE;
    IF fecha REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{4}$' OR fecha REGEXP '^[0-9]-[0-9]-[0-9]{4}$' THEN
        SET resultado = TRUE;
    ELSE
        SET resultado = FALSE;
    END IF;

    IF fecha IS NULL OR fecha = '' THEN
        SET resultado = FALSE;
    END IF;

    RETURN resultado;
END;
$$
DELIMITER ;

# -------------------------------------------- validarCorreo --------------------------------------------
DROP FUNCTION IF EXISTS validarCorreo;
DELIMITER $$
CREATE FUNCTION validarCorreo(correo VARCHAR(100))
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE resultado BOOLEAN;
    SET resultado = FALSE;
    IF correo REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$' THEN
        SET resultado = TRUE;
    ELSE
        SET resultado = FALSE;
    END IF;

    IF correo IS NULL OR correo = '' THEN
        SET resultado = FALSE;
    END IF;

    RETURN resultado;
END;
$$
DELIMITER ;

# -------------------------------------------- validarTelefono --------------------------------------------
DROP FUNCTION IF EXISTS validarTelefono;
DELIMITER $$
CREATE FUNCTION validarTelefono(telefono INT)
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE resultado BOOLEAN;
    SET resultado = FALSE;
    IF telefono REGEXP '^[0-9]{8}$' THEN
        SET resultado = TRUE;
    ELSE
        SET resultado = FALSE;
    END IF;

    IF telefono IS NULL OR telefono = '' THEN
        SET resultado = FALSE;
    END IF;

    RETURN resultado;
END;
$$
DELIMITER ;

# -------------------------------------------- validarDPI --------------------------------------------
DROP FUNCTION IF EXISTS validarDPI;
DELIMITER $$
CREATE FUNCTION validarDPI(dpi BIGINT)
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE resultado BOOLEAN;
    SET resultado = FALSE;
    IF dpi REGEXP '^[0-9]+$' THEN
        SET resultado = TRUE;
    ELSE
        SET resultado = FALSE;
    END IF;

    IF dpi IS NULL THEN
        SET resultado = FALSE;
    END IF;

    IF dpi <= 0 THEN
        SET resultado = FALSE;
    END IF;

    RETURN resultado;
END;
$$
DELIMITER ;

# -------------------------------------------- verificarCarnet --------------------------------------------
DROP FUNCTION IF EXISTS verificarCarnet;
DELIMITER $$
CREATE FUNCTION verificarCarnet(carne BIGINT)
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE resultado BOOLEAN;
    SET resultado = FALSE;
    IF EXISTS(SELECT * FROM ESTUDIANTE WHERE carnet = carne) THEN
        SET resultado = TRUE;
    END IF;

    RETURN resultado;
END;
$$
DELIMITER ;

# -------------------------------------------- verificarDPIEsudiante --------------------------------------------
DROP FUNCTION IF EXISTS verificarDPI;
DELIMITER $$
CREATE FUNCTION verificarDPIEsudiante(dpiE BIGINT)
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE resultado BOOLEAN;
    SET resultado = FALSE;
    IF EXISTS(SELECT * FROM ESTUDIANTE WHERE dpi = dpiE) THEN
        SET resultado = TRUE;
    END IF;

    RETURN resultado;
END;
$$
DELIMITER ;

# -------------------------------------------- verificarCarrera --------------------------------------------
DROP FUNCTION IF EXISTS verificarCarrera;
DELIMITER $$
CREATE FUNCTION verificarCarrera(carrera INT)
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE resultado BOOLEAN;
    SET resultado = FALSE;
    IF EXISTS(SELECT * FROM CARRERA WHERE id_carrera = carrera) THEN
        SET resultado = TRUE;
    END IF;

    RETURN resultado;
END;
$$
DELIMITER ;

# -------------------------------------------- validarSIFF --------------------------------------------
DROP FUNCTION IF EXISTS validarSIFF;
DELIMITER $$
CREATE FUNCTION validarSIFF(siff BIGINT)
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE resultado BOOLEAN;
    SET resultado = FALSE;
    IF siff REGEXP '^[0-9]+$' THEN
        SET resultado = TRUE;
    ELSE
        SET resultado = FALSE;
    END IF;

    IF siff IS NULL THEN
        SET resultado = FALSE;
    END IF;

    RETURN resultado;
END;
$$
DELIMITER ;

# -------------------------------------------- verificarSIFF --------------------------------------------
DROP FUNCTION IF EXISTS verificarSIFF;
DELIMITER $$
CREATE FUNCTION verificarSIFF(siff BIGINT)
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE resultado BOOLEAN;
    SET resultado = FALSE;
    IF EXISTS(SELECT * FROM DOCENTE WHERE siff_docente = siff) THEN
        SET resultado = TRUE;
    END IF;

    RETURN resultado;
END;
$$
DELIMITER ;

# -------------------------------------------- verificarDPIDocente --------------------------------------------
DROP FUNCTION IF EXISTS verificarDPIDocente;
DELIMITER $$
CREATE FUNCTION verificarDPIDocente(dpiDocente BIGINT)
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE resultado BOOLEAN;
    SET resultado = FALSE;
    IF EXISTS(SELECT * FROM DOCENTE WHERE dpi = dpiDocente) THEN
        SET resultado = TRUE;
    END IF;

    RETURN resultado;
END;
$$
DELIMITER ;

# -------------------------------------------- validarNumero --------------------------------------------
DROP FUNCTION IF EXISTS validarNumero;
DELIMITER $$
CREATE FUNCTION validarNumero(numero INT)
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE resultado BOOLEAN;
    SET resultado = FALSE;
    IF numero REGEXP '^[0-9]+$' THEN
        SET resultado = TRUE;
    ELSE
        SET resultado = FALSE;
    END IF;

    IF numero IS NULL OR numero = '' THEN
        SET resultado = FALSE;
    END IF;

    RETURN resultado;
END;
$$
DELIMITER ;

# -------------------------------------------- validarBooleano --------------------------------------------
DROP FUNCTION IF EXISTS validarBooleano;
DELIMITER $$
CREATE FUNCTION validarBooleano(booleano BOOLEAN)
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE resultado BOOLEAN;
    SET resultado = FALSE;

    IF booleano = 0 OR booleano = 1 THEN
        SET resultado = TRUE;
    ELSE
        SET resultado = FALSE;
    END IF;

    IF booleano IS NULL THEN
        SET resultado = FALSE;
    END IF;

    RETURN resultado;
END;
$$
DELIMITER ;

# -------------------------------------------- verificarCurso --------------------------------------------
DROP FUNCTION IF EXISTS verificarCurso;
DELIMITER $$
CREATE FUNCTION verificarCurso(idCurso BIGINT)
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE resultado BOOLEAN;
    SET resultado = FALSE;
    IF EXISTS(SELECT * FROM CURSO WHERE codigo_curso = idCurso) THEN
        SET resultado = TRUE;
    END IF;

    RETURN resultado;
END;
$$
DELIMITER ;

# -------------------------------------------- verificarNombreCurso --------------------------------------------
DROP FUNCTION IF EXISTS verificarNombreCurso;
DELIMITER $$
CREATE FUNCTION verificarNombreCurso(nombreCurso VARCHAR(150))
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE resultado BOOLEAN;
    SET resultado = FALSE;
    IF EXISTS(SELECT * FROM CURSO WHERE nombre = nombreCurso) THEN
        SET resultado = TRUE;
    END IF;

    RETURN resultado;
END;
$$
DELIMITER ;

# -------------------------------------------- validarNombreCurso --------------------------------------------
DROP FUNCTION IF EXISTS validarNombreCurso;
DELIMITER $$
CREATE FUNCTION validarNombreCurso(nombreCurso VARCHAR(150))
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE resultado BOOLEAN;
    SET resultado = FALSE;
    IF nombreCurso REGEXP '^[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ. ]+$' THEN
        SET resultado = TRUE;
    ELSE
        SET resultado = FALSE;
    END IF;

    IF nombreCurso IS NULL OR nombreCurso = '' THEN
        SET resultado = FALSE;
    END IF;

    RETURN resultado;
END;
$$
DELIMITER ;

# -------------------------------------------- validarNumeroCon0 --------------------------------------------
DROP FUNCTION IF EXISTS validarNumeroCon0;
DELIMITER $$
CREATE FUNCTION validarNumeroCon0(numero INT)
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE resultado BOOLEAN;
    SET resultado = FALSE;
    IF numero REGEXP '^[0-9]+$' THEN
        SET resultado = TRUE;
    ELSE
        SET resultado = FALSE;
    END IF;

    RETURN resultado;
END;
$$
DELIMITER ;

# -------------------------------------------- getIdCicloAnio --------------------------------------------
DROP FUNCTION IF EXISTS getIdCicloAnio;
DELIMITER $$
CREATE FUNCTION getIdCicloAnio(cl VARCHAR(2))
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE idCiclo INT;
    DECLARE idCicloAnio INT;
    DECLARE resultado INT;
    SET resultado = -1;

    SELECT id_ciclo INTO idCiclo FROM CICLO WHERE ciclo = cl;
    IF idCiclo IS NULL THEN
        RETURN resultado;
    END IF;

    SELECT id_ciclo_anio INTO idCicloAnio FROM CICLO_ANIO WHERE id_ciclo = idCiclo AND anio = YEAR(CURDATE());
    IF idCicloAnio IS NULL THEN
        INSERT INTO CICLO_ANIO(id_ciclo, anio) VALUES(idCiclo, YEAR(CURDATE()));
        SET resultado = LAST_INSERT_ID();
        RETURN resultado;
    ELSE
        RETURN idCicloAnio;
    END IF;

END;
$$
DELIMITER ;

# -------------------------------------------- validarCiclo --------------------------------------------
DROP FUNCTION IF EXISTS validarCiclo;
DELIMITER $$
CREATE FUNCTION validarCiclo(ciclo VARCHAR(2))
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    RETURN IF
    (BINARY ciclo = '1S'
    OR BINARY ciclo= '2S'
    OR BINARY ciclo= 'VD'
    OR BINARY ciclo= 'VJ', TRUE, FALSE);
END;
$$
DELIMITER ;

# -------------------------------------------- validarSeccion --------------------------------------------
DROP FUNCTION IF EXISTS validarSeccion;
DELIMITER $$
CREATE FUNCTION validarSeccion(seccion CHAR(1))
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    RETURN IF
    (BINARY seccion = 'A'
    OR BINARY seccion= 'B'
    OR BINARY seccion= 'C'
    OR BINARY seccion= 'D'
    OR BINARY seccion= 'E'
    OR BINARY seccion= 'F'
    OR BINARY seccion= 'G'
    OR BINARY seccion= 'H'
    OR BINARY seccion= 'I'
    OR BINARY seccion= 'J'
    OR BINARY seccion= 'K'
    OR BINARY seccion= 'L'
    OR BINARY seccion= 'M'
    OR BINARY seccion= 'N'
    OR BINARY seccion= 'O'
    OR BINARY seccion= 'P'
    OR BINARY seccion= 'Q'
    OR BINARY seccion= 'R'
    OR BINARY seccion= 'S'
    OR BINARY seccion= 'T'
    OR BINARY seccion= 'U'
    OR BINARY seccion= 'V'
    OR BINARY seccion= 'W'
    OR BINARY seccion= 'X'
    OR BINARY seccion= 'Y'
    OR BINARY seccion= 'Z'
    OR BINARY seccion= 'a'
    OR BINARY seccion= 'b'
    OR BINARY seccion= 'c'
    OR BINARY seccion= 'd'
    OR BINARY seccion= 'e'
    OR BINARY seccion= 'f'
    OR BINARY seccion= 'g'
    OR BINARY seccion= 'h'
    OR BINARY seccion= 'i'
    OR BINARY seccion= 'j'
    OR BINARY seccion= 'k'
    OR BINARY seccion= 'l'
    OR BINARY seccion= 'm'
    OR BINARY seccion= 'n'
    OR BINARY seccion= 'o'
    OR BINARY seccion= 'p'
    OR BINARY seccion= 'q'
    OR BINARY seccion= 'r'
    OR BINARY seccion= 's'
    OR BINARY seccion= 't'
    OR BINARY seccion= 'u'
    OR BINARY seccion= 'v'
    OR BINARY seccion= 'w'
    OR BINARY seccion= 'x'
    OR BINARY seccion= 'y'
    OR BINARY seccion= 'z', TRUE, FALSE);
END;
$$
DELIMITER ;

# -------------------------------------------- verificarSeccion --------------------------------------------
DROP FUNCTION IF EXISTS verificarSeccion;
DELIMITER $$
CREATE FUNCTION verificarSeccion(codigoCurso BIGINT, ciclo VARCHAR(2), secc CHAR(1))
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE idHabilitado INT;

    SELECT id_curso_habilitado INTO idHabilitado
    FROM CURSO_HABILITADO
    WHERE id_ciclo_anio = getIdCicloAnio(ciclo)
    AND codigo_curso = codigoCurso
    AND seccion = secc;

    IF idHabilitado IS NULL THEN
        RETURN FALSE;
    ELSE
        RETURN TRUE;
    END IF;

END;
$$
DELIMITER

# -------------------------------------------- verificarCiclo --------------------------------------------
DROP FUNCTION IF EXISTS verificarCiclo;
DELIMITER $$
CREATE FUNCTION verificarCiclo(codigoCurso BIGINT, ciclo VARCHAR(2))
RETURNS BOOLEAN DETERMINISTIC
BEGIN

    DECLARE resultado BOOLEAN;
    SET resultado = FALSE;

    IF EXISTS(SELECT * FROM CURSO_HABILITADO WHERE id_ciclo_anio = getIdCicloAnio(ciclo) AND codigo_curso = codigoCurso) THEN
        SET resultado = TRUE;
    END IF;

    RETURN resultado;

END;
$$
DELIMITER ;

# -------------------------------------------- validarDia --------------------------------------------
DROP FUNCTION IF EXISTS validarDia;
DELIMITER $$
CREATE FUNCTION validarDia(dia INT)
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    IF dia >= 1 AND dia <= 7 THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
$$
DELIMITER ;

# -------------------------------------------- validarHorario --------------------------------------------
DROP FUNCTION IF EXISTS validarHorario;
DELIMITER $$
CREATE FUNCTION validarHorario(horario VARCHAR(11))
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE startTime VARCHAR(5);
    DECLARE endTime VARCHAR(5);
    DECLARE horaInicio VARCHAR(2);
    DECLARE horaFin VARCHAR(2);

    SET startTime = SUBSTRING_INDEX(horario, '-', 1);
    SET endTime = SUBSTRING_INDEX(horario, '-', -1);

    IF horario REGEXP '^[0-2][0-9]:[0-9]{2}-[0-2][0-9]:[0-9]{2}$' THEN

        SET horaInicio = SUBSTRING_INDEX(startTime, ':', 1);
        SET horaFin = SUBSTRING_INDEX(endTime, ':', 1);

        IF TIME_FORMAT(startTime, '%H:%i') IS NOT NULL
        AND TIME_FORMAT(endTime, '%H:%i') IS NOT NULL
        AND TIME_FORMAT(startTime, '%H:%i') < TIME_FORMAT(endTime, '%H:%i')
        AND CAST(horaInicio AS UNSIGNED) < 24
        AND CAST(horaFin AS UNSIGNED) < 24 THEN
            RETURN TRUE;
        ELSE
            RETURN FALSE;
        END IF;
    ELSE
        RETURN FALSE;
    END IF;
END;
$$
DELIMITER ;

# -------------------------------------------- verificarCursoHabilitado --------------------------------------------
DROP FUNCTION IF EXISTS verificarCursoHabilitado;
DELIMITER $$
CREATE FUNCTION verificarCursoHabilitado(idCursoHabilitado INT)
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE resultado BOOLEAN;
    SET resultado = FALSE;
    IF EXISTS(SELECT * FROM CURSO_HABILITADO WHERE id_curso_habilitado = idCursoHabilitado) THEN
        SET resultado = TRUE;
    END IF;

    RETURN resultado;
END;
$$
DELIMITER ;

# -------------------------------------------- verificarMismoHoraio --------------------------------------------
DROP FUNCTION IF EXISTS verificarMismoHoraio;
DELIMITER $$
CREATE FUNCTION verificarMismoHoraio(idCursoHabilitado INT, dia INT, horario VARCHAR(11))
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE resultado BOOLEAN;
    DECLARE startTime VARCHAR(5);
    DECLARE endTime VARCHAR(5);

    SET resultado = FALSE;
    SET startTime = SUBSTRING_INDEX(horario, '-', 1);
    SET endTime = SUBSTRING_INDEX(horario, '-', -1);

    IF EXISTS(SELECT * FROM HORARIO_CURSO WHERE id_curso_habilitado = idCursoHabilitado AND dia_semana = dia AND hora_inicio = startTime AND hora_final = endTime) THEN
        SET resultado = TRUE;
    END IF;

    RETURN resultado;

END;
$$
DELIMITER ;

# -------------------------------------------- verificarTraslapeHorario --------------------------------------------
DROP FUNCTION IF EXISTS verificarTraslapeHorario;
DELIMITER $$
CREATE FUNCTION verificarTraslapeHorario(idCursoHabilitado INT, dia INT, horario VARCHAR(11))
RETURNS BOOLEAN DETERMINISTIC
    BEGIN
    DECLARE resultado BOOLEAN;
    DECLARE startTime VARCHAR(5);
    DECLARE endTime VARCHAR(5);

    SET resultado = 0;
    SET startTime = SUBSTRING_INDEX(horario, '-', 1);
    SET endTime = SUBSTRING_INDEX(horario, '-', -1);

    IF EXISTS(SELECT * FROM HORARIO_CURSO WHERE id_curso_habilitado = idCursoHabilitado AND dia_semana = dia AND hora_inicio <= startTime AND hora_final > startTime) THEN
        SET resultado = TRUE;
    ELSEIF EXISTS(SELECT * FROM HORARIO_CURSO WHERE id_curso_habilitado = idCursoHabilitado AND dia_semana = dia AND hora_inicio < endTime AND hora_final >= endTime) THEN
        SET resultado = TRUE;
    END IF;

    RETURN resultado;
END;
$$
DELIMITER ;

# -------------------------------------------- verificarCursoAsignadoMismaSeccion --------------------------------------------
DROP FUNCTION IF EXISTS verificarCursoAsignadoMismaSeccion;
DELIMITER $$
CREATE FUNCTION verificarCursoAsignadoMismaSeccion(carne BIGINT, codigoCurso BIGINT, ciclo VARCHAR(2), secc CHAR(1))
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE idCursoHabilitado INT;
    DECLARE idCicloAnio INT;
    DECLARE resultado BOOLEAN;

    SET resultado = FALSE;
    SET idCicloAnio = getIdCicloAnio(ciclo);

    IF idCicloAnio = -1 THEN
        RETURN resultado;
    END IF;

    SELECT id_curso_habilitado INTO idCursoHabilitado
    FROM CURSO_HABILITADO
    WHERE id_ciclo_anio = idCicloAnio
    AND codigo_curso = codigoCurso
    AND seccion = secc;

    IF idCursoHabilitado IS NULL THEN
        RETURN resultado;
    END IF;

    IF EXISTS(SELECT * FROM ASIGNACION_CURSO WHERE carnet = carne AND id_curso_habilitado = idCursoHabilitado AND estado = TRUE) THEN
        SET resultado = TRUE;
    END IF;

    RETURN resultado;
END;
$$
DELIMITER ;

# -------------------------------------------- verificarCursoAsignadoDiferencteSeccion --------------------------------------------
DROP FUNCTION IF EXISTS verificarCursoAsignadoDiferenteSeccion;
DELIMITER $$
CREATE FUNCTION verificarCursoAsignadoDiferenteSeccion(carne BIGINT, codigoCurso BIGINT, ciclo VARCHAR(2))
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE idCicloAnio INT;
    DECLARE resultado BOOLEAN;

    -- Declara una tabla temporal para almacenar múltiples idCursoHabilitado
    CREATE TEMPORARY TABLE IF NOT EXISTS tmpIdCursoHabilitado (id INT);

    SET resultado = FALSE;
    SET idCicloAnio = getIdCicloAnio(ciclo);

    IF idCicloAnio = -1 THEN
        RETURN resultado;
    END IF;

    -- Borra los registros existentes en la tabla temporal
    DELETE FROM tmpIdCursoHabilitado;

    -- Inserta los valores de idCursoHabilitado en la tabla temporal
    INSERT INTO tmpIdCursoHabilitado (id)
    SELECT id_curso_habilitado
    FROM CURSO_HABILITADO
    WHERE id_ciclo_anio = idCicloAnio
    AND codigo_curso = codigoCurso;

    IF (SELECT COUNT(*) FROM tmpIdCursoHabilitado) > 0 THEN
        -- Si hay registros en la tabla temporal, verifica la existencia en ASIGNACION_CURSO
        IF EXISTS(SELECT * FROM ASIGNACION_CURSO WHERE carnet = carne AND id_curso_habilitado IN (SELECT id FROM tmpIdCursoHabilitado) AND estado = TRUE) THEN
            SET resultado = TRUE;
        END IF;
    END IF;

    -- Borra la tabla temporal
    DROP TEMPORARY TABLE IF EXISTS tmpIdCursoHabilitado;

    RETURN resultado;
END;
$$
DELIMITER ;

# -------------------------------------------- verificarCursoDesasignado --------------------------------------------
DROP FUNCTION IF EXISTS verificarCursoDesasignado;
DELIMITER $$
CREATE FUNCTION verificarCursoDesasignado(carne BIGINT, codigoCurso BIGINT, ciclo VARCHAR(2))
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE idCicloAnio INT;
    DECLARE resultado BOOLEAN;

    CREATE TEMPORARY TABLE IF NOT EXISTS tmpIdCursoHabilitado (id INT);

    SET resultado = FALSE;
    SET idCicloAnio = getIdCicloAnio(ciclo);

    IF idCicloAnio = -1 THEN
        RETURN resultado;
    END IF;

    DELETE FROM tmpIdCursoHabilitado;

    INSERT INTO tmpIdCursoHabilitado (id)
    SELECT id_curso_habilitado
    FROM CURSO_HABILITADO
    WHERE id_ciclo_anio = idCicloAnio
    AND codigo_curso = codigoCurso;

    IF (SELECT COUNT(*) FROM tmpIdCursoHabilitado) > 0 THEN
        IF EXISTS(SELECT * FROM ASIGNACION_CURSO WHERE carnet = carne AND id_curso_habilitado IN (SELECT id FROM tmpIdCursoHabilitado) AND estado = FALSE) THEN
            SET resultado = TRUE;
        END IF;
    END IF;

    DROP TEMPORARY TABLE IF EXISTS tmpIdCursoHabilitado;

    RETURN resultado;
END;
$$
DELIMITER ;

# -------------------------------------------- verificarCreditosEsutidanteCurso --------------------------------------------
DROP FUNCTION IF EXISTS verificarCreditosEstudianteCurso;
DELIMITER $$
CREATE FUNCTION verificarCreditosEstudianteCurso(carne BIGINT, codigoCurso BIGINT)
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE creditosCurso INT;
    DECLARE creditosEstudiante INT;
    DECLARE resultado BOOLEAN;

    SET resultado = FALSE;
    SET creditosCurso = (SELECT creditos_necesarios FROM CURSO WHERE codigo_curso = codigoCurso);
    SET creditosEstudiante = (SELECT creditos FROM ESTUDIANTE WHERE carnet = carne);

    IF creditosEstudiante >= creditosCurso THEN
        SET resultado = TRUE;
    END IF;

    RETURN resultado;
END;
$$
DELIMITER ;

# -------------------------------------------- verificarCursoCarrera --------------------------------------------
DROP FUNCTION IF EXISTS verificarCursoCarrera;
DELIMITER $$
CREATE FUNCTION verificarCursoCarrera(carne BIGINT, codigoCurso BIGINT)
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE idCarreraEstudiante INT;
    DECLARE idCarreraCurso INT;
    DECLARE resultado BOOLEAN;

    SET resultado = FALSE;
    SET idCarreraEstudiante = (SELECT id_carrera FROM ESTUDIANTE WHERE carnet = carne);
    SET idCarreraCurso = (SELECT id_carrera FROM CURSO WHERE codigo_curso = codigoCurso);

    IF idCarreraEstudiante = idCarreraCurso THEN
        SET resultado = TRUE;
    ELSEIF idCarreraCurso = 0 THEN
        SET resultado = TRUE;
    END IF;

    RETURN resultado;

END;
$$
DELIMITER ;

# -------------------------------------------- verificarCupoCurso --------------------------------------------
DROP FUNCTION IF EXISTS verificarCupoCurso;
DELIMITER $$
CREATE FUNCTION verificarCupoCurso(codigoCurso BIGINT, ciclo VARCHAR(2), secc CHAR(1))
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE idCicloAnio INT;
    DECLARE idCursoHabilitado INT;
    DECLARE cupoCurso INT;
    DECLARE cupoActual INT;
    DECLARE resultado BOOLEAN;

    SET resultado = FALSE;
    SET idCicloAnio = getIdCicloAnio(ciclo);

    IF idCicloAnio = -1 THEN
        RETURN resultado;
    END IF;

    SET idCursoHabilitado = (SELECT id_curso_habilitado FROM CURSO_HABILITADO WHERE id_ciclo_anio = idCicloAnio AND codigo_curso = codigoCurso AND seccion = secc);
    SET cupoCurso = (SELECT cupo_maximo FROM CURSO_HABILITADO WHERE id_curso_habilitado = idCursoHabilitado);
    SET cupoActual = (SELECT COUNT(*) FROM ASIGNACION_CURSO WHERE id_curso_habilitado = idCursoHabilitado AND estado = TRUE);

    IF cupoActual < cupoCurso THEN
        SET resultado = TRUE;
    END IF;

    RETURN resultado;

END;
$$
DELIMITER ;

# -------------------------------------------- getCursoHabilitado --------------------------------------------
DROP FUNCTION IF EXISTS getIdCursoHabilitado;
DELIMITER $$
CREATE FUNCTION getIdCursoHabilitado(codigoCurso BIGINT, ciclo VARCHAR(2), secc CHAR(1))
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE idCicloAnio INT;
    DECLARE idCursoHabilitado INT;

    SET idCicloAnio = getIdCicloAnio(ciclo);

    IF idCicloAnio = -1 THEN
        RETURN -1;
    END IF;

    SET idCursoHabilitado = (SELECT id_curso_habilitado FROM CURSO_HABILITADO WHERE id_ciclo_anio = idCicloAnio AND codigo_curso = codigoCurso AND seccion = secc);

    RETURN idCursoHabilitado;

END;
$$
DELIMITER ;

# -------------------------------------------------- verificarAsociacionHorarios --------------------------------------------------
DROP FUNCTION IF EXISTS verificarAsociacionHorarios;
DELIMITER $$
CREATE FUNCTION verificarAsociacionHorarios(idCursoHabilitado INT)
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE resultado BOOLEAN;
    SET resultado = FALSE;

    IF EXISTS(SELECT * FROM HORARIO_CURSO WHERE id_curso_habilitado = idCursoHabilitado) THEN
        SET resultado = TRUE;
    END IF;

    RETURN resultado;
END;
$$
DELIMITER ;

# ------------------------------------------------- validarNota -------------------------------------------------
DROP FUNCTION IF EXISTS validarNota;
DELIMITER $$
CREATE FUNCTION validarNota(nota INT)
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE resultado BOOLEAN;
    SET resultado = FALSE;

    IF nota >= 0 AND nota <= 100 THEN
        SET resultado = TRUE;
    END IF;

    RETURN resultado;
END;
$$
DELIMITER ;


# ------------------------------------------------- verificarNotaIngresada ------------------------------------------
DROP FUNCTION IF EXISTS verificarNotaIngresada;
DELIMITER $$
CREATE FUNCTION verificarNotaIngresada(carne BIGINT, codigoCurso BIGINT, ciclo VARCHAR(2), secc CHAR(1))
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE idCicloAnio INT;
    DECLARE idCursoHabilitado INT;
    DECLARE idAsignacion INT;
    DECLARE resultado BOOLEAN;

    SET resultado = FALSE;
    SET idCicloAnio = getIdCicloAnio(ciclo);

    IF idCicloAnio = -1 THEN
        RETURN resultado;
    END IF;

    SET idCursoHabilitado = (SELECT id_curso_habilitado FROM CURSO_HABILITADO WHERE id_ciclo_anio = idCicloAnio AND codigo_curso = codigoCurso AND seccion = secc);

    IF idCursoHabilitado IS NULL THEN
        RETURN resultado;
    END IF;

    SET idAsignacion = (SELECT id_asignacion FROM ASIGNACION_CURSO WHERE carnet = carne AND id_curso_habilitado = idCursoHabilitado);
    IF idAsignacion IS NULL THEN
        RETURN resultado;
    END IF;

    IF EXISTS(SELECT * FROM NOTA WHERE id_asignacion = idAsignacion) THEN
        SET resultado = TRUE;
    END IF;

    RETURN resultado;
END;
$$
DELIMITER ;

# ------------------------------------------------- verificarCursoAprobado ------------------------------------------
DROP FUNCTION IF EXISTS verificarCursoAprobado;
DELIMITER $$
CREATE FUNCTION verificarCursoAprobado(carne BIGINT, codigoCurso BIGINT)
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE resultado BOOLEAN;

    SET resultado = FALSE;

    IF EXISTS(
        SELECT * FROM NOTA n
        INNER JOIN ASIGNACION_CURSO ac ON n.id_asignacion = ac.id_asignacion
        INNER JOIN CURSO_HABILITADO ch ON ac.id_curso_habilitado = ch.id_curso_habilitado
        WHERE ac.carnet = carne AND ch.codigo_curso = codigoCurso AND n.nota >= 61
    ) THEN
        SET resultado = TRUE;
    END IF;

    RETURN resultado;
END;
$$
DELIMITER ;

# ------------------------------------------------- verificarNotasIngresadas ------------------------------------------
DROP FUNCTION IF EXISTS verificarNotasIngresadas;
DELIMITER $$
CREATE FUNCTION verificarNotasIngresadas(codigoCurso BIGINT, ciclo VARCHAR(2), secc CHAR(1))
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE idCicloAnio INT;
    DECLARE idCursoHabilitado INT;
    DECLARE estudiantesAsignados INT;
    DECLARE estudiantesConNota INT;
    DECLARE resultado BOOLEAN;

    SET resultado = FALSE;
    SET idCicloAnio = getIdCicloAnio(ciclo);

    IF idCicloAnio = -1 THEN
        RETURN resultado;
    END IF;

    SET idCursoHabilitado = (SELECT id_curso_habilitado FROM CURSO_HABILITADO WHERE id_ciclo_anio = idCicloAnio AND codigo_curso = codigoCurso AND seccion = secc);
    SET estudiantesAsignados = (SELECT COUNT(*) FROM ASIGNACION_CURSO WHERE id_curso_habilitado = idCursoHabilitado AND estado = TRUE);
    SET estudiantesConNota = (SELECT COUNT(*) FROM NOTA n INNER JOIN ASIGNACION_CURSO ac ON n.id_asignacion = ac.id_asignacion WHERE ac.id_curso_habilitado = idCursoHabilitado);

    IF estudiantesAsignados = estudiantesConNota THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;

END;
$$
DELIMITER ;

# ------------------------------------------------- verificarEstudianteConNota ------------------------------------------
DROP FUNCTION IF EXISTS verificarEstudianteConNota;
DELIMITER $$
CREATE FUNCTION verificarEstudianteConNota(carne BIGINT, codigoCurso BIGINT, ciclo VARCHAR(2), secc CHAR(1))
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE resultado BOOLEAN;

    SET resultado = FALSE;

    IF EXISTS(
        SELECT * FROM NOTA n
        INNER JOIN ASIGNACION_CURSO ac ON n.id_asignacion = ac.id_asignacion
        INNER JOIN CURSO_HABILITADO ch ON ac.id_curso_habilitado = ch.id_curso_habilitado
        WHERE ac.carnet = carne AND ch.codigo_curso = codigoCurso AND n.nota >= 0 AND ch.seccion = secc AND ch.id_ciclo_anio = getIdCicloAnio(ciclo)
    ) THEN
        SET resultado = TRUE;
    END IF;

    RETURN resultado;
END;
$$
DELIMITER ;

# ------------------------------------------------- validarAnio -------------------------------------------------
DROP FUNCTION IF EXISTS validarAnio;
DELIMITER $$
CREATE FUNCTION validarAnio(anio INT)
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE resultado BOOLEAN;
    SET resultado = FALSE;

    IF anio >= 1800 AND anio <= 2050 THEN
        SET resultado = TRUE;
    END IF;

    RETURN resultado;
END;
$$
DELIMITER ;

# ------------------------------------------------- verificarCicloAnio -------------------------------------------------
DROP FUNCTION IF EXISTS verificarCicloAnio;
DELIMITER $$
CREATE FUNCTION verificarCicloAnio(ciclo VARCHAR(2),anio INT)
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE resultado BOOLEAN;
    SET resultado = FALSE;

    IF EXISTS(SELECT * FROM CICLO_ANIO ca INNER JOIN CICLO c ON ca.id_ciclo = c.id_ciclo WHERE c.ciclo = ciclo AND ca.anio = anio) THEN
        SET resultado = TRUE;
    END IF;

    RETURN resultado;
END;
$$
DELIMITER ;

# ------------------------------------------------- getCicloAnioPersonalizado -------------------------------------------------
DROP FUNCTION IF EXISTS getCicloAnioPersonalizado;
DELIMITER $$
CREATE FUNCTION getCicloAnioPersonalizado(ciclo VARCHAR(2),anio INT)
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE resultado INT;
    SET resultado = -1;

    IF EXISTS(SELECT * FROM CICLO_ANIO ca INNER JOIN CICLO c ON ca.id_ciclo = c.id_ciclo WHERE c.ciclo = ciclo AND ca.anio = anio) THEN
        SET resultado = (SELECT id_ciclo_anio FROM CICLO_ANIO ca INNER JOIN CICLO c ON ca.id_ciclo = c.id_ciclo WHERE c.ciclo = ciclo AND ca.anio = anio);
    END IF;

    RETURN resultado;
END;
$$
DELIMITER ;

# ------------------------------------------------- verificarSeccionAnioPersonalizado -------------------------------------------------
DROP FUNCTION IF EXISTS verificarSeccionAnioPersonalizado;
DELIMITER $$
CREATE FUNCTION verificarSeccionAnioPersonalizado(codigoCurso BIGINT, ciclo VARCHAR(2), secc CHAR(1), anio INT)
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE idHabilitado INT;

    SELECT id_curso_habilitado INTO idHabilitado
    FROM CURSO_HABILITADO
    WHERE id_ciclo_anio = getCicloAnioPersonalizado(ciclo, anio)
    AND codigo_curso = codigoCurso
    AND seccion = secc;

    IF idHabilitado IS NULL THEN
        RETURN FALSE;
    ELSE
        RETURN TRUE;
    END IF;

END;
$$
DELIMITER ;

# ------------------------------------------------- verificarNotasExisten ---------------------------------------------
DROP FUNCTION IF EXISTS verificarNotasExisten;
DELIMITER $$
CREATE FUNCTION verificarNotasExisten(codigoCurso BIGINT, ciclo VARCHAR(2), seccion CHAR(1), anio INT)
RETURNS BOOLEAN DETERMINISTIC
BEGIN

    SELECT
        COUNT(*) INTO @total
    FROM CICLO c
    INNER JOIN CICLO_ANIO ca ON c.id_ciclo = ca.id_ciclo
    INNER JOIN CURSO_HABILITADO ch ON ca.id_ciclo_anio = ch.id_ciclo_anio
    INNER JOIN ASIGNACION_CURSO ac ON ch.id_curso_habilitado = ac.id_curso_habilitado
    INNER JOIN ESTUDIANTE e ON e.carnet = ac.carnet
    INNER JOIN NOTA n ON n.id_asignacion = ac.id_asignacion
    WHERE c.ciclo = ciclo AND ca.anio = anio AND ch.codigo_curso = codigoCurso AND ch.seccion = seccion;

    IF @total > 0 THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;

END;
$$
DELIMITER ;

# ------------------------------------------------- verificarActasExisten ---------------------------------------------
DROP FUNCTION IF EXISTS verificarActasExisten;
DELIMITER $$
CREATE FUNCTION verificarActasExisten(codigoCurso BIGINT)
RETURNS BOOLEAN DETERMINISTIC
BEGIN

    SELECT
        COUNT(*) INTO @total
    FROM ACTA
    INNER JOIN CURSO_HABILITADO ch ON ACTA.id_curso_habilitado = ch.id_curso_habilitado
    WHERE ch.codigo_curso = codigoCurso;

    IF @total > 0 THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;

END;
$$
DELIMITER ;

# -------------------------------------------- validarDireccion --------------------------------------------
DROP FUNCTION IF EXISTS validarDireccion;
DELIMITER $$
CREATE FUNCTION validarDireccion(direccion VARCHAR(150))
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE resultado BOOLEAN;
    SET resultado = FALSE;
    IF direccion REGEXP '^[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ., -]+$' THEN
        SET resultado = TRUE;
    ELSE
        SET resultado = FALSE;
    END IF;

    IF direccion IS NULL OR direccion = '' THEN
        SET resultado = FALSE;
    END IF;

    RETURN resultado;
END;
$$
DELIMITER ;

# -------------------------------------------- validarCodigoCurso --------------------------------------------
DROP FUNCTION IF EXISTS validarCodigoCurso;
DELIMITER $$
CREATE FUNCTION validarCodigoCurso(codigoCurso BIGINT)
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE resultado BOOLEAN;
    SET resultado = FALSE;
    IF codigoCurso REGEXP '^[0-9]+$' THEN
        SET resultado = TRUE;
    ELSE
        SET resultado = FALSE;
    END IF;

    IF codigoCurso IS NULL OR codigoCurso = '' OR codigoCurso <= 0 THEN
        SET resultado = FALSE;
    END IF;

    RETURN resultado;
END;
$$
DELIMITER ;

