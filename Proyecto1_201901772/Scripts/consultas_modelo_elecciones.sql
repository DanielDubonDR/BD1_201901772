-- Consulta 1
SELECT p.nombre AS 'Partido', c1.nombre AS 'Presidente', c2.nombre AS 'Vicepresidente'
FROM CANDIDATO c1, CANDIDATO c2, PARTIDO p
WHERE c1.id_cargo = 1 AND c2.id_cargo = 2 AND c1.id_partido = p.id_partido AND c2.id_partido = p.id_partido;

-- Consulta 2
SELECT
    p.nombre AS 'Partido',
    (SELECT COUNT(*) FROM CANDIDATO c1 WHERE c1.id_partido = p.id_partido AND c1.id_cargo = 3) AS 'Listado_nacional',
    (SELECT COUNT(*) FROM CANDIDATO c2 WHERE c2.id_partido = p.id_partido AND c2.id_cargo = 4) AS 'Distrito_electoral',
    (SELECT COUNT(*) FROM CANDIDATO c3 WHERE c3.id_partido = p.id_partido AND c3.id_cargo = 5) AS 'Parlamento_centroamericano',
    (SELECT COUNT(*) FROM CANDIDATO c4 WHERE c4.id_partido = p.id_partido AND c4.id_cargo IN (3,4,5)) AS 'Total_de_diputados'
FROM
    PARTIDO p;

-- Consulta 3
SELECT p.nombre AS 'Partido', c.nombre AS 'Alcalde'
FROM CANDIDATO c, PARTIDO p
WHERE c.id_cargo = 6 AND c.id_partido = p.id_partido;

-- Consulta 4
SELECT
    p.nombre AS 'Partido',
    (SELECT COUNT(*) FROM CANDIDATO c1 WHERE c1.id_partido = p.id_partido AND c1.id_cargo = 1) AS 'Presidentes',
    (SELECT COUNT(*) FROM CANDIDATO c2 WHERE c2.id_partido = p.id_partido AND c2.id_cargo = 2) AS 'Vicepresidentes',
    (SELECT COUNT(*) FROM CANDIDATO c4 WHERE c4.id_partido = p.id_partido AND c4.id_cargo IN (3,4,5)) AS 'Diputados',
    (SELECT COUNT(*) FROM CANDIDATO c3 WHERE c3.id_partido = p.id_partido AND c3.id_cargo = 6) AS 'Alcaldes',
    (SELECT COUNT(*) FROM CANDIDATO c5 WHERE c5.id_partido = p.id_partido AND c5.id_cargo IN (1,2,3,4,5,6)) AS 'Total'
FROM
    PARTIDO p;

-- Consulta 5
SELECT d.nombre AS 'Departamento', COUNT(*) AS 'Votos'
FROM VOTO v, MESA m, DEPARTAMENTO d
WHERE v.id_mesa = m.id_mesa AND m.id_departamento = d.id_departamento
GROUP BY d.nombre;

-- Consulta 6
SELECT COUNT(*) AS 'Votos_nulos'
FROM VOTO v, DETALLE_VOTO dv
WHERE v.id_voto = dv.id_voto AND dv.id_candidato = -1;

-- Consulta 7
SELECT c.edad AS 'Edad', COUNT(*) AS 'Cantidad'
FROM CIUDADANO c, VOTO v
WHERE c.dpi = v.dpi
GROUP BY c.edad
ORDER BY Cantidad DESC
LIMIT 10;

-- Consulta 8
SELECT
    p.nombre AS 'Partido',
    c_presidente.nombre AS 'Presidente',
    c_vicepresidente.nombre AS 'Vicepresidente',
    COUNT(*) AS 'Votos'
FROM
    CANDIDATO c_presidente
INNER JOIN
    CANDIDATO c_vicepresidente ON c_presidente.id_partido = c_vicepresidente.id_partido
INNER JOIN
    PARTIDO p ON c_presidente.id_partido = p.id_partido
INNER JOIN
    DETALLE_VOTO dv ON c_presidente.id_candidato = dv.id_candidato
INNER JOIN
    VOTO v ON dv.id_voto = v.id_voto
WHERE
    c_presidente.id_cargo = 1
    AND c_vicepresidente.id_cargo = 2
GROUP BY
    c_presidente.nombre, c_vicepresidente.nombre, p.nombre
ORDER BY
    Votos DESC
LIMIT 10;

-- Consulta 9
SELECT m.id_mesa AS 'No_mesa', d.nombre AS 'Departamento', COUNT(*) AS 'Votos'
FROM MESA m, VOTO v, DEPARTAMENTO d
WHERE m.id_mesa = v.id_mesa AND m.id_departamento = d.id_departamento
GROUP BY m.id_mesa
ORDER BY Votos DESC
LIMIT 5;

-- Consulta 10
SELECT HOUR(fecha_hora) AS 'Hora', COUNT(*) AS 'Votos'
FROM VOTO
GROUP BY HOUR(fecha_hora)
ORDER BY Votos DESC
LIMIT 5;

-- Consulta 11
SELECT c.genero AS 'Genero', COUNT(*) AS 'Votos'
FROM CIUDADANO c, VOTO v
WHERE c.dpi = v.dpi
GROUP BY c.genero
ORDER BY Votos DESC;