#-------------------------------------------------- CARRERA ----------------------------------------
call crearCarrera('Area Común');
call crearCarrera('Ingeniería en Ciencias y Sistemas');

#-------------------------------------------------- ESTUDIANTE ----------------------------------------
call registrarEstudiante(
    201901772,
    'Daniel Reginaldo',
    'Dubón Rodríguez',
    '04-07-1999',
    'danieldubon499@gmail.com',
    32751191,
    'Cubulco',
    3179425811504,
    1
);

call registrarEstudiante(
    201901773,
    'Daniel Reginaldo',
    'Dubón Rodríguez',
    '04-07-1999',
    'danieldubon499@gmail.com',
    32751191,
    'Cubulco',
    3179425811505,
    0
);

# -------------------------------------------------- DOCENTE ----------------------------------------
call registrarDocente(
    'Luis Fernando',
    'Espino',
    '01-01-1980',
    'luisfernandoespino@gmail.com',
    23143820,
    'Guatemala',
    1234567890123,
    123456789
);

call registrarDocente(
    'Pedro Pablo',
    'Hernandez',
    '01-01-1970',
    'pph@gmail.com',
    23143820,
    'Guatemala',
    1234567890125,
    123456782
);

# -------------------------------------------------- CURSO ----------------------------------------
call crearCurso(
    0281,
    'Sistemas Operativos 1',
    0,
    5,
    1,
    true
);

call crearCurso(
    0282,
    'Sistemas Operativos 2',
    0,
    5,
    0,
    false
);