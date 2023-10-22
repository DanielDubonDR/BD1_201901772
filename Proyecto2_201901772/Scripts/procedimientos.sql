USE SISTEMA_CONTROL_FIUSAC;

# ------------------------------------------ errMessage ------------------------------------------
DROP PROCEDURE IF EXISTS errMessage;
DELIMITER $$
CREATE PROCEDURE errMessage(
    IN message VARCHAR(200)
)
BEGIN
    SELECT message as Error;
END;
$$
DELIMITER ;

# ------------------------------------------ message ------------------------------------------
DROP PROCEDURE IF EXISTS message;
DELIMITER $$
CREATE PROCEDURE message(
    IN message VARCHAR(200)
)
BEGIN
    SELECT message as 'Message';
END;
$$
DELIMITER ;

# ------------------------------------------ crearCarrera ------------------------------------------
DROP PROCEDURE IF EXISTS crearCarrera;
DELIMITER $$
CREATE PROCEDURE crearCarrera(
    IN nombre VARCHAR(100)
)
procCarrera:BEGIN
    DECLARE id INT;

    SET id = (SELECT getLastIdCarrera());


    IF id IS NULL THEN
        SET id = 0;
    ELSE
        SET id = id + 1;
    END IF;

    IF validarTexto(nombre) = FALSE THEN
        CALL errMessage('El nombre de la carrera deber ser de tipo texto y no puede estar vacío');
        LEAVE procCarrera;
    END IF;

    IF nombreCarreraNoRepetido(nombre) = TRUE THEN
        CALL errMessage('La carrera con ese nombre ya existe');
        LEAVE procCarrera;
    END IF;

    INSERT INTO CARRERA VALUES(id, nombre);
    CALL message(CONCAT('Carrera ', nombre, ' creada exitosamente'));
END;
$$
DELIMITER ;

# ------------------------------------------ registrarEstudiante ------------------------------------------
DROP PROCEDURE IF EXISTS registrarEstudiante;
DELIMITER $$
CREATE PROCEDURE registrarEstudiante(
    IN carnet BIGINT,
    IN nombre VARCHAR(100),
    IN apellido VARCHAR(100),
    IN fecha_nac VARCHAR(10),
    IN correo VARCHAR(100),
    IN telefono INT,
    IN direccion VARCHAR(150),
    IN dpi BIGINT,
    IN idCarrera INT
)
procRegistrarEstudiante:BEGIN

    DECLARE fnac DATE;

    # ------------------------------------- validacionesDeCampos -------------------------------------
    IF validarCarnet(carnet) = FALSE THEN
        CALL errMessage('El carnet debe tener 9 dígitos');
        LEAVE procRegistrarEstudiante;
    ELSEIF validarTexto(nombre) = FALSE THEN
        CALL errMessage('El nombre debe ser de tipo texto y no puede estar vacío');
        LEAVE procRegistrarEstudiante;
    ELSEIF validarTexto(apellido) = FALSE THEN
        CALL errMessage('El apellido debe ser de tipo texto y no puede estar vacío');
        LEAVE procRegistrarEstudiante;
    ELSEIF validarFecha(fecha_nac) = FALSE THEN
        CALL errMessage('La fecha de nacimiento debe ser de tipo fecha con el formato DD-MM-YY y no puede estar vacío');
        LEAVE procRegistrarEstudiante;
    ELSEIF validarCorreo(correo) = FALSE THEN
        CALL errMessage('El correo debe ser de tipo correo y no puede estar vacío');
        LEAVE procRegistrarEstudiante;
    ELSEIF validarTelefono(telefono) = FALSE THEN
        CALL errMessage('El telefono debe ser de tipo numérico de al menos 8 dígitos y no puede estar vacío');
        LEAVE procRegistrarEstudiante;
    ELSEIF validarTexto(direccion) = FALSE THEN
        CALL errMessage('La direccion debe ser de tipo texto y no puede estar vacío');
        LEAVE procRegistrarEstudiante;
    ELSEIF validarDPI(dpi) = FALSE THEN
        CALL errMessage('El DPI debe ser de tipo numérico de 13 dígitos y no puede estar vacío');
        LEAVE procRegistrarEstudiante;
    ELSEIF validarNumero(idCarrera) = FALSE THEN
        CALL errMessage('El id de la carrera debe ser un número entero positivo y no puede estar vacío');
        LEAVE procRegistrarEstudiante;
    END IF;

    # ------------------------------------- validacionesDeRegistros -------------------------------------
    IF verificarCarnet(carnet) = TRUE THEN
        CALL errMessage('Ya existe un estudiante asociado a ese carnet');
        LEAVE procRegistrarEstudiante;
    ELSEIF verificarDPIEsudiante(dpi) = TRUE THEN
        CALL errMessage('Ya existe un estudiante asociado a ese DPI');
        LEAVE procRegistrarEstudiante;
    ELSEIF verificarCarrera(idCarrera) = FALSE THEN
        CALL errMessage('No existe una carrera asociada al id ingresado');
        LEAVE procRegistrarEstudiante;
    END IF;

    SET fnac = STR_TO_DATE(fecha_nac, '%d-%m-%Y');

    INSERT INTO ESTUDIANTE (carnet, nombre, apellido, fecha_nac, correo, telefono, direccion, dpi, fecha_ingreso, id_carrera)
    VALUES (carnet, nombre, apellido, fnac, correo, telefono, direccion, dpi, CURDATE(), idCarrera);

    CALL message(CONCAT('Estudiante ', carnet, ' ', nombre, ' registrado exitosamente'));
END;
$$
DELIMITER ;

