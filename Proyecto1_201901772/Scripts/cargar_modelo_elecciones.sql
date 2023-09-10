-- Insertar datos en la tabla CIUDADANO
INSERT INTO CIUDADANO (dpi, nombre, apellido, direccion, telefono, edad, genero)
SELECT dpi, nombre, apellido, direccion, telefono, edad, genero
FROM tmpCiudadanos;

-- Insertar datos en la tabla CARGO
INSERT INTO CARGO (id_cargo, cargo)
SELECT id, cargo
FROM tmpCargos;

-- Insertar datos en la tabla DEPARTAMENTO
INSERT INTO DEPARTAMENTO (id_departamento, nombre)
SELECT id, nombre
FROM tmpDepartamentos;

-- Insertar datos en la tabla PARTIDO
INSERT INTO PARTIDO (id_partido, nombre, siglas, fundacion)
SELECT id_partido, nombrePartido, siglas, fundacion
FROM tmpPartidos;

-- Insertar datos en la tabla MESA
INSERT INTO MESA (id_mesa, id_departamento)
SELECT id_mesa, id_departamento
FROM tmpMesas;

-- Insertar datos en la tabla VOTO
INSERT INTO VOTO (id_voto, fecha_hora, dpi, id_mesa)
SELECT DISTINCT id_voto, fecha_hora, dpi_ciudadano, mesa_id
FROM tmpVotaciones;

-- Insertar datos en la tabla CANDIDATO
INSERT INTO CANDIDATO (id_candidato, nombre, fecha_nac, id_partido, id_cargo)
SELECT id, nombres, fecha_nacimiento, partido_id, cargo_id
FROM tmpCandidatos;

-- Insertar datos en la tabla DETALLE_VOTO
INSERT INTO DETALLE_VOTO (id_voto, id_candidato)
SELECT id_voto, id_candidato
FROM tmpVotaciones;
