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

    INSERT INTO ASIGNADOS_CURSO_HABILITADO (id_curso_habilitado) VALUES (LAST_INSERT_ID());

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

# ------------------------------------------ asignarCurso ------------------------------------------
DROP PROCEDURE IF EXISTS asignarCurso;
DELIMITER $$
CREATE PROCEDURE asignarCurso(
    IN codigoCurso BIGINT,
    IN ciclo VARCHAR(2),
    IN seccion CHAR(1),
    IN carnetEstudiante BIGINT
)
procAsignarCurso:BEGIN

    DECLARE idCursoHabilitado INT;

    # ------------------------------------- validacionesDeCampos -------------------------------------
    IF validarCiclo(ciclo) = FALSE THEN
        CALL errMessage('El ciclo solo acepta valores 1S, 2S, VJ, VD, el campoo no puede estar vacío');
        LEAVE procAsignarCurso;
    ELSEIF validarSeccion(seccion) = FALSE THEN
        CALL errMessage('La sección solo acepta un caracter entre A-Z, el campo no puede estar vacío');
        LEAVE procAsignarCurso;
    ELSEIF validarCarnet(carnetEstudiante) = FALSE THEN
        CALL errMessage('El carnet debe tener 9 dígitos');
        LEAVE procAsignarCurso;
    END IF;

    # ------------------------------------- validacionesDeRegistros -------------------------------------
    IF verificarCurso(codigoCurso) = FALSE THEN
        CALL errMessage('No existe un curso asociado al código ingresado');
        LEAVE procAsignarCurso;
    ELSEIF verificarCiclo(codigoCurso, ciclo) = FALSE THEN
        CALL errMessage('No existe un curso habilitado asociado al ciclo ingresado');
        LEAVE procAsignarCurso;
    ELSEIF verificarSeccion(codigoCurso, ciclo, seccion) = FALSE THEN
        CALL errMessage('No existe un curso habilitado asociado a la sección ingresada');
        LEAVE procAsignarCurso;
    ELSEIF verificarCarnet(carnetEstudiante) = FALSE THEN
        CALL errMessage('No existe un estudiante asociado al carnet ingresado');
        LEAVE procAsignarCurso;
    ELSEIF verificarCursoAsignadoMismaSeccion(carnetEstudiante, codigoCurso, ciclo, seccion) = TRUE THEN
        CALL errMessage('El estudiante ya esta asignado al curso en la misma sección');
        LEAVE procAsignarCurso;
    ELSEIF verificarCursoAsignadoDiferenteSeccion(carnetEstudiante, codigoCurso, ciclo) = TRUE THEN
        CALL errMessage('El estudiante ya esta asignado al curso en una sección diferente');
        LEAVE procAsignarCurso;
    ELSEIF verificarCursoDesasignado(carnetEstudiante, codigoCurso, ciclo) = TRUE THEN
        CALL errMessage('No se puede asignar el curso porque el estudiante ya se lo desasignó para este ciclo');
        LEAVE procAsignarCurso;
    ELSEIF verificarCreditosEstudianteCurso(carnetEstudiante, codigoCurso) = FALSE THEN
        CALL errMessage('No se puede asignar el curso porque el estudiante no posee los créditos necesarios para asignarse el curso');
        LEAVE procAsignarCurso;
    ELSEIF verificarCursoCarrera(carnetEstudiante, codigoCurso) = FALSE THEN
        CALL errMessage('No se puede asignar el curso porque el estudiante no pertenece a la carrera del curso');
        LEAVE procAsignarCurso;
    ELSEIF verificarCupoCurso(codigoCurso, ciclo, seccion) = FALSE THEN
        CALL errMessage('No se puede asignar el curso porque el cupo máximo ya fue alcanzado');
        LEAVE procAsignarCurso;
    ELSEIF verificarCursoAprobado(carnetEstudiante, codigoCurso) = TRUE THEN
        CALL errMessage('No se puede asignar el curso porque el estudiante ya lo aprobó');
        LEAVE procAsignarCurso;
    END IF;

    SET idCursoHabilitado = (SELECT getIdCursoHabilitado(codigoCurso, ciclo, seccion));

    IF idCursoHabilitado IS NULL OR idCursoHabilitado = -1 THEN
        CALL errMessage('No existe un curso habilitado asociado al ciclo y sección ingresados');
        LEAVE procAsignarCurso;
    END IF;

    IF verificarAsociacionHorarios(idCursoHabilitado) = FALSE THEN
        CALL errMessage('No se puedo asignar, debido a que no se han agregado horarios al curso habilitado');
        LEAVE procAsignarCurso;
    END IF;

    INSERT INTO ASIGNACION_CURSO (id_curso_habilitado, carnet)
    VALUES (idCursoHabilitado, carnetEstudiante);

    CALL incrementarCantidadAsignadosCurso(idCursoHabilitado, 1);

    CALL message(CONCAT('Se ha asignado el estudiante ', carnetEstudiante, ' al curso ', codigoCurso, ' sección ', seccion, ' exitosamente'));
