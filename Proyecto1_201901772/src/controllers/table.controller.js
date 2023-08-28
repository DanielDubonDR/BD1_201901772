import { pool } from '../db.js'

export const eliminarTablaTemporal = async (req, res) => {
    res.send({ message: 'Eliminando tabla temporal' });
}

export const cargaMaisvaTablaTemporal = async (req, res) => {
    res.send({ message: 'Carga Masiva tabla temporal' });
}

export const elimnarModelo = async (req, res) => {
    res.send({ message: 'Eliminando modelo' });
}

export const crearModelo = async (req, res) => {
    res.send({ message: 'Creando modelo' });
}

export const cargarModelo = async (req, res) => {
    res.send({ message: 'Cargando modelo' });
}