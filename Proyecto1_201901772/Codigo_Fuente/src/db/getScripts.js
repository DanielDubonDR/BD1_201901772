import { deleteComments, getCommands, getContentFile } from "../config/utils.js";

export const getTempTableScript = async () => {
    return await getContentFile('../Scripts/tablas_temporales.sql');
};

export const getModelScript = async () => {
    return await getContentFile('../Scripts/modelo_elecciones.sql');
};

export const getDropTablesScript = async () => {
    return await getContentFile('../Scripts/eliminar_modelo_elecciones.sql');
}

export const getInsertsScript = async () => {
    return await getContentFile('../Scripts/cargar_modelo_elecciones.sql');
}

const getConsultasScript = async () => {
    return await getContentFile('../Scripts/consultas_modelo_elecciones.sql');
}

export const getConsultaById = async (id) => {
    const consultas = await getConsultasScript();
    let c = deleteComments(consultas);
    c = getCommands(c);
    c = c.filter(command => command.length > 0);

    return c[id - 1];
}