END;
$$
DELIMITER ;

# -------------------------------------------- incrementarCantidadAsignadosCurso --------------------------------------
DROP PROCEDURE IF EXISTS incrementarCantidadAsignadosCurso;
DELIMITER $$
CREATE PROCEDURE incrementarCantidadAsignadosCurso(
    IN idCursoHabilitado INT,
    IN decr INT
)
procIncrementarCantidadAsignadosCurso:BEGIN

    UPDATE ASIGNADOS_CURSO_HABILITADO SET cantidad = cantidad + decr WHERE id_curso_habilitado = idCursoHabilitado;

END;
$$
DELIMITER ;

# ------------------------------------------ desasignarCurso ------------------------------------------
DROP PROCEDURE IF EXISTS desasignarCurso;
DELIMITER $$
CREATE PROCEDURE desasignarCurso(
    IN codigoCurso BIGINT,
    IN ciclo VARCHAR(2),
    IN seccion CHAR(1),
    IN carnetEstudiante BIGINT
)
procDesasignarCurso:BEGIN

    DECLARE idCursoHabilitado INT;

    # ------------------------------------- validacionesDeCampos -------------------------------------
    IF validarCiclo(ciclo) = FALSE THEN
        CALL errMessage('El ciclo solo acepta valores 1S, 2S, VJ, VD, el campoo no puede estar vacío');
        LEAVE procDesasignarCurso;
    ELSEIF validarSeccion(seccion) = FALSE THEN
        CALL errMessage('La sección solo acepta un caracter entre A-Z, el campo no puede estar vacío');
        LEAVE procDesasignarCurso;
    ELSEIF validarCarnet(carnetEstudiante) = FALSE THEN
        CALL errMessage('El carnet debe tener 9 dígitos');
        LEAVE procDesasignarCurso;
    END IF;

    # ------------------------------------- validacionesDeRegistros -------------------------------------
    IF verificarCurso(codigoCurso) = FALSE THEN
        CALL errMessage('No existe un curso asociado al código ingresado');
        LEAVE procDesasignarCurso;
    ELSEIF verificarCiclo(codigoCurso, ciclo) = FALSE THEN
        CALL errMessage('No existe un curso habilitado asociado al ciclo ingresado');
        LEAVE procDesasignarCurso;
    ELSEIF verificarSeccion(codigoCurso, ciclo, seccion) = FALSE THEN
        CALL errMessage('No existe un curso habilitado asociado a la sección ingresada');
        LEAVE procDesasignarCurso;
    ELSEIF verificarCarnet(carnetEstudiante) = FALSE THEN
        CALL errMessage('No existe un estudiante asociado al carnet ingresado');
        LEAVE procDesasignarCurso;
    ELSEIF verificarCursoDesasignado(carnetEstudiante, codigoCurso, ciclo) = TRUE THEN
        CALL errMessage('No se puede desasignar el curso porque el estudiante ya se lo desasignó para este ciclo');
        LEAVE procDesasignarCurso;
    ELSEIF verificarCursoAsignadoDiferenteSeccion(carnetEstudiante, codigoCurso, ciclo) = FALSE THEN
        CALL errMessage('El estudiante no se encuentra asignado al curso');
        LEAVE procDesasignarCurso;
    ELSEIF verificarCursoAsignadoMismaSeccion(carnetEstudiante, codigoCurso, ciclo, seccion) = FALSE THEN
        CALL errMessage('El estudiante no se encuentra asignado al curso en la sección ingresada');
        LEAVE procDesasignarCurso;
    ELSEIF verificarCursoAprobado(carnetEstudiante, codigoCurso) = TRUE THEN
        CALL errMessage('No se puede desasignar el curso porque el estudiante ya lo aprobó');
        LEAVE procDesasignarCurso;
    ELSEIF verificarEstudianteConNota(carnetEstudiante, codigoCurso, ciclo, seccion) = TRUE THEN
        CALL errMessage('No se puede desasignar el curso porque el estudiante ya tiene una nota ingresada');
        LEAVE procDesasignarCurso;
    END IF;

    SET idCursoHabilitado = (SELECT getIdCursoHabilitado(codigoCurso, ciclo, seccion));

    IF idCursoHabilitado IS NULL OR idCursoHabilitado = -1 THEN
        CALL errMessage('No existe un curso habilitado asociado al ciclo y sección ingresados');
        LEAVE procDesasignarCurso;
    END IF;

    UPDATE ASIGNACION_CURSO SET estado = 0 WHERE id_curso_habilitado = idCursoHabilitado AND carnet = carnetEstudiante;

    CALL incrementarCantidadAsignadosCurso(idCursoHabilitado, -1);

    CALL message(CONCAT('Se ha desasignado el estudiante ', carnetEstudiante, ' del curso ', codigoCurso, ' sección ', seccion, ' exitosamente'));
