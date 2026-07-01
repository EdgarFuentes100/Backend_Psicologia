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
            TIME_FORMAT(horaFin, '%H:%i') AS horaFin
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

module.exports = {
    getHorariosPorDoctor 
};