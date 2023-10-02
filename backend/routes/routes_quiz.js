const express = require('express')
const router = express.Router()
const controller = require('../controllers/controller_quiz.js')

// Rutas disponibles y las funciones que se llaman
router.get('/getPalabrasByCategoria/:id_isla', controller.getPalabrasByCategoria)

module.exports = router