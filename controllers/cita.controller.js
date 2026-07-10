const Default = require('../models/cita.model');

async function listaCitas(req, res, next) {
    try {
        const { idUsuario } = req.params;

        if (!idUsuario || isNaN(idUsuario)) {
            return res.status(400).json({
                ok: false,
                message: 'El id proporcionado no es válido o es requerido'
            });
        }

        const datos = await Default.getCitasPorDoctor(idUsuario);

        res.json({
            ok: true,
            message: 'Lista obtenida',
            datos
        });
    } catch (err) { 
        next(err); 
    }
}

async function registrarCita(req, res, next) {
    try {
        const { idUsuario, idDoctor, idServicio, fecha, horaInicio } = req.body;

        console.log("Datos recibidos para registrar cita:");
        console.log({
            idUsuario,
            idDoctor,
            idServicio,
            fecha,
            horaInicio
        });

        // Validación básica
        if (!idUsuario || !idDoctor || !idServicio || !fecha || !horaInicio) {
            console.log("Faltan datos obligatorios");
            return res.status(400).json({
                ok: false,
                message: 'Faltan datos obligatorios'
            });
        }

        console.log("Enviando al modelo crearCita...");

        const nuevaCitaId = await Default.crearCita({
            idUsuario,
            idDoctor,
            idServicio,
            fecha,
            horaInicio
        });

        console.log("Cita creada con ID:", nuevaCitaId);

        res.status(201).json({
            ok: true,
            message: 'Cita registrada exitosamente',
            idCita: nuevaCitaId
        });

    } catch (err) {
        console.error("Error registrando cita:", err);
        next(err);
    }
}

module.exports = {
    listaCitas,
    registrarCita
};