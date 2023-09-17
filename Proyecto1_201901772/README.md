# 📑 MANUAL TÉCNICO

# 🚀 [BD1]P1_201901772

```bash
Universidad de San Carlos de Guatemala
Facultad de Ingeniería
Escuela de Ciencias y Sistemas
Laboratorio Sistemas de Bases de Datos 1
Ing. Luis Fernando Espino
Aux. Edin Emanuel Montenegro Vásquez

Carné: 201901772
Nombre: Daniel Reginaldo Dubón Rodríguez
```

## Actividades

- [`Introducción`]()
- [`Modelado de la Base de Datos`](#modelado-de-la-base-de-datos)
  - [`Modelo Conceptual`](#🪧-modelo-conceptual)
  - [`Modelo Lógico`](#🪧-modelo-lógico)
  - [`Modelo Físico`](#🪧-modelo-fisico)
  - [`Scripts`](#📜-scripts)
- [`API`](#requirimientos)
- [`Código Fuente`](#código-fuente)

## Introducción

## Modelado de la Base de Datos

### 🪧 Modelo Conceptual

<div align="center"><img src="../Proyecto1_201901772/Modelos/IMAGEN/Modelo%20Conceptual.png" width="800"/></div>

### 🪧 Modelo Lógico

<div align="center"><img src="../Proyecto1_201901772/Modelos/IMAGEN/Modelo%20Logico.png" width="800"/></div>

### 🪧 Modelo Fisico

<div align="center"><img src="../Proyecto1_201901772/Modelos/IMAGEN/Modelo%20Fisico%20(ER).png" width="800"/></div>

### 🪧 Modelo Fisico

### 📜 Scripts

- [`Crear Modelo`](./Scripts/modelo_elecciones.sql)

    Contiene los scripts necesarios para la creación del modelo de la base de datos

- [`Tablas Temporales`](./Scripts/tablas_temporales.sql)

    Contiene los scripts que permiten crear las tablas temporales donde se cargaran temporalmente los datos de las votaciones

- [`Cargar Modelo`](./Scripts/cargar_modelo_elecciones.sql)

    Contiene los scripts que permiten realizar la carga masiva de las tablas temporales al modelo de la base de datos

- [`Consultas`](./Scripts/consultas_modelo_elecciones.sql)

    Contiene las diferentes consultas que se utlizaran en cada EndPoint

- [`Eliminar Modelo`](./Scripts/eliminar_modelo_elecciones.sql)

    Contiene los scripts que permite la eliminacion de modelo de la base de datos junto a sus datos

## API

Esta API fue realizada con el legunaje de programación JavaScript y el entorno de ejcución NodeJS v18.17.0

Por defecto se ejecuta en el puerto 4000

**Ejemplo**
```JavaScript
http://${ip}:${port}/consulta1
```

### EndPoints

| EndPoint | Método HTTP | Descripción |
| ------ | ------ | ------ |
| /consulta1 | `GET` | Devuelve el nombre de los candidatos a presidentes y vicepresidentes por partido  |
| /consulta2 | `GET` | Devuelve el número de candidatos a diputados |
| /consulta3 | `GET` | Devuelve el nombre de los candidatos a alcalde por partido  |
| /consulta4 | `GET` | Devuelve la cantidad de candidatos por partido (presidentes, vicepresidentes, diputados, alcaldes). |
| /consulta5 | `GET` | Devuelve la cantidad de votaciones por departamentos |
| /consulta6 | `GET` | Devuelve la cantidad de votos nulos |
| /consulta7 | `GET` | Devuelve el top 10 de edad de ciudadanos que realizaron su voto |
| /consulta8 | `GET` | Devuelve el top 10 de candidatos más votados para presidente y vicepresidente |
| /consulta9 | `GET` | Devuelve el top 5 de mesas más frecuentadas |
| /consulta10 | `GET` | Devuelve el top 5 la hora más concurrida en que los ciudadanos fueron a votar  |
| /consulta11 | `GET` | Devuelve la cantidad de votos por género |

## Código Fuente

### Requerimientos

- **API**

    - NodeJS v18.17.0
    - Postman/Insomia o alguna otra aplicacion que permita hacer peticones HTTP

- **BASE DE DATOS**

    - MySQL v8.1.0
    - DataGrip/WorkBench/DBeaver

- **SOURCE**

  - [`API`](./Codigo_Fuente)
  - [`Script`](./Scripts)
  - [`Modelos`](./Modelos)