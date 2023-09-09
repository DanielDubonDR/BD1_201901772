import { getContentDataFiles } from "../config/utils.js";
import { parse } from 'csv-parse/sync';

export const getCandidatos = async () => {
    const candidatos = await getContentDataFiles('candidatos.csv');
    const data = parse(candidatos, 
        { 
            columns: true,
            cast: (value, context) => {
                if (context.column === 'id') return parseInt(value);
                if (context.column === 'partido_id') return Number(value);
                if (context.column === 'cargo_id') return Number(value);
                
                return value;
            }
        }
    );

    return data;
};