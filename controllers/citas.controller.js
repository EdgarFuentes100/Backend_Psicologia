const Default = require('../models/citas.model');

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

module.exports = {
    listaCitas
};