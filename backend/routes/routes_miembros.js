const express = require('express')
const router = express.Router()
const controller = require('../controllers/controller_miembros.js')

// Rutas disponibles y las funciones que se llaman
router.get('/getAll', controller.getAll)
router.get('/get/:id_miembro', controller.get)
router.post('/add', controller.add)
router.delete('/remove/:id_miembro', controller.remove)
router.put('/update/:id_miembro', controller.update)

module.exports = router