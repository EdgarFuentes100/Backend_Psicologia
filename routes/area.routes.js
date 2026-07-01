const express = require('express');
const router = express.Router();
const { listaArea } = require('../controllers/area.controller');

router.get('/obtenerLista', listaArea);

module.exports = router;
