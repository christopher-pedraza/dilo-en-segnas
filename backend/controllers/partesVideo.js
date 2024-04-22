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
