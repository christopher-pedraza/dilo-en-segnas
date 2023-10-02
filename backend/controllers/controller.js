const { PrismaClient } = require('@prisma/client')
const prisma = new PrismaClient()

/*
MIEMBROS
*/
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

/*
CATEGORIAS
*/
async function getAllCategorias(req, res, next) {
	try {
		const resultado = await prisma.isla.findMany()
		res.status(200).json(resultado)
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
	}
}

async function getCategoria(req, res, next) {
	try {
		const resultado = await prisma.isla.findUnique({
			where: {
				id_isla: Number(req.params.id_isla)
			}
		})
		res.status(200).json(resultado)
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
	}
}

async function addCategoria(req, res, next) {
	body = req.body
	try {
		const resultado = await prisma.isla.create({
			data: {
				nombre: body.nombre,
				modelo_general: null,
				modelo_especifico: null
			}
		})
		res.status(200).json(resultado)
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
	}
}

async function removeCategoria(req, res, next) {
	try {
		const resultado = await prisma.isla.delete({
			where: { id_isla: Number(req.params.id_isla) }
		})
		res.status(200).json(resultado)
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
	}
}

async function updateCategoria(req, res, next) {
	body = req.body
	try {
		const resultado = await prisma.isla.update({
			where: { id_isla: Number(req.params.id_isla) },
			data: {
				nombre: body.nombre
			}
		})
		res.status(200).json(resultado)
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
	}
}


// Para exportar multiples funciones
module.exports = {
	getAllMiembros,
	getMiembro,
	addMiembro,
	removeMiembro,
	updateMiembro,
	getAllCategorias,
	getCategoria,
	addCategoria,
	removeCategoria,
	updateCategoria
}