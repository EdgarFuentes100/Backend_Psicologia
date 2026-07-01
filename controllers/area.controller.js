const Default = require('../models/area.model');

async function listaArea(req, res, next) {

    try {
        const datos = await Default.getArea();
        res.json({
            ok: true,
            message: 'Lista obtenida',
            datos
        });
    } catch (err) { next(err); }
}

module.exports = {
    listaArea
};
