const { PrismaClient } = require('@prisma/client')
const prisma = new PrismaClient()

async function getAll(req, res, next) {
	try {
		const resultado = await prisma.palabra.findMany()
		res.status(200).json(resultado)
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
	}
}

async function get(req, res, next) {
	try {
		const resultado = await prisma.palabra.findUnique({
			where: {
				id_palabra: Number(req.params.id_palabra)
			}
		})
		res.status(200).json(resultado)
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
	}
}

async function getPalabrasByCategoria(req, res, next) {
	try {
		const resultado = await prisma.palabra.findMany({
			where: {
				id_isla: Number(req.params.id_isla)
			},
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
		const resultado = await prisma.palabra.create({
			data: {
				id_isla: body.id_isla,
				palabra: body.palabra,
				id_video_segna: body.id_video_segna,
				url_icono: body.url_icono
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
		const resultado = await prisma.palabra.delete({
			where: { id_palabra: Number(req.params.id_palabra) }
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
		const resultado = await prisma.palabra.update({
			where: { id_palabra: Number(req.params.id_palabra) },
			data: {
				id_isla: body.id_isla,
				palabra: body.palabra,
				id_video_segna: body.id_video_segna,
				url_icono: body.url_icono
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
	getPalabrasByCategoria,
	add,
	remove,
	update
}