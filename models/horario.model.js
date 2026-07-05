const { localDB } = require('../config/db');
/**
 * Obtiene el horario laboral/disponible de un doctor específico
 */
async function getHorariosPorDoctor(idDoctor) {
    const query = `
        SELECT 
            idHorario,
            diaSemana,
            TIME_FORMAT(horaInicio, '%H:%i') AS horaInicio,
            TIME_FORMAT(horaFin, '%H:%i') AS horaFin,
            estado
        FROM horarios
        WHERE idDoctor = ? 
          AND estado = 1
        ORDER BY 
            FIELD(diaSemana, 'Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado', 'Domingo'),
            horaInicio ASC;
    `;

    const [rows] = await localDB.query(query, [idDoctor]);
    return rows;
}

async function getCitasOcupadasPorDoctor(idDoctor, fecha) {
    console.log(idDoctor, fecha)
    const query = `
        SELECT 
            idCita,
            idPaciente,
            TIME_FORMAT(horaInicio, '%H:%i') AS horaInicio,
            TIME_FORMAT(horaFin, '%H:%i') AS horaFin,
            estado
        FROM citas
        WHERE idDoctor = ? 
          AND fecha = ?
          AND estado != 'Cancelada'
        ORDER BY 
            horaInicio ASC;
    `;

    const [rows] = await localDB.query(query, [idDoctor, fecha]);
    return rows;
}
module.exports = {
    getHorariosPorDoctor,
    getCitasOcupadasPorDoctor
};