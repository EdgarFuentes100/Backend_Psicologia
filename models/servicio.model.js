
const { localDB } = require('../config/db');

/**
 * Obtiene la lista de servicios y sus detalles (precio, duración)
 * que ofrece un doctor en específico.
 */
async function getServiciosPorDoctor(idDoctor) {
    const query = `
        SELECT 
            s.idServicio, 
            s.nombre AS servicio, 
            s.descripcion, 
            s.precio, 
            s.duracionMinutos
        FROM servicios s
        INNER JOIN doctor_servicio ds ON s.idServicio = ds.idServicio
        WHERE ds.idDoctor = ? 
          AND s.estado = 1;
    `;

    const [rows] = await localDB.query(query, [idDoctor]);
    return rows;
}
module.exports = {
    getServiciosPorDoctor
};
