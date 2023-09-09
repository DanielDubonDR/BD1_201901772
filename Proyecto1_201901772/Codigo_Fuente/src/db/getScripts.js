import { getContentFile } from "../config/utils.js";

export const getTempTableScript = async () => {
    return await getContentFile('../Scripts/tablas_temporales.sql');
};

export const getModelScript = async () => {
    return await getContentFile('../Scripts/modelo_elecciones.sql');
};

export const getDropTablesScript = async () => {
    return await getContentFile('../Scripts/eliminar_modelo_elecciones.sql');
}