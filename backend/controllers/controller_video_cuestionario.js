const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

async function getAll(req, res, next) {
	try {
		const resultado = await prisma.video_cuestionario.findMany();
		res.status(200).json(resultado);
	} catch (err) {
		res.status(500).json({ message: `${err}` });
	}
}

async function get(req, res, next) {
	try {
		const resultado = await prisma.video_cuestionario.findUnique({
			where: {
				id_video_cuestionario: Number(req.params.id),
			},
		});
		res.status(200).json(resultado);
	} catch (err) {
		res.status(500).json({ message: `${err}` });
	}
}

async function getComplete(req, res, next) {
	try {
		const resultado = await prisma.video_cuestionario.findUnique({
			where: {
				id_video_cuestionario: Number(req.params.id),
			},
			include: {
				palabras_video_cuestionario: {
					include: {
						palabra: true,
					},
				},
				parte_video_cuestionario: {
					include: {
						preguntas_video_cuestionario: {
							include: {
								respuestas_video_cuestionario: true,
							},
						},
					},
				},
			},
		});
		res.status(200).json(resultado);
	} catch (err) {
		res.status(500).json({ message: `${err}` });
	}
}

async function getData(req, res, next) {
	try {
		const resultado = await prisma.video_cuestionario.findUnique({
			where: {
				id_video_cuestionario: Number(req.params.id)
			},
			select: {
				nombre: true,
				_count: {
					select: {
						parte_video_cuestionario: true,
					}
				},
				parte_video_cuestionario: {
					select: {
						nombre: true,
						url_video: true,
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
					},
					orderBy: { indice: 'asc' }
				}
			}
		})
		res.status(200).json(resultado)
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
	}
}

async function getParteSimplified(req, res, next) {
	try {
		const parte = await prisma.parte_video_cuestionario.findUnique({
			where: {
				id_parte_video_cuestionario: Number(req.params.id)
			},
		})
		const pregunta = await prisma.preguntas_video_cuestionario.findFirst({
			where: {
				id_parte_video_cuestionario: parte.id_parte_video_cuestionario
			},
		})
		const respuestas = await prisma.respuestas_video_cuestionario.findMany({
			where: {
				id_preguntas_video_cuestionario: pregunta.id_preguntas_video_cuestionario
			},
		})

		correctaIndex = 0
		for (let index = 1; index <= respuestas.length; index++) {
			if (respuestas[index - 1].es_correcta) {
				correctaIndex = index
				break
			}

		}
		res.status(200).json({
			id_parte_video_cuestionario: parte.id_parte_video_cuestionario,
			indice: parte.indice,
			nombre: parte.nombre,
			url_video: parte.url_video,
			pregunta: pregunta.pregunta,
			respuesta1: respuestas[0].respuesta,
			respuesta2: respuestas[1].respuesta,
			respuesta3: respuestas[2].respuesta,
			respuesta4: respuestas[3].respuesta,
			respuestaC: correctaIndex
		})
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
	}
}

async function getPartes(req, res, next) {
	try {
		const resultado = await prisma.parte_video_cuestionario.findMany({
			where: {
				id_video_cuestionario: Number(req.params.id)
			},
			select: {
				id_parte_video_cuestionario: true,
				nombre: true,
				url_video: true,
				indice: true,
				preguntas_video_cuestionario: {
					select: {
						pregunta: true,
						respuestas_video_cuestionario: {
							select: {
								respuesta: true,
								es_correcta: true,
							},
						},
					},
				},
			},
			orderBy: { indice: 'asc' },
		})
		res.status(200).json(resultado)
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
	}
}

async function add(req, res, next) {
	body = req.body;
	try {
		const resultado = await prisma.video_cuestionario.create({
			data: {
				id_isla: body.id_isla,
				nombre: body.nombre,
			},
		});
		res.status(200).json(resultado);
	} catch (err) {
		res.status(500).json({ message: `${err}` });
	}
}

async function addWithPalabras(req, res, next) {
	body = req.body;
	try {
		const res_cuestionario = await prisma.video_cuestionario.create({
			data: {
				id_isla: body.id_isla,
				nombre: body.nombre,
			},
		});

		for (let n = 0; n < body.palabras.length; n++) {
			const res_palabras = await prisma.palabras_video_cuestionario.create({
				data: {
					id_video_cuestionario: res_cuestionario.id_video_cuestionario,
					id_palabra: body.palabras[n],
				},
			});
		}
		res.status(200).json(res_cuestionario);
	} catch (err) {
		res.status(500).json({ message: `${err}` });
		console.log(err);
	}
}

