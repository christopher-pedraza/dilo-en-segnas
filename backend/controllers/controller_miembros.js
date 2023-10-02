const { PrismaClient } = require('@prisma/client')
const prisma = new PrismaClient()

async function getAllMiembros(req, res, next) {
	try {
		const resultado = await prisma.miembro.findMany()
		res.status(200).json(resultado)
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
	}
}

async function getMiembro(req, res, next) {
	try {
		const resultado = await prisma.miembro.findUnique({
			where: { id_miembro: Number(req.params.id_miembro) }
		})
		res.status(200).json(resultado)
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
	}
}

async function addMiembro(req, res, next) {
	body = req.body
	try {
		const resultado = await prisma.miembro.create({
			data: {
				usuario: body.usuario,
				contrasegna: body.contrasegna,
				es_administrador: body.es_administrador.toLowerCase() == "true"
			}
		})
		res.status(200).json(resultado)
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
	}
}

async function removeMiembro(req, res, next) {
	try {
		const resultado = await prisma.miembro.delete({
			where: { id_miembro: Number(req.params.id_miembro) }
		})
		res.status(200).json(resultado)
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
	}
}

async function updateMiembro(req, res, next) {
	body = req.body
	try {
		const resultado = await prisma.miembro.update({
			where: { id_miembro: Number(req.params.id_miembro) },
			data: {
				usuario: body.usuario,
				contrasegna: body.contrasegna,
				es_administrador: body.es_administrador.toLowerCase() == "true"
			},
		})
		res.status(200).json(resultado)
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
	}
}

module.exports = {
	getAllMiembros,
	getMiembro,
	addMiembro,
	removeMiembro,
	updateMiembro
}