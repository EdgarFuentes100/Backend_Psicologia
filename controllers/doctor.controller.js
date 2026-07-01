const Default = require('../models/doctor.model');

async function listaDoctor(req, res, next) {
    try {
        // 1. Capturamos el idArea desde los parámetros de la URL
        const { idArea } = req.params;

        // 2. Validación básica para asegurarnos de que viene un número válido
        if (!idArea || isNaN(idArea)) {
            return res.status(400).json({
                ok: false,
                message: 'El idArea proporcionado no es válido o es requerido'
            });
        }

        // 3. Le pasamos el idArea al método del modelo
        const datos = await Default.getDoctoresPorArea(idArea);

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
    listaDoctor
};