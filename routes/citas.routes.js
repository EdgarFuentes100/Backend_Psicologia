const express = require('express');
const router = express.Router();
const { listaCitas } = require('../controllers/citas.controller');

// Obtener doctores filtrados por Área
router.get('/obtenerLista/:idUsuario', listaCitas);

module.exports = router;