END;
$$
DELIMITER ;

# ------------------------------------------ ingresarNota ------------------------------------------------------------
DROP PROCEDURE IF EXISTS ingresarNota;
DELIMITER $$
CREATE PROCEDURE ingresarNota(
    IN codigoCurso BIGINT,
    IN ciclo VARCHAR(2),
    IN seccion CHAR(1),
    IN carnetEstudiante BIGINT,
    IN nota INT
)
procIngresarNota:BEGIN

    DECLARE idCursoHabilitado INT;
    DECLARE idAsignacion INT;

    # ------------------------------------- validacionesDeCampos -------------------------------------
    IF validarCiclo(ciclo) = FALSE THEN
        CALL errMessage('El ciclo solo acepta valores 1S, 2S, VJ, VD, el campoo no puede estar vacío');
        LEAVE procIngresarNota;
    ELSEIF validarSeccion(seccion) = FALSE THEN
        CALL errMessage('La sección solo acepta un caracter entre A-Z, el campo no puede estar vacío');
        LEAVE procIngresarNota;
    ELSEIF validarCarnet(carnetEstudiante) = FALSE THEN
        CALL errMessage('El carnet debe tener 9 dígitos');
        LEAVE procIngresarNota;
    ELSEIF validarNota(nota) = FALSE THEN
        CALL errMessage('La nota debe ser un número entero entre 0 y 100');
        LEAVE procIngresarNota;
    END IF;

    # ------------------------------------- validacionesDeRegistros -------------------------------------
    IF verificarCurso(codigoCurso) = FALSE THEN
        CALL errMessage('No existe un curso asociado al código ingresado');
        LEAVE procIngresarNota;
    ELSEIF verificarCiclo(codigoCurso, ciclo) = FALSE THEN
        CALL errMessage('No existe un curso habilitado asociado al ciclo ingresado');
        LEAVE procIngresarNota;
    ELSEIF verificarSeccion(codigoCurso, ciclo, seccion) = FALSE THEN
        CALL errMessage('No existe un curso habilitado asociado a la sección ingresada');
        LEAVE procIngresarNota;
    ELSEIF verificarCarnet(carnetEstudiante) = FALSE THEN
        CALL errMessage('No existe un estudiante asociado al carnet ingresado');
        LEAVE procIngresarNota;
    ELSEIF verificarCursoAsignadoDiferenteSeccion(carnetEstudiante, codigoCurso, ciclo) = FALSE THEN
        CALL errMessage('El estudiante no se encuentra asignado al curso');
        LEAVE procIngresarNota;
    ELSEIF verificarCursoAsignadoMismaSeccion(carnetEstudiante, codigoCurso, ciclo, seccion) = FALSE THEN
        CALL errMessage('El estudiante no se encuentra asignado al curso en la sección ingresada');
        LEAVE procIngresarNota;
    ELSEIF verificarCursoDesasignado(carnetEstudiante, codigoCurso, ciclo) = TRUE THEN
        CALL errMessage('No se puede ingresar la nota porque el estudiante ya se lo desasignó el curso para este ciclo');
        LEAVE procIngresarNota;
    ELSEIF verificarNotaIngresada(carnetEstudiante, codigoCurso, ciclo, seccion) = TRUE THEN
        CALL errMessage('El estudiante ya tiene una nota ingresada para el curso en el ciclo ingresado');
        LEAVE procIngresarNota;
    END IF;

    SET idCursoHabilitado = (SELECT getIdCursoHabilitado(codigoCurso, ciclo, seccion));

    IF idCursoHabilitado IS NULL OR idCursoHabilitado = -1 THEN
        CALL errMessage('No existe un curso habilitado asociado al ciclo y sección ingresados');
        LEAVE procIngresarNota;
    END IF;

    SET idAsignacion = (SELECT id_asignacion FROM ASIGNACION_CURSO WHERE id_curso_habilitado = idCursoHabilitado AND carnet = carnetEstudiante);

    IF idAsignacion IS NULL OR idAsignacion = -1 THEN
        CALL errMessage('No existe una asignación asociada al curso habilitado y estudiante ingresados');
        LEAVE procIngresarNota;
    END IF;

    IF nota >= 61 THEN
        SELECT creditos_acredita INTO @creditos FROM CURSO WHERE codigo_curso = codigoCurso;
        UPDATE ESTUDIANTE SET creditos = creditos + @creditos WHERE carnet = carnetEstudiante;
        INSERT INTO NOTA (nota, id_asignacion) VALUES (nota, idAsignacion);
    ELSE
        INSERT INTO NOTA (nota, id_asignacion) VALUES (nota, idAsignacion);
    END IF;

    CALL message(CONCAT('Se ha ingresado la nota ', nota, ' al estudiante ', carnetEstudiante, ' del curso ', codigoCurso, ' sección ', seccion, ' exitosamente'));

