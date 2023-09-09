import fs from 'fs/promises';
import path from 'path';

export const getContentFile = async (filePath) => {
    try {
        const data = await fs.readFile(filePath, 'utf8');
        return data;
    } catch (error) {
        console.error(error);
    }
};

export const getContentDataFiles = async (fileName) => {
    try {
        const __dirname = path.resolve();
        const filePath = path.join(__dirname, '/src/dataFiles/', fileName);
        const data = await fs.readFile(filePath, 'utf8');
        return data;
    } catch (error) {
        console.error(error);
    }
};

export const deleteComments = (script) => script.replace(/(--.*)/g, '');

export const getCommands = (script) => script.split(';').map(command => command.trim());