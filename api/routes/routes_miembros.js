const express = require('express')
const router = express.Router()
const miembros = require('../controllers/controller_miembros.js')

// Rutas disponibles y las funciones que se llaman
router.get('/getAll', miembros.getAll)
router.get('/get/:id_miembro', miembros.get)
router.post('/add', miembros.add)
router.delete('/remove/:id_miembro', miembros.remove)
router.put('/update/:id_miembro', miembros.update)

module.exports = router