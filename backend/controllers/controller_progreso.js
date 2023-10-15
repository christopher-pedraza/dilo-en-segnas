const { PrismaClient } = require('@prisma/client')
const prisma = new PrismaClient()
var sha512 = require('js-sha512')

async function getAll(req, res, next) {
	try {
		const resultado = await prisma.miembro.findMany()
		res.status(200).json(resultado)
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
	}
}

async function get(req, res, next) {
	try {
		const resultado = await prisma.miembro.findUnique({
			where: { id_miembro: Number(req.params.id) }
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
		const resultado = await prisma.miembro.create({
			data: {
				usuario: body.usuario,
				contrasegna: sha512(body.contrasegna),
				es_administrador: body.es_administrador
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
		const resultado = await prisma.miembro.delete({
			where: { id_miembro: Number(req.params.id) }
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
		const resultado = await prisma.miembro.update({
			where: { id_miembro: Number(req.params.id) },
			data: {
				usuario: body.usuario,
				contrasegna: sha512(body.contrasegna),
				es_administrador: body.es_administrador
			},
		})
		res.status(200).json(resultado)
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
	}
}

async function login(req, res, next) {
	body = req.body
	try {
		const resultado = await prisma.miembro.findMany({
			where: {
				AND: {
					usuario: body.usuario,
					contrasegna: sha512(body.contrasegna),
				},
			},
		})
		if (resultado.length != 0) {
			res.status(200).json(true)
		} else {
			res.status(200).json(false)
		}
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
	login,
}