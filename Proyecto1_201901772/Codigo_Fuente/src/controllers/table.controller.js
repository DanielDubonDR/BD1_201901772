import { pool } from '../db.js'

export const cargaMaisvaTablaTemporal = async (req, res) => {
    res.send({ message: 'Carga Masiva tabla temporal' });
}

export const elimnarModelo = async (req, res) => {
    res.send({ message: 'Eliminando modelo' });
}

export const crearModelo = async (req, res) => {
    res.send({ message: 'Creando modelo' });
}