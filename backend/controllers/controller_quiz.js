const { PrismaClient } = require('@prisma/client')
const prisma = new PrismaClient()

async function getAll(req, res, next) {
	try {
		const resultado = await prisma.quiz.findMany()
		res.status(200).json(resultado)
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
	}
}

async function get(req, res, next) {
	try {
		const resultado = await prisma.quiz.findUnique({
			where: {
				id_quiz: Number(req.params.id_quiz)
			}
		})
		res.status(200).json(resultado)
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
	}
}

async function add(req, res, next) {
	body = req.body
	try {
		const resultado = await prisma.quiz.create({
			data: {
				id_isla: Number(body.id_isla),
				nombre: body.nombre,
			}
		})
		res.status(200).json(resultado)
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
	}
}

async function remove(req, res, next) {
	try {
		const resultado = await prisma.quiz.delete({
			where: { id_quiz: Number(req.params.id_quiz) }
		})
		res.status(200).json(resultado)
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
	}
}

async function update(req, res, next) {
	body = req.body
	try {
		const resultado = await prisma.quiz.update({
			where: { id_quiz: Number(req.params.id_quiz) },
			data: {
				id_isla: Number(body.id_isla),
				nombre: body.nombre,
			}
		})
		res.status(200).json(resultado)
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
	}
}

async function addPalabra(req, res, next) {
	try {
		const resultado = await prisma.detalles_quiz.create({
			data: {
				id_quiz: Number(body.id_quiz),
				id_palabra: Number(body.id_palabra)
			}
		})
		res.status(200).json(resultado)
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
	}
}

async function removePalabra(req, res, next) {
	try {
		const resultado = await prisma.detalles_quiz.delete({
			where: {
				id_quiz: Number(req.params.id_quiz),
				id_palabra: Number(req.params.id_palabra)
			}
		})
		res.status(200).json(resultado)
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
	}
}

async function getPalabrasByQuiz(req, res, next) {
	try {
		const resultado = await prisma.quiz.findUnique({
			where: {
				id_quiz: Number(req.params.id_quiz)
			},
			include: {
				detalles_quiz: true
			},
			select: {
				palabra: true,
				id_video_segna: true
			}
		})
		res.status(200).json(resultado)
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
	}
}

module.exports = {
	getAll,
	get,
	add,
	remove,
	update,
	addPalabra,
	removePalabra,
	getPalabrasByQuiz
}