END;
$$
DELIMITER ;

# ------------------------------------------ generarActa ------------------------------------------------------------
DROP PROCEDURE IF EXISTS generarActa;
DELIMITER $$
CREATE PROCEDURE generarActa(
    IN codigoCurso BIGINT,
    IN ciclo VARCHAR(2),
    IN seccion CHAR(1)
)
procGenerarActa:BEGIN

    DECLARE idCursoHabilitado INT;

    # ------------------------------------- validacionesDeCampos -------------------------------------
    IF validarCiclo(ciclo) = FALSE THEN
        CALL errMessage('El ciclo solo acepta valores 1S, 2S, VJ, VD, el campoo no puede estar vacío');
        LEAVE procGenerarActa;
    ELSEIF validarSeccion(seccion) = FALSE THEN
        CALL errMessage('La sección solo acepta un caracter entre A-Z, el campo no puede estar vacío');
        LEAVE procGenerarActa;
    END IF;

    # ------------------------------------- validacionesDeRegistros -------------------------------------
    IF verificarCurso(codigoCurso) = FALSE THEN
        CALL errMessage('No existe un curso asociado al código ingresado');
        LEAVE procGenerarActa;
    ELSEIF verificarCiclo(codigoCurso, ciclo) = FALSE THEN
        CALL errMessage('No existe un curso habilitado asociado al ciclo ingresado');
        LEAVE procGenerarActa;
    ELSEIF verificarSeccion(codigoCurso, ciclo, seccion) = FALSE THEN
        CALL errMessage('No existe un curso habilitado asociado a la sección ingresada');
        LEAVE procGenerarActa;
    ELSEIF verificarNotasIngresadas(codigoCurso, ciclo, seccion) = FALSE THEN
        CALL errMessage('No se puede generar el acta porque no se han ingresado todas las notas correpondientes a los estudiantes asignados al curso');
        LEAVE procGenerarActa;
    END IF;

    SET idCursoHabilitado = (SELECT getIdCursoHabilitado(codigoCurso, ciclo, seccion));

    IF idCursoHabilitado IS NULL OR idCursoHabilitado = -1 THEN
        CALL errMessage('No existe un curso habilitado asociado al ciclo y sección ingresados');
        LEAVE procGenerarActa;
    END IF;

    IF EXISTS(SELECT * FROM ACTA WHERE id_curso_habilitado = idCursoHabilitado) THEN
        CALL errMessage('Ya existe un acta asociada al curso habilitado con la sección y ciclo ingresados');
        LEAVE procGenerarActa;
    END IF;

    INSERT INTO ACTA (id_curso_habilitado, fecha, hora) VALUES (idCursoHabilitado, CURDATE(), CURTIME());

    CALL message(CONCAT('Se ha generado el acta del curso ', codigoCurso, ' sección ', seccion, ' exitosamente'));

END;
$$
DELIMITER ;