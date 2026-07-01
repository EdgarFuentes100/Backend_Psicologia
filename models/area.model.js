const { localDB } = require('../config/db');

// Obtener todos los pacientes (desde BD local)
async function getArea() {
    const [rows] = await localDB.query(
        `SELECT a.idArea, a.nombre as area, a.descripcion FROM areas a;`);
    return rows;
}

module.exports = {
    getArea
};
