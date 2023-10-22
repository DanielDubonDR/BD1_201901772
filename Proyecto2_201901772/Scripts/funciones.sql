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
    IF telefono REGEXP '^[0-9]{8,}$' THEN
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

# -------------------------------------------- validarIdCarrera --------------------------------------------
DROP FUNCTION IF EXISTS validarIdCarrera;
DELIMITER $$
CREATE FUNCTION validarIdCarrera(id_carrera INT)
RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE resultado BOOLEAN;
    SET resultado = FALSE;
    IF id_carrera REGEXP '^[0-9]+$' THEN
        SET resultado = TRUE;
    ELSE
        SET resultado = FALSE;
    END IF;

    IF id_carrera IS NULL OR id_carrera = '' THEN
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