async function addParte(req, res, next) {
	body = req.body;
	try {
		const res_parte = await prisma.parte_video_cuestionario.create({
			data: {
				id_video_cuestionario: body.id_video_cuestionario,
				nombre: body.nombre,
				url_video: body.url_video,
				indice: body.indice,
			},
		});

		for (let j = 0; j < body.preguntas.length; j++) {
			const res_pregunta = await prisma.preguntas_video_cuestionario.create({
				data: {
					id_parte_video_cuestionario: res_parte.id_parte_video_cuestionario,
					pregunta: body.preguntas[j].pregunta,
				},
			});

			for (let k = 0; k < body.preguntas[j].respuestas.length; k++) {
				const res_respuesta = await prisma.respuestas_video_cuestionario.create(
					{
						data: {
							id_preguntas_video_cuestionario:
								res_pregunta.id_preguntas_video_cuestionario,
							respuesta: body.preguntas[j].respuestas[k].respuesta,
							es_correcta: body.preguntas[j].respuestas[k].es_correcta,
						},
					}
				);
			}
		}
		res.status(200).json(res_parte);
	} catch (err) {
		res.status(500).json({ message: `${err}` });
		console.log(err);
	}
}

async function addParteSimplified(req, res, next) {
	body = req.body
	try {
		// Parte
		const res_parte = await prisma.parte_video_cuestionario.create({
			data: {
				id_video_cuestionario: body.id_video_cuestionario,
				nombre: body.nombre,
				url_video: body.url_video,
				indice: body.indice,
			}
		})
		// Pregunta
		const res_pregunta = await prisma.preguntas_video_cuestionario.create({
			data: {
				id_parte_video_cuestionario: res_parte.id_parte_video_cuestionario,
				pregunta: body.pregunta,
			}
		})
		// Respuestas
		await prisma.respuestas_video_cuestionario.create({
			data: {
				id_preguntas_video_cuestionario: res_pregunta.id_preguntas_video_cuestionario,
				respuesta: body.respuesta1,
				es_correcta: 1 == body.respuestaC,
			}
		})
		await prisma.respuestas_video_cuestionario.create({
			data: {
				id_preguntas_video_cuestionario: res_pregunta.id_preguntas_video_cuestionario,
				respuesta: body.respuesta2,
				es_correcta: 2 == body.respuestaC,
			}
		})
		await prisma.respuestas_video_cuestionario.create({
			data: {
				id_preguntas_video_cuestionario: res_pregunta.id_preguntas_video_cuestionario,
				respuesta: body.respuesta3,
				es_correcta: 3 == body.respuestaC,
			}
		})
		await prisma.respuestas_video_cuestionario.create({
			data: {
				id_preguntas_video_cuestionario: res_pregunta.id_preguntas_video_cuestionario,
				respuesta: body.respuesta4,
				es_correcta: 4 == body.respuestaC,
			}
		})
		res.status(200).json(res_parte)
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
		console.log(err)
	}
}

async function addComplete(req, res, next) {
	body = req.body;
	try {
		const res_cuestionario = await prisma.video_cuestionario.create({
			data: {
				id_isla: body.id_isla,
				nombre: body.nombre,
			},
		});

		for (let n = 0; n < body.palabras.length; n++) {
			const res_palabras = await prisma.palabras_video_cuestionario.create({
				data: {
					id_video_cuestionario: res_cuestionario.id_video_cuestionario,
					id_palabra: body.palabras[n],
				},
			});
		}

		for (let i = 0; i < body.partes.length; i++) {
			const res_parte = await prisma.parte_video_cuestionario.create({
				data: {
					id_video_cuestionario: res_cuestionario.id_video_cuestionario,
					nombre: body.nombre,
					url_video: body.partes[i].url_video,
					indice: i,
				},
			});

			for (let j = 0; j < body.partes[i].preguntas.length; j++) {
				const res_pregunta = await prisma.preguntas_video_cuestionario.create({
					data: {
						id_parte_video_cuestionario: res_parte.id_parte_video_cuestionario,
						pregunta: body.partes[i].preguntas[j].pregunta,
					},
				});

				for (
					let k = 0;
					k < body.partes[i].preguntas[j].respuestas.length;
					k++
				) {
					const res_respuesta =
						await prisma.respuestas_video_cuestionario.create({
							data: {
								id_preguntas_video_cuestionario:
									res_pregunta.id_preguntas_video_cuestionario,
								respuesta: body.partes[i].preguntas[j].respuestas[k].respuesta,
								es_correcta:
									body.partes[i].preguntas[j].respuestas[k].es_correcta,
							},
						});
				}
			}
		}
		res.status(200).json(res_cuestionario);
	} catch (err) {
		res.status(500).json({ message: `${err}` });
		console.log(err);
	}
}

