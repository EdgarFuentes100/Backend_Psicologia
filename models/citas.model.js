const { localDB } = require('../config/db');

/**
 * Obtiene la lista de doctores disponibles para un área específica
 */
async function getCitasPorDoctor(idUsuario) {
    const query = `
        SELECT 
            c.idCita, 
            c.fecha, 
            c.horaInicio, 
            c.horaFin, 
            c.estado,
            p.nombres AS nombrePaciente, 
            p.apellidos AS apellidoPaciente
        FROM citas c
        JOIN doctores d ON c.idDoctor = d.idDoctor
        JOIN personas per ON d.idPersona = per.idPersona
        JOIN personas p ON c.idPaciente = p.idPersona
        WHERE per.idUsuario = ?;
    `;

    const [rows] = await localDB.query(query, [idUsuario]);
    return rows;
}

module.exports = {
    getCitasPorDoctor,
};