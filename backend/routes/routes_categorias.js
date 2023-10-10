const express = require('express')
const router = express.Router()
const controller = require('../controllers/controller_categorias.js')

// Rutas disponibles y las funciones que se llaman
router.get('/getAll', controller.getAll)
router.get('/get/:id', controller.get)
router.get('/getWithPalabras/:id', controller.getWithPalabras)
router.get('/getAllWithPalabras', controller.getAllWithPalabras)
router.post('/add', controller.add)
router.delete('/remove/:id', controller.remove)
router.put('/update/:id', controller.update)

module.exports = router