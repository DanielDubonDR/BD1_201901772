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

export const convertDate = (date) => {
    const dateParts = date.split('/');
    const dateObject = new Date(+dateParts[2], dateParts[1] - 1, +dateParts[0]);
    return dateObject;
};

export const convertDatetime = (datetime) => {
    const datetimeParts = datetime.split(' ');
    const dateParts = datetimeParts[0].split('/');
    const timeParts = datetimeParts[1].split(':');
    const datetimeObject = new Date(+dateParts[2], dateParts[1] - 1, +dateParts[0], +timeParts[0], +timeParts[1]);
    return datetimeObject;
};

export const deleteComments = (script) => script.replace(/(--.*)/g, '');

export const getCommands = (script) => script.split(';').map(command => command.trim());