# ------------------------------------------ registrarDocente ------------------------------------------
DROP PROCEDURE IF EXISTS registrarDocente;
DELIMITER $$
CREATE PROCEDURE registrarDocente(
    IN nombre VARCHAR(100),
    IN apellido VARCHAR(100),
    IN fecha_nac VARCHAR(10),
    IN correo VARCHAR(100),
    IN telefono INT,
    IN direccion VARCHAR(150),
    IN dpi BIGINT,
    IN siff BIGINT
)
procRegistrarDocente:BEGIN

    DECLARE fnac DATE;

    # ------------------------------------- validacionesDeCampos -------------------------------------
    IF validarTexto(nombre) = FALSE THEN
        CALL errMessage('El nombre debe ser de tipo texto y no puede estar vacío');
        LEAVE procRegistrarDocente;
    ELSEIF validarTexto(apellido) = FALSE THEN
        CALL errMessage('El apellido debe ser de tipo texto y no puede estar vacío');
        LEAVE procRegistrarDocente;
    ELSEIF validarFecha(fecha_nac) = FALSE THEN
        CALL errMessage('La fecha de nacimiento debe ser de tipo fecha con el formato DD-MM-YY y no puede estar vacío');
        LEAVE procRegistrarDocente;
    ELSEIF validarCorreo(correo) = FALSE THEN
        CALL errMessage('El correo debe ser de tipo correo y no puede estar vacío');
        LEAVE procRegistrarDocente;
    ELSEIF validarTelefono(telefono) = FALSE THEN
        CALL errMessage('El telefono debe ser de tipo numérico de al menos 8 dígitos y no puede estar vacío');
        LEAVE procRegistrarDocente;
    ELSEIF validarTexto(direccion) = FALSE THEN
        CALL errMessage('La dirección debe ser de tipo texto y no puede estar vacío');
        LEAVE procRegistrarDocente;
    ELSEIF validarDPI(dpi) = FALSE THEN
        CALL errMessage('El DPI debe ser de tipo numérico de 13 dígitos y no puede estar vacío');
        LEAVE procRegistrarDocente;
    ELSEIF validarSIFF(siff) = FALSE THEN
        CALL errMessage('El SIFF debe ser de tipo numérico y no puede estar vacío');
        LEAVE procRegistrarDocente;
    END IF;

    # ------------------------------------- validacionesDeRegistros -------------------------------------
    IF verificarDPIDocente(dpi) = TRUE THEN
        CALL errMessage('Ya existe un docente asociado a ese DPI');
        LEAVE procRegistrarDocente;
    ELSEIF verificarSIFF(siff) = TRUE THEN
        CALL errMessage('Ya existe un docente asociado a ese SIFF');
        LEAVE procRegistrarDocente;
    END IF;

    SET fnac = STR_TO_DATE(fecha_nac, '%d-%m-%Y');

    INSERT INTO DOCENTE (nombre, apellido, fecha_nac, correo, telefono, direccion, dpi, siff_docente, fecha_ingreso)
    VALUES (nombre, apellido, fnac, correo, telefono, direccion, dpi, siff, CURDATE());

    CALL message(CONCAT('Docente ', siff, ' ', nombre, ' registrado exitosamente'));

END;
$$
DELIMITER ;

# ------------------------------------------ crearCurso ------------------------------------------
DROP PROCEDURE IF EXISTS crearCurso;
DELIMITER $$
CREATE PROCEDURE crearCurso(
    IN codigo_curso BIGINT,
    IN nombre VARCHAR(150),
    IN creditos_necesarios INT,
    IN creditos_otorga INT,
    IN idCarrera INT,
    IN obligatorio BOOLEAN
)
procCrearCurso:BEGIN

    # ------------------------------------- validacionesDeCampos -------------------------------------
    IF validarNombreCurso(nombre) = FALSE THEN
        CALL errMessage('El nombre debe ser de tipo texto y no puede estar vacío');
        LEAVE procCrearCurso;
    ELSEIF validarNumeroCon0(creditos_necesarios) = FALSE THEN
        CALL errMessage('Los créditos necesarios puede ser 0 o un entero positivo');
        LEAVE procCrearCurso;
    ELSEIF validarNumeroCon0(creditos_otorga) = FALSE THEN
        CALL errMessage('Los créditos que otorga puede ser 0 o un entero positivo');
        LEAVE procCrearCurso;
    ELSEIF validarNumeroCon0(idCarrera) = FALSE THEN
        CALL errMessage('El id de la carrera puede ser 0 (área común) o un entero positivo');
        LEAVE procCrearCurso;
    ELSEIF validarBooleano(obligatorio) = FALSE THEN
        CALL errMessage('El campo obligatorio debe ser de tipo booleano *0=no, 1=sí, no puede estar vacío');
        LEAVE procCrearCurso;
    END IF;

    # ------------------------------------- validacionesDeRegistros -------------------------------------
    IF verificarCurso(codigo_curso) = TRUE THEN
        CALL errMessage('Ya existe un curso asociado a ese código');
        LEAVE procCrearCurso;
    ELSEIF verificarNombreCurso(nombre) = TRUE THEN
        CALL errMessage('Ya existe un curso asociado a ese nombre');
        LEAVE procCrearCurso;
    ELSEIF verificarCarrera(idCarrera) = FALSE THEN
        CALL errMessage('No existe una carrera asociada al id ingresado');
        LEAVE procCrearCurso;
    END IF;

    INSERT INTO CURSO (codigo_curso, nombre, creditos_necesarios, creditos_acredita, id_carrera, obligatorio)
    VALUES (codigo_curso, nombre, creditos_necesarios, creditos_otorga, idCarrera, obligatorio);

    CALL message(CONCAT('Curso ', codigo_curso, ': ', nombre, ' registrado exitosamente'));

END;
$$
DELIMITER ;