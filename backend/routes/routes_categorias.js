const express = require('express')
const router = express.Router()
const controller = require('../controllers/controller_categorias.js')

// Rutas disponibles y las funciones que se llaman
router.get('/getAll', controller.getAll)
router.get('/get/:id_isla', controller.get)
router.get('/getWithPalabras/:id_isla', controller.getWithPalabras)
router.post('/add', controller.add)
router.delete('/remove/:id_isla', controller.remove)
router.put('/update/:id_isla', controller.update)

module.exports = router