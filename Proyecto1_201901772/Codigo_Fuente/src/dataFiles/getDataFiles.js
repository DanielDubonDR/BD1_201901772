import { convertDate, getContentDataFiles } from "../config/utils.js";

export const getCiudadanos = async () => {
    const ciudadanos = await getContentDataFiles('ciudadanos.csv');
    let lines = ciudadanos.split('\n');
    lines = lines.filter(line => line.length > 0);
    lines.shift();
    const ciudadanosData = lines.map(line => {
        const data = line.split(',');
        return {
            dpi: data[0],
            nombre: data[1],
            apellido: data[2],
            direccion: data[3],
            telefono: data[4],
            edad: Number(data[5]),
            genero: data[6].trimEnd()
        }
    });

    return ciudadanosData;
};

export const getCargos = async () => {
    const cargos = await getContentDataFiles('cargos.csv');
    let lines = cargos.split('\n');
    lines = lines.filter(line => line.length > 0);
    lines.shift();
    const cargosData = lines.map(line => {
        const data = line.split(',');
        return {
            id: Number(data[0]),
            cargo: data[1].trimEnd()
        }
    });

    return cargosData;
};

export const getCandidatos = async () => {
    const candidatos = await getContentDataFiles('candidatos.csv');
    let lines = candidatos.split('\n');
    lines = lines.filter(line => line.length > 0);
    lines.shift();
    const candidatosData = lines.map(line => {
        const data = line.split(',');
        return {
            id: Number(data[0]),
            nombre: data[1],
            fecha_nacimiento: convertDate(data[2]),
            partido_id: Number(data[3]),
            cargo_id: Number(data[4].trimEnd())
        }
    });

    return candidatosData;
};