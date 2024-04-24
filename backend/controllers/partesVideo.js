const express = require("express");
const router = express.Router();
router.use(express.json());

const { PrismaClient } = require("@prisma/client");
const e = require("express");
const prisma = new PrismaClient();

router.get("/", async (req, res) => {
    try {
        const resultado = await prisma.parte_video_cuestionario.findMany();
        res.status(200).json(resultado);
    } catch (err) {
        res.status(500).json({ message: `${err}` });
    }
});

router.get("/getByNivel/:id", async (req, res) => {
    try {
        const { id } = req.params;
        const resultado = await prisma.parte_video_cuestionario.findMany({
            where: {
                id_nivel: parseInt(id),
            },
        });
        res.status(200).json(resultado);
    } catch (err) {
        res.status(500).json({ message: `${err}` });
    }
});

router.post("/", async (req, res) => {
    try {
        const { id_nivel, url_video, nombre } = req.body;

        // Obtener el índice más alto para el id_nivel dado
        const maxIndiceRecord = await prisma.parte_video_cuestionario.findFirst(
            {
                where: {
                    id_nivel: id_nivel,
                },
                // Al ordenarlos de manera descendente, el primer registro será el que tenga el índice más alto
                orderBy: {
                    indice: "desc",
                },
            }
        );

        // Si no existe ningun registro, el índice será 1, de lo contrario, se
        // incrementa en 1 el índice del registro con el índice más alto
        // encontrado
        const indice = maxIndiceRecord ? maxIndiceRecord.indice + 1 : 1;

        const resultado = await prisma.parte_video_cuestionario.create({
            data: {
                id_nivel: id_nivel,
                url_video: url_video,
                indice: indice,
                nombre: nombre,
            },
        });
        res.status(200).json(resultado);
    } catch (err) {
        res.status(500).json({ message: `${err}` });
    }
});

router.delete("/:id", async (req, res) => {
    try {
        const { id } = req.params;

        // Obtener el registro que se va a eliminar para obtener su índice. Esto
        // servira para poder luego actualizar todos los registros con un índice
        // mayor al índice del registro eliminado
        const recordToDelete = await prisma.parte_video_cuestionario.findUnique(
            {
                where: {
                    id_parte_video_cuestionario: parseInt(id),
                },
            }
        );

        // Elimnar el registro
        const resultado = await prisma.parte_video_cuestionario.delete({
            where: {
                id_parte_video_cuestionario: parseInt(id),
            },
        });

        // Se obtienen todos los registros con un índice mayor al índice del
        // registro eliminado para poder actualizarlos
        const recordsToUpdate = await prisma.parte_video_cuestionario.findMany({
            where: {
                indice: {
                    // gt = greater than
                    gt: recordToDelete.indice,
                },
            },
        });

        // Actualizar los registros con un índice mayor al índice del registro
        // reduciendo en 1 su índice
        const updatePromises = recordsToUpdate.map((record) =>
            prisma.parte_video_cuestionario.update({
                where: {
                    id_parte_video_cuestionario:
                        record.id_parte_video_cuestionario,
                },
                data: {
                    indice: record.indice - 1,
                },
            })
        );
        await Promise.all(updatePromises);

        res.status(200).json(resultado);
    } catch (err) {
        res.status(500).json({ message: `${err}` });
    }
});

module.exports = router;

/*
INSERT INTO public.parte_video_cuestionario(
	id_nivel, url_video, indice, nombre)
	VALUES (1, 'url', 0, 'nombre');

INSERT INTO public.parte_video_cuestionario(
	id_nivel, url_video, indice, nombre)
	VALUES (1, 'url', 1, 'nombre');
	
INSERT INTO public.parte_video_cuestionario(
	id_nivel, url_video, indice, nombre)
	VALUES (1, 'url', 2, 'nombre');
	
INSERT INTO public.parte_video_cuestionario(
	id_nivel, url_video, indice, nombre)
	VALUES (1, 'url', 3, 'nombre');
*/
