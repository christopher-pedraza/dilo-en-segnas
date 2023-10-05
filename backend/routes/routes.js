const express = require('express')
const router = express.Router()

router.use('/miembros', require('./routes_miembros.js'))
router.use('/categorias', require('./routes_categorias.js'))
router.use('/palabras', require('./routes_palabras.js'))
router.use('/quiz', require('./routes_quiz.js'))

module.exports = router