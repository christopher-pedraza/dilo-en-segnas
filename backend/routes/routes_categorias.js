const express = require('express')
const router = express.Router()
const controller = require('../controllers/controller_categorias.js')

// Rutas disponibles y las funciones que se llaman
router.get('/getAll', controller.getAllCategorias)
router.get('/get/:id_isla', controller.getCategoria)
router.post('/add', controller.addCategoria)
router.delete('/remove/:id_isla', controller.removeCategoria)
router.put('/update/:id_isla', controller.updateCategoria)

module.exports = router