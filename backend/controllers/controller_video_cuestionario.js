const { PrismaClient } = require('@prisma/client')
const prisma = new PrismaClient()

async function getAll(req, res, next) {
	try {
		const resultado = await prisma.video_cuestionario.findMany()
		res.status(200).json(resultado)
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
	}
}

async function get(req, res, next) {
	try {
		const resultado = await prisma.video_cuestionario.findUnique({
			where: {
				id_video_cuestionario: Number(req.params.id)
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
		const resultado = await prisma.video_cuestionario.create({
			data: {
				id_isla: body.id_isla,
			}
		})
		res.status(200).json(resultado)
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
	}
}

async function addComplete(req, res, next) {
	body = req.body
	try {
		const res_cuestionario = await prisma.video_cuestionario.create({
			data: {
				id_isla: body.id_isla,
			}
		})

		for (let n = 0; n < body.palabras; n++) {
			const res_palabras = await prisma.palabras_video_cuestionario.create({
				data: {
					id_parte_video_cuestionario: res_parte.id_parte_video_cuestionario,
					pregunta: body.partes[i].preguntas[j].pregunta,
				}
			})
		}

		for (let i = 0; i < body.partes.length; i++) {
			const res_parte = await prisma.parte_video_cuestionario.create({
				data: {
					id_video_cuestionario: res_cuestionario.id_video_cuestionario,
					indice: i,
				}
			})

			for (let j = 0; j < body.partes[i].preguntas; j++) {
				const res_pregunta = await prisma.preguntas_video_cuestionario.create({
					data: {
						id_parte_video_cuestionario: res_parte.id_parte_video_cuestionario,
						pregunta: body.partes[i].preguntas[j].pregunta,
					}
				})

				for (let k = 0; k < body.partes[i].preguntas[j].respuestas; k++) {
					const res_respuesta = await prisma.respuestas_video_cuestionario.create({
						data: {
							id_preguntas_video_cuestionario: res_pregunta.id_preguntas_video_cuestionario,
							respuesta: body.partes[i].preguntas[j].respuestas[k].respuesta,
							es_correcta: body.partes[i].preguntas[j].respuestas[k].es_correcta,
						}
					})
				}

			}

		}

		res.status(200).json(resultado)
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
	}
}

async function remove(req, res, next) {
	try {
		const resultado = await prisma.video_cuestionario.delete({
			where: { id_video_cuestionario: Number(req.params.id) }
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
		const resultado = await prisma.video_cuestionario.update({
			where: { id_video_cuestionario: Number(req.params.id) },
			data: {
				id_isla: body.id_isla,
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
}