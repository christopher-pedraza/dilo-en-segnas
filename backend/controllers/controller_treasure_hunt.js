const { PrismaClient } = require('@prisma/client')
const prisma = new PrismaClient()

async function getAll(req, res, next) {
	try {
		const resultado = await prisma.treasure_hunt.findMany()
		res.status(200).json(resultado)
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
	}
}

async function get(req, res, next) {
	try {
		const resultado = await prisma.treasure_hunt.findUnique({
			where: {
				id_treasure_hunt: Number(req.params.id)
			}
		})
		res.status(200).json(resultado)
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
	}
}

async function getPalabrasByActividad(req, res, next) {
	try {
		const th = await prisma.treasure_hunt.findUnique({
			where: {
				id_treasure_hunt: Number(req.params.id)
			},
		})
		const palabras = await prisma.palabra.findMany({
			where: {
				id_isla: th.id_isla
			},
			select: {
				palabra: true,
				url_icono: true,
				id_video_segna: true,
			},
		})
		res.status(200).json(palabras)
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
	}
}

async function add(req, res, next) {
	body = req.body
	try {
		const resultado = await prisma.treasure_hunt.create({
			data: {
				id_isla: body.id_isla,
				id_modelo_coml: body.id_modelo_coml,
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
		const resultado = await prisma.treasure_hunt.delete({
			where: { id_treasure_hunt: Number(req.params.id) }
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
		const resultado = await prisma.treasure_hunt.update({
			where: { id_treasure_hunt: Number(req.params.id) },
			data: {
				id_isla: body.id_isla,
				id_modelo_coml: body.id_modelo_coml,
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
	getPalabrasByActividad,
	add,
	remove,
	update,
}