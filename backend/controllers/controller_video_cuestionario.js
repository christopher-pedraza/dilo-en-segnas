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

async function getComplete(req, res, next) {
	try {
		const resultado = await prisma.video_cuestionario.findUnique({
			where: {
				id_video_cuestionario: Number(req.params.id)
			},
			include: {
				palabras_video_cuestionario: {
					include: {
						palabra: true
					}
				},
				parte_video_cuestionario: {
					include: {
						preguntas_video_cuestionario: {
							include: {
								respuestas_video_cuestionario: true
							}
						}
					}
				}
			},
		})
		res.status(200).json(resultado)
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
	}
}

async function getData(req, res, next) {
	try {
		const resultado = await prisma.video_cuestionario.findUnique({
			where: {
				id_video_cuestionario: Number(req.params.id)
			},
			select: {
				_count: {
					select: {
						parte_video_cuestionario: true,
					}
				},
				parte_video_cuestionario: {
					select: {
						url_video: true,
						indice: true,
						preguntas_video_cuestionario: {
							select: {
								pregunta: true,
								_count: {
									select: {
										respuestas_video_cuestionario: {
											where: {
												es_correcta: true
											}
										}
									}
								},
								respuestas_video_cuestionario: {
									select: {
										respuesta: true,
										es_correcta: true,
									}
								}
							}
						}
					}
				}
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

async function addWithPalabras(req, res, next) {
	body = req.body
	try {
		const res_cuestionario = await prisma.video_cuestionario.create({
			data: {
				id_isla: body.id_isla,
			}
		})

		for (let n = 0; n < body.palabras.length; n++) {
			const res_palabras = await prisma.palabras_video_cuestionario.create({
				data: {
					id_video_cuestionario: res_cuestionario.id_video_cuestionario,
					id_palabra: body.palabras[n]
				}
			})
		}
		res.status(200).json(res_cuestionario)
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
		console.log(err)
	}
}

async function addParte(req, res, next) {
	body = req.body
	try {
		const res_parte = await prisma.parte_video_cuestionario.create({
			data: {
				id_video_cuestionario: body.id_video_cuestionario,
				url_video: body.url_video,
				indice: body.indice,
			}
		})

		for (let j = 0; j < body.preguntas.length; j++) {
			const res_pregunta = await prisma.preguntas_video_cuestionario.create({
				data: {
					id_parte_video_cuestionario: res_parte.id_parte_video_cuestionario,
					pregunta: body.preguntas[j].pregunta,
				}
			})

			for (let k = 0; k < body.preguntas[j].respuestas.length; k++) {
				const res_respuesta = await prisma.respuestas_video_cuestionario.create({
					data: {
						id_preguntas_video_cuestionario: res_pregunta.id_preguntas_video_cuestionario,
						respuesta: body.preguntas[j].respuestas[k].respuesta,
						es_correcta: body.preguntas[j].respuestas[k].es_correcta,
					}
				})
			}
		}
		res.status(200).json(res_parte)
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
		console.log(err)
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

		for (let n = 0; n < body.palabras.length; n++) {
			const res_palabras = await prisma.palabras_video_cuestionario.create({
				data: {
					id_video_cuestionario: res_cuestionario.id_video_cuestionario,
					id_palabra: body.palabras[n]
				}
			})
		}

		for (let i = 0; i < body.partes.length; i++) {
			const res_parte = await prisma.parte_video_cuestionario.create({
				data: {
					id_video_cuestionario: res_cuestionario.id_video_cuestionario,
					url_video: body.partes[i].url_video,
					indice: i,
				}
			})

			for (let j = 0; j < body.partes[i].preguntas.length; j++) {
				const res_pregunta = await prisma.preguntas_video_cuestionario.create({
					data: {
						id_parte_video_cuestionario: res_parte.id_parte_video_cuestionario,
						pregunta: body.partes[i].preguntas[j].pregunta,
					}
				})

				for (let k = 0; k < body.partes[i].preguntas[j].respuestas.length; k++) {
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
		res.status(200).json(res_cuestionario)
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
		console.log(err)
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
	getComplete,
	getData,
	add,
	addWithPalabras,
	addParte,
	addComplete,
	remove,
	update,
}