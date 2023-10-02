const express = require('express')
const router = express.Router()
const controller = require('../controllers/controller_palabras.js')

// Rutas disponibles y las funciones que se llaman
router.get('/getAll', controller.getAll)
router.get('/get/:id_palabra', controller.get)
router.post('/add', controller.add)
router.delete('/remove/:id_palabra', controller.remove)
router.put('/update/:id_palabra', controller.update)
router.get('/getByCategoria/:id_isla', controller.getPalabrasByCategoria)

module.exports = router