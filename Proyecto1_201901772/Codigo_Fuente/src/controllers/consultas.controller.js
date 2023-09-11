import { pool } from "../db/dbConnection.js"
import { getConsultaById } from '../db/getScripts.js';

export const getConsulta1 = async (req, res) => {

    const consulta = await getConsultaById(1);

    try {
        const result = await pool.query(consulta);
        const response = {
            no_consulta: 1,
            descripcion: 'Nombre de los candidatos a presidentes y vicepresidentes por partido',
            resultado: result[0]
        }
        res.status(200).json(response);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

export const getConsulta2 = async (req, res) => {
    
    const consulta = await getConsultaById(1);

    try {
        const result = await pool.query(consulta);
        const response = {
            no_consulta: 2,
            descripcion: 'Numero de candidatos por partido',
            resultado: result[0]
        }
        res.status(200).json(response);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
}

export const getConsulta3 = async (req, res) => {
    
    const consulta = await getConsultaById(3);

    try {
        const result = await pool.query(consulta);
        const response = {
            no_consulta: 3,
            descripcion: 'Mostrar el nombre de los candidatos a alcalde por partido',
            resultado: result[0]
        }
        res.status(200).json(response);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
}

export const getConsulta4 = async (req, res) => {
    res.send({ message: 'Consulta 4' });
}

export const getConsulta5 = async (req, res) => {
    res.send({ message: 'Consulta 5' });
}

export const getConsulta6 = async (req, res) => {
    res.send({ message: 'Consulta 6' });
}

export const getConsulta7 = async (req, res) => {
    res.send({ message: 'Consulta 7' });
}

export const getConsulta8 = async (req, res) => {
    res.send({ message: 'Consulta 8' });
}

export const getConsulta9 = async (req, res) => {
    res.send({ message: 'Consulta 9' });
}

export const getConsulta10 = async (req, res) => {
    res.send({ message: 'Consulta 10' });
}

export const getConsulta11 = async (req, res) => {
    res.send({ message: 'Consulta 11' });
}