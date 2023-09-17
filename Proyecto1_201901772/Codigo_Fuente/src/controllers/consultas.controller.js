import { pool } from "../db/dbConnection.js"
import { getConsultaById } from '../db/getScripts.js';

export const getConsulta1 = async (req, res) => {

    const consulta = await getConsultaById(1);

    try {
        const result = await pool.query(consulta);
        const response = {
            no_consulta: 1,
            descripcion: 'Nombre de los candidatos a presidentes y vicepresidentes por partido',
            rows: result[0].length,
            resultado: result[0]
        }
        res.status(200).json(response);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

export const getConsulta2 = async (req, res) => {
    
    const consulta = await getConsultaById(2);

    try {
        const result = await pool.query(consulta);
        // elilminar el primer elemento del array
        result[0].shift();
        const response = {
            no_consulta: 2,
            descripcion: 'Numero de candidatos a diputados por partido',
            rows: result[0].length,
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
            rows: result[0].length,
            resultado: result[0]
        }
        res.status(200).json(response);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
}

export const getConsulta4 = async (req, res) => {
    const consulta = await getConsultaById(4);

    try {
        const result = await pool.query(consulta);
        result[0].shift();
        const response = {
            no_consulta: 4,
            descripcion: 'Cantidad de candidatos por partido',
            rows: result[0].length,
            resultado: result[0]
        }
        res.status(200).json(response);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
}

export const getConsulta5 = async (req, res) => {
    const consulta = await getConsultaById(5);

    try {
        const result = await pool.query(consulta);
        const response = {
            no_consulta: 5,
            descripcion: 'Cantidad de votaciones por departamentos',
            rows: result[0].length,
            resultado: result[0]
        }
        res.status(200).json(response);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
}

export const getConsulta6 = async (req, res) => {
    const consulta = await getConsultaById(6);

    try {
        const result = await pool.query(consulta);
        const response = {
            no_consulta: 6,
            descripcion: 'Cantidad de votos nulos',
            rows: result[0].length,
            resultado: result[0]
        }
        res.status(200).json(response);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
}

export const getConsulta7 = async (req, res) => {
    const consulta = await getConsultaById(7);

    try {
        const result = await pool.query(consulta);
        const response = {
            no_consulta: 7,
            descripcion: 'Top 10 de edad de ciudadanos que realizaron su voto',
            rows: result[0].length,
            resultado: result[0]
        }
        res.status(200).json(response);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
}

export const getConsulta8 = async (req, res) => {
    const consulta = await getConsultaById(8);

    try {
        const result = await pool.query(consulta);
        const response = {
            no_consulta: 8,
            descripcion: 'Top 10 de candidatos más votados para presidente y vicepresidente',
            rows: result[0].length,
            resultado: result[0]
        }
        res.status(200).json(response);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
}

export const getConsulta9 = async (req, res) => {
    const consulta = await getConsultaById(9);

    try {
        const result = await pool.query(consulta);
        const response = {
            no_consulta: 9,
            descripcion: 'Top 5 de mesas más frecuentadas',
            rows: result[0].length,
            resultado: result[0]
        }
        res.status(200).json(response);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
}

export const getConsulta10 = async (req, res) => {
    const consulta = await getConsultaById(10);

    try {
        const result = await pool.query(consulta);
        const response = {
            no_consulta: 10,
            descripcion: 'Top 5 la hora más concurrida en que los ciudadanos fueron a votar',
            rows: result[0].length,
            resultado: result[0]
        }
        res.status(200).json(response);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
}

export const getConsulta11 = async (req, res) => {
    const consulta = await getConsultaById(11);

    try {
        const result = await pool.query(consulta);
        const response = {
            no_consulta: 11,
            descripcion: 'Cantidad de votos por genero',
            rows: result[0].length,
            resultado: result[0]
        }
        res.status(200).json(response);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
}