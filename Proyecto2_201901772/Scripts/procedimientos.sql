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
    IN siff_docente BIGINT
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
    ELSEIF validarSIFF(siff_docente) = FALSE THEN
        CALL errMessage('El SIFF debe ser de tipo numérico y no puede estar vacío');
        LEAVE procRegistrarDocente;
    END IF;

    # ------------------------------------- validacionesDeRegistros -------------------------------------
    IF verificarDPIDocente(dpi) = TRUE THEN
        CALL errMessage('Ya existe un docente asociado a ese DPI');
        LEAVE procRegistrarDocente;
    ELSEIF verificarSIFF(siff_docente) = TRUE THEN
        CALL errMessage('Ya existe un docente asociado a ese SIFF');
        LEAVE procRegistrarDocente;
    END IF;

    SET fnac = STR_TO_DATE(fecha_nac, '%d-%m-%Y');

    INSERT INTO DOCENTE (nombre, apellido, fecha_nac, correo, telefono, direccion, dpi, siff_docente, fecha_ingreso)
    VALUES (nombre, apellido, fnac, correo, telefono, direccion, dpi, siff_docente, CURDATE());

    CALL message(CONCAT('Docente ', siff_docente, ' ', nombre, ' registrado exitosamente'));

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

# ----------------------------------------------- habilitarCurso -----------------------------------------------
DROP PROCEDURE IF EXISTS habilitarCurso;
DELIMITER $$
CREATE PROCEDURE habilitarCurso(
    IN codigo_curso BIGINT,
    IN ciclo VARCHAR(2),
    IN siff_docente BIGINT,
    IN cupo_maximo INT,
    IN seccion CHAR(1)
)
procHabilitarCurso:BEGIN

    DECLARE idCicloCurso INT;

    # ------------------------------------- validacionesDeCampos -------------------------------------
    IF validarCiclo(ciclo) = FALSE THEN
        CALL errMessage('El ciclo solo acepta valores 1S, 2S, VJ, VD, el campoo no puede estar vacío');
        LEAVE procHabilitarCurso;
    ELSEIF validarSIFF(siff_docente) = FALSE THEN
        CALL errMessage('El siff_docente debe ser de tipo numérico y no puede estar vacío');
        LEAVE procHabilitarCurso;
    ELSEIF validarNumero(cupo_maximo) = FALSE THEN
        CALL errMessage('El cupo máximo debe ser un número entero positivo');
        LEAVE procHabilitarCurso;
    ELSEIF validarSeccion(seccion) = FALSE THEN
        CALL errMessage('La sección solo acepta un caracter entre A-Z, el campo no puede estar vacío');
        LEAVE procHabilitarCurso;
    END IF;

    # ------------------------------------- validacionesDeRegistros -------------------------------------
    IF verificarCurso(codigo_curso) = FALSE THEN
        CALL errMessage('No existe un curso asociado al código ingresado');
        LEAVE procHabilitarCurso;
    ELSEIF verificarSIFF(siff_docente) = FALSE THEN
        CALL errMessage('No existe un docente asociado al SIFF ingresado');
        LEAVE procHabilitarCurso;
    ELSEIF verificarSeccion(codigo_curso, ciclo, seccion) = TRUE THEN
        CALL errMessage('Ya existe un curso asociado a la sección ingresada');
        LEAVE procHabilitarCurso;
    END IF;

    SET idCicloCurso = (SELECT getIdCicloAnio(ciclo));
    IF idCicloCurso IS NULL OR idCicloCurso = -1 THEN
        CALL errMessage('No existe un ciclo asociado al ciclo ingresado');
        LEAVE procHabilitarCurso;
    END IF;

    INSERT INTO CURSO_HABILITADO (id_ciclo_anio, cupo_maximo, seccion, siff_docente, codigo_curso)
    VALUES (idCicloCurso, cupo_maximo, seccion, siff_docente, codigo_curso);

    CALL message(CONCAT('Curso ', codigo_curso, ' sección ', seccion, ' habilitado exitosamente'));

END;
$$
DELIMITER ;

# ------------------------------------------ agregarHorario ------------------------------------------
DROP PROCEDURE IF EXISTS agregarHorario;
DELIMITER $$
CREATE PROCEDURE agregarHorario(
    IN idCursoHabilitado INT,
    IN dia INT,
    IN horario VARCHAR(11)
)
procAgregarHorario:BEGIN

    DECLARE horaInicio VARCHAR(5);
    DECLARE horaFinal VARCHAR(5);

    # ------------------------------------- validacionesDeCampos -------------------------------------
    IF validarNumero(idCursoHabilitado) = FALSE THEN
        CALL errMessage('El id_curso_habilitado debe ser un número entero positivo');
        LEAVE procAgregarHorario;
    ELSEIF validarDia(dia) = FALSE THEN
        CALL errMessage('El día debe ser un número entero entre 1 y 7');
        LEAVE procAgregarHorario;
    ELSEIF validarHorario(HORARIO) = FALSE THEN
        CALL errMessage('El horario debe ser de tipo texto con el formato HH:MM-HH:MM teniendo una diferencia horaria, el campo no puede estar vacío');
        LEAVE procAgregarHorario;
    END IF;

    # ------------------------------------- validacionesDeRegistros -------------------------------------
    IF verificarCursoHabilitado(idCursoHabilitado) = FALSE THEN
        CALL errMessage('No existe un curso habilitado asociado al id ingresado');
        LEAVE procAgregarHorario;
    ELSEIF verificarMismoHoraio(idCursoHabilitado, dia, horario) = TRUE THEN
        CALL errMessage('El curso habilitado ya tiene un horario asociado al día y horario ingresado');
        LEAVE procAgregarHorario;
    ELSEIF verificarTraslapeHorario(idCursoHabilitado, dia, horario) = TRUE THEN
        CALL errMessage('El horario que ingresó posee un traslape con un horario similar en el mismo dia');
        LEAVE procAgregarHorario;
    END IF;

    SET horaInicio = SUBSTRING_INDEX(horario, '-', 1);
    SET horaFinal = SUBSTRING_INDEX(horario, '-', -1);

    INSERT INTO HORARIO_CURSO (dia_semana, hora_inicio, hora_final, id_curso_habilitado)
    VALUES (dia, horaInicio, horaFinal, idCursoHabilitado);

    CALL message(CONCAT('Horario ', horario, ' agregado al curso habilitado id: ', idCursoHabilitado ,' exitosamente'));

END;
$$
DELIMITER ;