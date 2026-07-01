const { localDB } = require('../config/db');

/**
 * Obtiene la lista de doctores disponibles para un área específica
 * a través de los servicios que ofrecen.
 */
async function getDoctoresPorArea(idArea) {
    const query = `
        SELECT DISTINCT 
            d.idDoctor, 
            p.nombres, 
            p.apellidos, 
            d.titulo, 
            d.numeroColegiado
        FROM doctores d
        INNER JOIN personas p ON d.idPersona = p.idPersona
        INNER JOIN doctor_servicio ds ON d.idDoctor = ds.idDoctor
        INNER JOIN servicios s ON ds.idServicio = s.idServicio
        WHERE s.idArea = ? 
          AND d.estado = 1;
    `;
    
    const [rows] = await localDB.query(query, [idArea]);
    return rows;
}

module.exports = {
    getDoctoresPorArea,
};