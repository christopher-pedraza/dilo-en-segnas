const express = require('express')
const router = express.Router()
const controller = require('../controllers/controller_quiz.js')

// Rutas disponibles y las funciones que se llaman
router.get('/getAll', controller.getAll)
router.get('/get/:id_quiz', controller.get)
router.post('/add', controller.add)
router.post('/addConPalabras', controller.addConPalabras)
router.delete('/remove/:id_quiz', controller.remove)
router.put('/update/:id_quiz', controller.update)
router.post('/addPalabra/:id_quiz', controller.addPalabra)
router.delete('/removePalabra/:id_quiz', controller.removePalabra)
router.get('/getPalabrasByQuiz/:id_quiz', controller.getPalabrasByQuiz)

module.exports = router