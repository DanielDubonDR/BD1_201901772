#-------------------------------------------------- CARRERA ----------------------------------------
CALL crearCarrera('Area Común');
CALL crearCarrera('Ingeniería en Ciencias y Sistemas');

#-------------------------------------------------- ESTUDIANTE ----------------------------------------
CALL registrarEstudiante(
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

CALL registrarEstudiante(
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
CALL registrarDocente(
    'Luis Fernando',
    'Espino',
    '01-01-1980',
    'luisfernandoespino@gmail.com',
    23143820,
    'Guatemala',
    1234567890123,
    123456789
);

CALL registrarDocente(
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
CALL crearCurso(
    0281,
    'Sistemas Operativos 1',
    0,
    5,
    1,
    true
);

CALL crearCurso(
    0282,
    'Sistemas Operativos 2',
    0,
    5,
    0,
    false
);

# -------------------------------------------------- HABILITAR CURSO ----------------------------------------
CALL habilitarCurso(
    0281,
    '2S',
    123456789,
    20,
    'A'
);

# -------------------------------------------------- AGREGAR HORARIO ----------------------------------------
CALL agregarHorario(
    2,
    2,
    '07:00-10:00'
);