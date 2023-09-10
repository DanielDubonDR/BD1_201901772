import { convertDate, convertDatetime, getContentDataFiles } from "../config/utils.js";

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

export const getDepartamentos = async () => {
    const departamentos = await getContentDataFiles('departamentos.csv');
    let lines = departamentos.split('\n');
    lines = lines.filter(line => line.length > 0);
    lines.shift();
    const departamentosData = lines.map(line => {
        const data = line.split(',');
        return {
            id: Number(data[0]),
            nombre: data[1].trimEnd()
        }
    });

    return departamentosData;
};

export const getPartidos = async () => {
    const partidos = await getContentDataFiles('partidos.csv');
    let lines = partidos.split('\n');
    lines = lines.filter(line => line.length > 0);
    lines.shift();
    const partidosData = lines.map(line => {
        const fields = line.split(/,(?=(?:(?:[^"]*"){2})*[^"]*$)/);
        return {
            id_partido: Number(fields[0]),
            nombrePartido: fields[1].replace(/"/g, '').trimEnd(), // Eliminar las comillas dobles
            siglas: fields[2].replace(/"/g, '').trimEnd(), // Eliminar las comillas dobles
            fundacion: convertDate(fields[3].trimEnd())
        }
    });

    return partidosData;
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
            nombres: data[1],
            fecha_nacimiento: convertDate(data[2]),
            partido_id: Number(data[3]),
            cargo_id: Number(data[4].trimEnd())
        }
    });

    return candidatosData;
};

export const getMesas = async () => {
    const mesas = await getContentDataFiles('mesas.csv');
    let lines = mesas.split('\n');
    lines = lines.filter(line => line.length > 0);
    lines.shift();
    const mesasData = lines.map(line => {
        const data = line.split(',');
        return {
            id_mesa: Number(data[0]),
            id_departamento: Number(data[1].trimEnd())
        }
    });

    return mesasData;
};

export const getVotaciones = async () => {
    const votaciones = await getContentDataFiles('votaciones.csv');
    let lines = votaciones.split('\n');
    lines = lines.filter(line => line.length > 0);
    lines.shift();
    const votacionesData = lines.map(line => {
        const data = line.split(',');
        return {
            id_voto: Number(data[0]),
            id_candidato: Number(data[1]),
            dpi_ciudadano: data[2],
            mesa_id: Number(data[3]),
            fecha_hora: convertDatetime(data[4].trimEnd())
        }
    });

    return votacionesData;
};