CREATE DATABASE IF NOT EXISTS proyecto1;

USE proyecto1;

CREATE TEMPORARY TABLE tmpCiudadanos (
    dpi VARCHAR(13) NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    apellido VARCHAR(30) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    telefono VARCHAR(10) NOT NULL,
    edad INTEGER NOT NULL,
    genero VARCHAR(1) NOT NULL
);

CREATE TEMPORARY TABLE tmpCargos (
    id INTEGER NOT NULL,
    cargo VARCHAR(40) NOT NULL
);

CREATE TEMPORARY TABLE tmpDepartamentos (
    id INTEGER NOT NULL,
    nombre VARCHAR(20) NOT NULL
);

CREATE TEMPORARY TABLE tmpPartidos (
    id_partido INTEGER NOT NULL,
    nombrePartido VARCHAR(50) NOT NULL,
    siglas VARCHAR(20) NOT NULL,
    fundacion DATE NOT NULL
);

CREATE TEMPORARY TABLE tmpCandidatos (
    id INTEGER NOT NULL,
    nombres VARCHAR(50) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    partido_id INTEGER NOT NULL,
    cargo_id INTEGER NOT NULL
);

CREATE TEMPORARY TABLE tmpMesas (
    id_mesa INTEGER NOT NULL,
    id_departamento INTEGER NOT NULL
);

CREATE TEMPORARY TABLE tmpVotaciones (
    id_voto INTEGER NOT NULL,
    id_candidato INTEGER NOT NULL,
    dpi_ciudadano VARCHAR(13) NOT NULL,
    mesa_id INTEGER NOT NULL,
    fecha_hora DATETIME NOT NULL
);