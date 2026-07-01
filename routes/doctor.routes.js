const express = require('express');
const router = express.Router();
const { listaDoctor } = require('../controllers/doctor.controller');

// Obtener doctores filtrados por Área
router.get('/obtenerLista/:idArea', listaDoctor);

module.exports = router;