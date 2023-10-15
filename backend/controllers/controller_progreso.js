const { PrismaClient } = require('@prisma/client')
const prisma = new PrismaClient()

async function descubrir_isla(req, res, next) {
	try {
		const resultado = await prisma.progreso_islas.create({
			data: {
				id_miembro: Number(req.params.id),
				id_isla: req.body.id_isla,
			},
		})
		res.status(200).json(resultado)
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
	}
}

async function actualizar_progreso(req, res, next) {
	try {
		const progreso_actual = await prisma.progreso_nivel.findFirst({
			where: {
				id_miembro: Number(req.params.id),
			},
		})

		body = req.body
		if (progreso_actual == null) {
			const progreso = await prisma.progreso_nivel.create({
				data: {
					id_miembro: Number(req.params.id),
					id_nivel: body.id_nivel,
					completada_treasure_hunt: body.completada_treasure_hunt == null ? false : body.completada_treasure_hunt,
					completada_videos_cuestionario: body.completada_videos_cuestionario == null ? false : body.completada_videos_cuestionario,
					completada_quiz: body.completada_quiz == null ? false : body.completada_quiz,
				},
			})
			res.status(200).json(progreso)
		} else {
			await prisma.progreso_nivel.deleteMany({
				where: {
					AND: {
						id_miembro: Number(req.params.id),
						id_nivel: body.id_nivel,
					},
				},
			})
			const progreso = await prisma.progreso_nivel.create({
				data: {
					id_miembro: Number(req.params.id),
					id_nivel: body.id_nivel,
					completada_treasure_hunt: body.completada_treasure_hunt == null ? progreso_actual.completada_treasure_hunt : body.completada_treasure_hunt,
					completada_videos_cuestionario: body.completada_videos_cuestionario == null ? progreso_actual.completada_videos_cuestionario : body.completada_videos_cuestionario,
					completada_quiz: body.completada_quiz == null ? progreso_actual.completada_quiz : body.completada_quiz,
				},
			})
			res.status(200).json(progreso)
		}
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
	}
}

async function get_islas_descubiertas(req, res, next) {
	try {
		const resultado = await prisma.progreso_islas.findMany({
			where: {
				id_miembro: Number(req.params.id),
			},
			select: {
				isla: {
					select: {
						id_isla: true,
						nombre: true,
					},
				},
			},
		})
		res.status(200).json(resultado)
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
	}
}

async function get_islas_descubiertas_v2(req, res, next) {
	try {
		const islas = await prisma.progreso_islas.findMany({
			where: {
				id_miembro: Number(req.params.id),
			},
			select: {
				isla: {
					select: {
						id_isla: true,
						nombre: true,
					},
				},
			},
		})
		let resultado = []
		islas.forEach(isla => {
			resultado.push({ id_isla: isla.isla.id_isla, nombre: isla.isla.nombre })
		});
		res.status(200).json(resultado)
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
	}
}

module.exports = {
	descubrir_isla,
	actualizar_progreso,
	get_islas_descubiertas,
	get_islas_descubiertas_v2,
}