const express = require('express')
const router = express.Router()
const controller = require('../controllers/controller_progreso.js')

// Rutas disponibles y las funciones que se llaman
router.get('/getAll', controller.getAll)
router.get('/get/:id', controller.get)
router.post('/add', controller.add)
router.delete('/remove/:id', controller.remove)
router.put('/update/:id', controller.update)

module.exports = router