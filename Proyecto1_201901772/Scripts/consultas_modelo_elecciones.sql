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

-- Consulta 5

-- Consulta 6

-- Consulta 7

-- Consulta 8

-- Consulta 9

-- Consulta 10

-- Consulta 11