const express = require('express')
const router = express.Router()
const controller = require('../controllers/controller.js')

// Rutas disponibles y las funciones que se llaman
router.get('/getAll', controller.getAllPalabras)
router.get('/get/:id_palabra', controller.getPalabra)
router.post('/add', controller.addPalabra)
router.delete('/remove/:id_palabra', controller.removePalabra)
router.put('/update/:id_palabra', controller.updatePalabra)
router.get('/getPalabrasByCategoria/:id_isla', controller.getPalabrasByCategoria)

module.exports = router