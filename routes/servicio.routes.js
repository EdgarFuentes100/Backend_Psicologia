const express = require('express');
const router = express.Router();
const { listaServicio } = require('../controllers/servicio.controller');

// Obtener doctores filtrados por Área
router.get('/obtenerLista/:idDoctor', listaServicio);

module.exports = router;