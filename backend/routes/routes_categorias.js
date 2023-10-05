const express = require('express')
const router = express.Router()
const controller = require('../controllers/controller_categorias.js')

// Rutas disponibles y las funciones que se llaman
router.get('/getAll', controller.getAll)
router.get('/get/:id_isla', controller.get)
router.post('/add', controller.add)
router.delete('/remove/:id_isla', controller.remove)
router.put('/update/:id_isla', controller.update)
router.get('/getWithPalabras', controller.getWithPalabras)

module.exports = router