async function remove(req, res, next) {
	try {
		const resultado = await prisma.video_cuestionario.delete({
			where: { id_video_cuestionario: Number(req.params.id) },
		});
		res.status(200).json(resultado);
	} catch (err) {
		res.status(500).json({ message: `${err}` });
	}
}

async function removeParte(req, res, next) {
	try {
		const resultado = await prisma.parte_video_cuestionario.delete({
			where: { id_parte_video_cuestionario: Number(req.params.id) }
		})
		res.status(200).json(resultado)
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
	}
}

async function update(req, res, next) {
	body = req.body;
	try {
		const resultado = await prisma.video_cuestionario.update({
			where: { id_video_cuestionario: Number(req.params.id) },
			data: {
				id_isla: body.id_isla,
				nombre: body.nombre,
			},
		});

		const res_remove = await prisma.palabras_video_cuestionario.deleteMany({
			where: { id_video_cuestionario: Number(req.params.id) },
		});

		palabras = body.palabras;
		for (let i = 0; i < palabras.length; i++) {
			await prisma.palabras_video_cuestionario.create({
				data: {
					id_video_cuestionario: Number(req.params.id),
					id_palabra: palabras[i],
				},
			});
		}

		res.status(200).json(resultado);
	} catch (err) {
		res.status(500).json({ message: `${err}` });
	}
}

async function updateParteSimplified(req, res, next) {
	body = req.body
	try {
		// Parte
		const res_parte = await prisma.parte_video_cuestionario.update({
			where: {
				id_parte_video_cuestionario: Number(req.params.id)
			},
			data: {
				id_video_cuestionario: body.id_video_cuestionario,
				nombre: body.nombre,
				url_video: body.url_video,
				indice: body.indice,
			}
		})

		// Pregunta
		await prisma.preguntas_video_cuestionario.deleteMany({
			where: {
				id_parte_video_cuestionario: Number(req.params.id),
			},
		})
		const res_pregunta = await prisma.preguntas_video_cuestionario.create({
			data: {
				id_parte_video_cuestionario: Number(req.params.id),
				pregunta: body.pregunta,
			}
		})

		// Respuestas
		await prisma.respuestas_video_cuestionario.deleteMany({
			where: {
				id_preguntas_video_cuestionario: res_pregunta.id_preguntas_video_cuestionario,
			},
		})
		await prisma.respuestas_video_cuestionario.create({
			data: {
				id_preguntas_video_cuestionario: res_pregunta.id_preguntas_video_cuestionario,
				respuesta: body.respuesta1,
				es_correcta: 1 == body.respuestaC,
			}
		})
		await prisma.respuestas_video_cuestionario.create({
			data: {
				id_preguntas_video_cuestionario: res_pregunta.id_preguntas_video_cuestionario,
				respuesta: body.respuesta2,
				es_correcta: 2 == body.respuestaC,
			}
		})
		await prisma.respuestas_video_cuestionario.create({
			data: {
				id_preguntas_video_cuestionario: res_pregunta.id_preguntas_video_cuestionario,
				respuesta: body.respuesta3,
				es_correcta: 3 == body.respuestaC,
			}
		})
		await prisma.respuestas_video_cuestionario.create({
			data: {
				id_preguntas_video_cuestionario: res_pregunta.id_preguntas_video_cuestionario,
				respuesta: body.respuesta4,
				es_correcta: 4 == body.respuestaC,
			}
		})
		res.status(200).json(res_parte)
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
		console.log(err)
	}
}

module.exports = {
	getAll,
	get,
	getComplete,
	getData,
	getPartes,
	getParteSimplified,
	add,
	addWithPalabras,
	addParte,
	addParteSimplified,
	addComplete,
	remove,
	removeParte,
	update,
	updateParteSimplified,
}