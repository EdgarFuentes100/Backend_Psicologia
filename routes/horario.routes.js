const express = require('express');
const router = express.Router();
const { listaHorario } = require('../controllers/horario.controller');

// Obtener doctores filtrados por Área
router.get('/obtenerLista/:idDoctor', listaHorario);

module.exports = router;