const express = require('express')
const router = express.Router()
const controller = require('../controllers/controller_progreso.js')

router.post('/descubrir_isla/:id', controller.descubrir_isla)
router.post('/actualizar_progreso/:id', controller.actualizar_progreso)

module.exports = router