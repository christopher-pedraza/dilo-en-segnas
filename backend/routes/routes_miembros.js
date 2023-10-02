const express = require('express')
const router = express.Router()
const controller = require('../controllers/controller_miembros.js')

// Rutas disponibles y las funciones que se llaman
router.get('/getAll', controller.getAllMiembros)
router.get('/get/:id_miembro', controller.getMiembro)
router.post('/add', controller.addMiembro)
router.delete('/remove/:id_miembro', controller.removeMiembro)
router.put('/update/:id_miembro', controller.updateMiembro)

module.exports = router