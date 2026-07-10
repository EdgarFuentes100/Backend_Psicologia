const express = require('express');
const router = express.Router();
const { listaCitas, registrarCita } = require('../controllers/cita.controller');

// Obtener doctores filtrados por Área
router.get('/obtenerLista/:idUsuario', listaCitas);
router.post('/registrar', registrarCita);

module.exports = router;