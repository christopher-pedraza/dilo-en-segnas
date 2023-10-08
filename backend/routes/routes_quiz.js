const express = require('express')
const router = express.Router()
const controller = require('../controllers/controller_quiz.js')

// Rutas disponibles y las funciones que se llaman
router.get('/getAll', controller.getAll)
router.get('/get/:id', controller.get)
router.get('/getPalabrasByQuiz/:id', controller.getPalabrasByQuiz)
router.get('/getComplete/:id', controller.getComplete)
router.post('/add', controller.add)
router.post('/addConPalabras', controller.addConPalabras)
router.delete('/remove/:id', controller.remove)
router.put('/update/:id', controller.update)
router.post('/addPalabra/:id', controller.addPalabra)
router.delete('/removePalabra/:id', controller.removePalabra)

module.exports = router