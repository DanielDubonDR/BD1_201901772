import { pool } from '../db.js'
import { getTempTableScript, getModelScript, getDropTablesScript, getInsertsScript } from '../db/getScripts.js';
import { deleteComments, getCommands } from '../config/utils.js';
import { getCandidatos, getCargos, getCiudadanos, getDepartamentos, getMesas, getPartidos, getVotaciones } from '../dataFiles/getDataFiles.js';

export const cargaMaisvaTablaTemporal = async (req, res) => {
    
    const tmpScript = await getTempTableScript();
    let tmpCommands = deleteComments(tmpScript);
    tmpCommands = getCommands(tmpCommands);
    tmpCommands = tmpCommands.filter(command => command.length > 0);

    // Verificar que exista el modelo

    try {
        await pool.query('SELECT * FROM proyecto1.CIUDADANO');
    } catch (error) {
        console.error(error);
        return res.status(409).json({ message: 'No se ha creado el modelo previamente' });
    }

    // Obtengo la instancia de la conexion
    const connection = await pool.getConnection();

    // Creo las tablas temporales
    for (const command of tmpCommands) {
        try {
            await connection.query(command);
        } catch (error) {
            console.error(error);
            connection.destroy();
            return res.status(409).json({ message: 'Hubo un error al crear las tablas temporales' });
        }
    }

    // Lleno la tabla temporal ciudadanos
    const ciudadanos = await getCiudadanos();
    for (const ciudadano of ciudadanos) {
        try {
            await connection.query('INSERT INTO tmpCiudadanos SET ?', ciudadano);
        } catch (error) {
            console.error(error);
            connection.destroy();
            return res.status(409).json({ message: 'Ocurrio un error cargando los datos en tmpCiudadanos' });
        }
    }

    // Lleno la tabla temporal cargos
    const cargos = await getCargos();
    for (const cargo of cargos) {
        try {
            await connection.query('INSERT INTO tmpCargos SET ?', cargo);
        } catch (error) {
            console.error(error);
            connection.destroy();
            return res.status(409).json({ message: 'Ocurrio un error cargando los datos en tmpCargos' });
        }
    }

    // Lleno la tabla temporal departamentos
    const departamentos = await getDepartamentos();
    for (const departamento of departamentos) {
        try {
            await connection.query('INSERT INTO tmpDepartamentos SET ?', departamento);
        } catch (error) {
            console.error(error);
            connection.destroy();
            return res.status(409).json({ message: 'Ocurrio un error cargando los datos en tmpDepartamentos' });
        }
    }

    // Lleno la tabla temporal partidos
    const partidos = await getPartidos();
    for (const partido of partidos) {
        try {
            await connection.query('INSERT INTO tmpPartidos SET ?', partido);
        } catch (error) {
            console.error(error);
            connection.destroy();
            return res.status(409).json({ message: 'Ocurrio un error cargando los datos en tmpPartidos' });
        }
    }

    // Lleno la tabla temporal candidatos
    const candidatos = await getCandidatos();
    for (const candidato of candidatos) {
        try {
            await connection.query('INSERT INTO tmpCandidatos SET ?', candidato);
        } catch (error) {
            console.error(error);
            connection.destroy();
            return res.status(409).json({ message: 'Ocurrio un error cargando los datos en tmpCandidatos' });
        }
    }

    // Lleno la tabla temporal mesas
    const mesas = await getMesas();
    for (const mesa of mesas) {
        try {
            await connection.query('INSERT INTO tmpMesas SET ?', mesa);
        } catch (error) {
            console.error(error);
            connection.destroy();
            return res.status(409).json({ message: 'Ocurrio un error cargando los datos en tmpMesas' });
        }
    }

    // Lleno la tabla temporal votaciones
    const votaciones = await getVotaciones();
    for (const votacion of votaciones) {
        try {
            await connection.query('INSERT INTO tmpVotaciones SET ?', votacion);
        } catch (error) {
            console.error(error);
            connection.destroy();
            return res.status(409).json({ message: 'Ocurrio un error cargando los datos en tmpVotaciones' });
        }
    }

    const insertScript = await getInsertsScript();
    let insertCommands = deleteComments(insertScript);
    insertCommands = getCommands(insertCommands);
    insertCommands = insertCommands.filter(command => command.length > 0);

    // Insertar datos en el modelo
    for(const command of insertCommands) {
        try {
            await connection.query(command);
        } catch (error) {
            console.error(error);
            connection.destroy();
            return res.status(409).json({ message: 'Ocurrio un error cargando los datos en el modelo', revisar: command, error: error });
        }
    }

    connection.destroy();

    res.status(200).json({ message: 'Datos cargados correctamente' });
}

export const elimnarModelo = async (req, res) => {
    const dropScript = await getDropTablesScript();
    let dropCommands = deleteComments(dropScript);
    dropCommands = getCommands(dropCommands);
    dropCommands = dropCommands.filter(command => command.length > 0);

    let status = true;

    for (const command of dropCommands) {
        try {
            await pool.query(command);
        }
        catch (error) {
            console.error(error);
            status = false;
        }
    }

    const message = status ? 'Modelo eliminado correctamente' : 'Hubo un error al eliminar el modelo';
    const code = status ? 200 : 409;

    res.status(code).json({ status, message });
}

export const crearModelo = async (req, res) => {

    const model = await getModelScript();
    let modelCommands = deleteComments(model);
    modelCommands = getCommands(modelCommands);
    modelCommands = modelCommands.filter(command => command.length > 0);

    let tables;
    let status0 = true;
    let status1 = true;

    for (const command of modelCommands) {
        try {
            await pool.query(command);
        }
        catch (error) {
            console.error(error);
            status0 = false;
        }
    }

    try {
        tables = await pool.query('SHOW TABLES');
        tables = tables[0];
    } catch (error) {
        console.error(error);
        status1 = false;
    }

    const status = status0 && status1;
    const message = status ? 'Modelo creado correctamente' : 'Hubo un error al crear el modelo';
    const code = status ? 200 : 409;

    res.status(code).json({ status, message, tables })
}