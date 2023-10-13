const express = require('express')
const router = express.Router()
const controller = require('../controllers/controller_video_cuestionario.js')

// Rutas disponibles y las funciones que se llaman
router.get('/getAll', controller.getAll)
router.get('/get/:id', controller.get)
router.get('/getComplete/:id', controller.getComplete)
router.get('/getData/:id', controller.getData)
router.get('/getPartes/:id', controller.getPartes)
router.get('/getParteSimplified/:id', controller.getParteSimplified)
router.post('/add', controller.add)
router.post('/addWithPalabras', controller.addWithPalabras)
router.post('/addParte', controller.addParte)
router.post('/addParteSimplified', controller.addParteSimplified)
router.post('/addComplete', controller.addComplete)
router.delete('/remove/:id', controller.remove)
router.delete('/removeParte/:id', controller.removeParte)
router.put('/update/:id', controller.update)
router.put('/updateParteSimplified/:id', controller.updateParteSimplified)

module.exports = router