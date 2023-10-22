DROP DATABASE IF EXISTS SISTEMA_CONTROL_FIUSAC;
CREATE DATABASE IF NOT EXISTS SISTEMA_CONTROL_FIUSAC;
USE SISTEMA_CONTROL_FIUSAC;

# ------------------------------------------------------ HISTORIAL_TRANSACCIONES --------------------------------------
DROP TABLE IF EXISTS HISTORIAL_TRANSACCIONES;
CREATE TABLE HISTORIAL_TRANSACCIONES (
    id_transaccion INT NOT NULL AUTO_INCREMENT,
    fecha_hora TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    descripcion VARCHAR(150) NOT NULL,
    tipo VARCHAR(10) NOT NULL,
    PRIMARY KEY (id_transaccion)
);

# ------------------------------------------------------ CARRERA ------------------------------------------------------
DROP TABLE IF EXISTS CARRERA;
CREATE TABLE CARRERA (
    id_carrera INT NOT NULL, -- El autoincremental se hace en el procedimiento almacenado
    nombre VARCHAR(100) NOT NULL,
    PRIMARY KEY (id_carrera)
);

# ------------------------------------------------------ ESTUDIANTE ---------------------------------------------------
DROP TABLE IF EXISTS ESTUDIANTE;
CREATE TABLE ESTUDIANTE (
    carnet BIGINT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    fecha_nac DATE NOT NULL,
    correo VARCHAR(100) NOT NULL,
    telefono INT NOT NULL,
    direccion VARCHAR(130) NOT NULL,
    dpi BIGINT NOT NULL,
    creditos INT NOT NULL DEFAULT 0,
    fecha_ingreso DATE NOT NULL,
    id_carrera INT NOT NULL,
    PRIMARY KEY (carnet),
    FOREIGN KEY (id_carrera) REFERENCES CARRERA(id_carrera)
);

# ------------------------------------------------------ DOCENTE -----------------------------------------------------
DROP TABLE IF EXISTS DOCENTE;
CREATE TABLE DOCENTE (
    siff_docente BIGINT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    fecha_nac DATE NOT NULL,
    correo VARCHAR(100) NOT NULL,
    telefono INT NOT NULL,
    direccion VARCHAR(130) NOT NULL,
    dpi BIGINT NOT NULL,
    fecha_ingreso DATE NOT NULL,
    PRIMARY KEY (siff_docente)
);

# ------------------------------------------------------ CURSO -------------------------------------------------------
DROP TABLE IF EXISTS CURSO;
CREATE TABLE CURSO (
    codigo_curso BIGINT NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    creditos_necesarios INT NOT NULL,
    creditos_acredita INT NOT NULL,
    obligatorio BOOLEAN NOT NULL,
    id_carrera INT NOT NULL,
    PRIMARY KEY (codigo_curso),
    FOREIGN KEY (id_carrera) REFERENCES CARRERA(id_carrera)
);

# ------------------------------------------------------ CURSO_HABILITADO --------------------------------------------
DROP TABLE IF EXISTS CURSO_HABILITADO;
CREATE TABLE CURSO_HABILITADO (
    id_curso_habilitado INT NOT NULL AUTO_INCREMENT,
    ciclo VARCHAR(2) NOT NULL,
    cupo_maximo INT NOT NULL,
    seccion CHAR(1) NOT NULL,
    anio YEAR NOT NULL,
    estudiantes_asignados INT NOT NULL DEFAULT 0,
    codigo_curso BIGINT NOT NULL,
    siff_docente BIGINT NOT NULL,
    PRIMARY KEY (id_curso_habilitado),
    FOREIGN KEY (codigo_curso) REFERENCES CURSO(codigo_curso),
    FOREIGN KEY (siff_docente) REFERENCES DOCENTE(siff_docente)
);

# ------------------------------------------------------ HORARIO_CURSO -----------------------------------------------
DROP TABLE IF EXISTS HORARIO_CURSO;
CREATE TABLE HORARIO_CURSO (
    id_horario_curso INT NOT NULL AUTO_INCREMENT,
    dia_semana TINYINT,
    hora_inicio VARCHAR(5),
    hora_final VARCHAR(5),
    id_curso_habilitado INT NOT NULL,
    PRIMARY KEY (id_horario_curso),
    FOREIGN KEY (id_curso_habilitado) REFERENCES CURSO_HABILITADO(id_curso_habilitado)
);

# ------------------------------------------------------ ASIGNACION_CURSO --------------------------------------------
DROP TABLE IF EXISTS ASIGNACION_CURSO;
CREATE TABLE ASIGNACION_CURSO (
    id_asignacion INT NOT NULL AUTO_INCREMENT,
    ciclo VARCHAR(2) NOT NULL,
    seccion CHAR(1) NOT NULL,
    anio YEAR NOT NULL,
    estado TINYINT NOT NULL DEFAULT 1,
    carnet BIGINT NOT NULL,
    codigo_curso BIGINT NOT NULL,
    PRIMARY KEY (id_asignacion),
    FOREIGN KEY (carnet) REFERENCES ESTUDIANTE(carnet),
    FOREIGN KEY (codigo_curso) REFERENCES CURSO_HABILITADO(codigo_curso)
);

# ------------------------------------------------------ NOTA --------------------------------------------------------
DROP TABLE IF EXISTS NOTA;
CREATE TABLE NOTA (
    id_nota INT NOT NULL AUTO_INCREMENT,
    ciclo VARCHAR(2) NOT NULL,
    seccion CHAR(1) NOT NULL,
    anio YEAR NOT NULL,
    nota INT NOT NULL DEFAULT 0,
    carnet BIGINT NOT NULL,
    codigo_curso BIGINT NOT NULL,
    PRIMARY KEY (id_nota),
    FOREIGN KEY (carnet) REFERENCES ASIGNACION_CURSO(carnet),
    FOREIGN KEY (codigo_curso) REFERENCES ASIGNACION_CURSO(codigo_curso)
);

# ------------------------------------------------------ ACTA --------------------------------------------------------
DROP TABLE IF EXISTS ACTA;
CREATE TABLE ACTA (
    id_acta INT NOT NULL AUTO_INCREMENT,
    ciclo VARCHAR(2) NOT NULL,
    seccion CHAR(1) NOT NULL,
    fecha_hora TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    codigo_curso BIGINT NOT NULL,
    PRIMARY KEY (id_acta),
    FOREIGN KEY (codigo_curso) REFERENCES CURSO_HABILITADO(codigo_curso)
);