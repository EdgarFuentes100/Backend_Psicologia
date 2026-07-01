const Default = require('../models/servicio.model');

async function listaServicio(req, res, next) {
    try {
        // 1. Capturamos el idArea desde los parámetros de la URL
        const { idDoctor } = req.params;

        // 2. Validación básica para asegurarnos de que viene un número válido
        if (!idDoctor || isNaN(idDoctor)) {
            return res.status(400).json({
                ok: false,
                message: 'Dato proporcionado no es válido o es requerido'
            });
        }

        // 3. Le pasamos el idArea al método del modelo
        const datos = await Default.getServiciosPorDoctor(idDoctor);

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
    listaServicio
};