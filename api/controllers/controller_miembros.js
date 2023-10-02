const prisma = require('../config/db.js')

async function getAll(req, res, next) {
	try {
		const miembros = await prisma.miembro.findMany()
		res.status(200).json(miembros)
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
	}
}

async function get(req, res, next) {
	try {
		const miembro = await prisma.miembro.findUnique({
			where: { id_miembro: Number(req.params.id_miembro) }
		})
		res.status(200).json(miembro)
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
	}
}

async function add(req, res, next) {
	body = req.body
	try {
		const miembro = await prisma.miembro.create({
			data: {
				usuario: body.usuario,
				contrasegna: body.contrasegna,
				es_administrador: body.es_administrador.toLowerCase() == "true"
			}
		})
		res.status(200).json(miembro)
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
	}
}

async function remove(req, res, next) {
	try {
		const miembro = await prisma.miembro.delete({
			where: { id_miembro: Number(req.params.id_miembro) }
		})
		res.status(200).json(miembro)
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
	}
}

async function update(req, res, next) {
	body = req.body
	console.log(body.es_administrador.toLowerCase() == "true")
	try {
		const miembro = await prisma.miembro.update({
			where: { id_miembro: Number(req.params.id_miembro) },
			data: {
				usuario: body.usuario,
				contrasegna: body.contrasegna,
				es_administrador: body.es_administrador.toLowerCase() == "true"
			},
		})
		res.status(200).json(miembro)
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
	}
}

// Para exportar multiples funciones
module.exports = {
	getAll,
	get,
	add,
	remove,
	update
}