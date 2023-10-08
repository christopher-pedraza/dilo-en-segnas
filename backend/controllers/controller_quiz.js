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
				id_quiz: Number(req.params.id)
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
		const resultado = await prisma.quiz.findMany({
			where: {
				id_quiz: Number(req.params.id)
			},
			select: {
				detalles_quiz: {
					select: {
						palabra: {
							select: {
								palabra: true,
								id_video_segna: true
							}
						}
					}
				}
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
				id_isla: body.id_isla,
				nombre: body.nombre,
			}
		})
		res.status(200).json(resultado)
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
	}
}

async function addConPalabras(req, res, next) {
	body = req.body
	try {
		const resultado = await prisma.quiz.create({
			data: {
				id_isla: body.id_isla,
				nombre: body.nombre,
			}
		})
		res.status(200).json(resultado)

		palabras = body.palabras
		for (let i = 0; i < palabras.length; i++) {
			await prisma.detalles_quiz.create({
				data: {
					id_quiz: resultado.id_quiz,
					id_palabra: palabras[i].id_palabra
				}
			})
		}
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
	}
}

async function remove(req, res, next) {
	try {
		const resultado = await prisma.quiz.delete({
			where: { id_quiz: Number(req.params.id) }
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
			where: { id_quiz: Number(req.params.id) },
			data: {
				id_isla: body.id_isla,
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
	body = req.body
	try {
		const resultado = await prisma.detalles_quiz.create({
			data: {
				id_quiz: Number(req.params.id),
				id_palabra: body.id_palabra
			}
		})
		res.status(200).json(resultado)
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
	}
}

async function removePalabra(req, res, next) {
	body = req.body
	try {
		const resultado = await prisma.detalles_quiz.deleteMany({
			where: {
				AND: [
					{ id_quiz: Number(req.params.id) },
					{ id_palabra: body.id_palabra }
				]
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
	getPalabrasByQuiz,
	add,
	addConPalabras,
	addPalabra,
	remove,
	removePalabra,
	update,
}