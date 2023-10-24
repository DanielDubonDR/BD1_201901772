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
# 1. La fecha debe tener el formato DD-MM-YYYY
DROP FUNCTION IF EXISTS validarFecha;
DELIMITER $$
CREATE FUNCTION validarFecha(fecha VARCHAR(10))
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE resultado BOOLEAN;
    SET resultado = FALSE;
    IF fecha REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{4}$' THEN
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
    IF dpi REGEXP '^[0-9]{13}$' THEN
        SET resultado = TRUE;
    ELSE
        SET resultado = FALSE;
    END IF;

    IF dpi IS NULL THEN
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
    IF nombreCurso REGEXP '^[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ ]+$' THEN
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
    OR BINARY seccion= 'Z', TRUE, FALSE);
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
DELIMITER ;
