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


async function crearCita(citaData) {
    const { idUsuario, idDoctor, idServicio, fecha, horaInicio } = citaData;

    const idPaciente = idUsuario;

    // Calcular horaFin (+45 minutos)
    const [hora, minutos] = horaInicio.split(':').map(Number);

    const fechaHora = new Date();
    fechaHora.setHours(hora);
    fechaHora.setMinutes(minutos + 45);

    const horaFin = fechaHora.toTimeString().substring(0, 5);

    const query = `
        INSERT INTO citas 
        (idPaciente, idDoctor, idServicio, fecha, horaInicio, horaFin, estado)
        VALUES (?, ?, ?, ?, ?, ?, 'Confirmada')
    `;

    const [result] = await localDB.query(query, [
        idPaciente,
        idDoctor,
        idServicio,
        fecha,
        horaInicio,
        horaFin
    ]);

    return result.insertId;
}

module.exports = {
    getCitasPorDoctor,
    crearCita
};