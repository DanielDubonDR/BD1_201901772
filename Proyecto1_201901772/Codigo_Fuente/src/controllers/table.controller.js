import { pool } from '../db.js'
import { getTempTableScript, getModelScript, getDropTablesScript } from '../db/getScripts.js';
import { deleteComments, getCommands } from '../config/utils.js';
import { getCandidatos, getCargos, getCiudadanos } from '../dataFiles/getDataFiles.js';

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
        return res.status(409).json({ message: 'No se creado el modelo previamente' });
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

    const asd = await connection.query('SELECT * FROM tmpCiudadanos');
    console.log(asd);

    console.log(await getCargos());

    // Obtengo los datos del archivo

    connection.destroy();

    res.send({ message: 'Carga Masiva tabla temporal' });
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