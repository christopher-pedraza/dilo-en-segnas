const express = require('express')
const router = express.Router()
const controller = require('../controllers/controller_progreso.js')

router.post('/descubrir_isla/:id', controller.descubrir_isla)
router.post('/actualizar_progreso/:id', controller.actualizar_progreso)
router.get('/get_islas_descubiertas/:id', controller.get_islas_descubiertas)
router.get('/get_data_islas_descubiertas/:id', controller.get_data_islas_descubiertas)

module.exports = router