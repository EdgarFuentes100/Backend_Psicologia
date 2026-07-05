const express = require('express');
const router = express.Router();
const { listaHorario, listaHorarioOcupado } = require('../controllers/horario.controller');

// Obtener doctores filtrados por Área
router.get('/obtenerLista/:idDoctor', listaHorario);
router.get('/obtenerCita/:idDoctor/:fecha', listaHorarioOcupado);

module.exports = router;