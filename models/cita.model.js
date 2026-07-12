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
                    c.link,
                    CONCAT(p.nombres,' ',p.apellidos) AS nombrePaciente,
                    CONCAT('Servicio: ', s.nombre,' - $',s.precio,' - ',a.nombre) AS detalleServicio
                FROM citas c
                JOIN doctores d ON c.idDoctor = d.idDoctor
                JOIN personas per ON d.idPersona = per.idPersona
                JOIN personas p ON c.idPersona = p.idPersona
                JOIN servicios s ON c.idServicio = s.idServicio
                JOIN areas a ON a.idArea = s.idArea
                WHERE per.idUsuario = ?; `;

    const [rows] = await localDB.query(query, [idUsuario]);
    return rows;
}


async function crearCita(citaData) {
    const { idPersona, idDoctor, idServicio, fecha, horaInicio } = citaData;

    // Calcular horaFin (+45 minutos)
    const [hora, minutos] = horaInicio.split(':').map(Number);

    const fechaHora = new Date();
    fechaHora.setHours(hora);
    fechaHora.setMinutes(minutos + 45);

    const horaFin = fechaHora.toTimeString().substring(0, 5);

    const query = `
        INSERT INTO citas 
        (idPersona, idDoctor, idServicio, fecha, horaInicio, horaFin, estado)
        VALUES (?, ?, ?, ?, ?, ?, 'Confirmada')
    `;

    const [result] = await localDB.query(query, [
        idPersona,
        idDoctor,
        idServicio,
        fecha,
        horaInicio,
        horaFin
    ]);

    return result.insertId;
}

async function getMisCitas(idUsuario) {
    const query = `
                SELECT 
                    u.idUsuario,
                    c.idCita,
                    c.fecha,
                    c.horaInicio,
                    c.horaFin,
                    c.estado,
                    c.link,
                    CONCAT(doc.nombres,' ',doc.apellidos) AS nombreDoctor,
                    CONCAT('Servicio: ', s.nombre, ' - $', s.precio, ' - ', a.nombre) AS detalleServicio
                FROM citas c
                JOIN personas p ON c.idPersona = p.idPersona 
                JOIN usuarios u ON p.idUsuario = u.idUsuario
                JOIN doctores d ON c.idDoctor = d.idDoctor
                JOIN personas doc ON d.idPersona = doc.idPersona
                JOIN servicios s ON c.idServicio = s.idServicio
                JOIN areas a ON s.idArea = a.idArea
                WHERE u.idUsuario = ?; `;

    const [rows] = await localDB.query(query, [idUsuario]);
    return rows;
}

module.exports = {
    getCitasPorDoctor,
    crearCita,
    getMisCitas
};