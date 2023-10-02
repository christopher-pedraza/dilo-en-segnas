const { PrismaClient } = require('@prisma/client')
const prisma = new PrismaClient()

async function getPalabrasByCategoria(req, res, next) {
	try {
		const resultado = await prisma.palabra.findMany({
			where: {
				id_isla: Number(req.params.id_isla)
			},
			select: {
				palabra: true,
				id_video_segna: true
			}
		})
		res.status(200).json(resultado)
	}
	catch (err) {
		res.status(500).json({ "message": `${err}` })
	}
}

module.exports = {
	getPalabrasByCategoria
}