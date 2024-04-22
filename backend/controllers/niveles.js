const express = require("express");
const router = express.Router();
router.use(express.json());

const { PrismaClient } = require("@prisma/client");
const e = require("express");
const prisma = new PrismaClient();

router.get("/", async (req, res) => {
    try {
        const resultado = await prisma.nivel.findMany();
        res.status(200).json(resultado);
    } catch (err) {
        res.status(500).json({ message: `${err}` });
    }
});

router.get("/getByIsla/:id", async (req, res) => {
    try {
        const { id } = req.params;
        const resultado = await prisma.nivel.findMany({
            where: {
                id_isla: parseInt(id),
            },
        });
        res.status(200).json(resultado);
    } catch (err) {
        res.status(500).json({ message: `${err}` });
    }
});

module.exports = router;

/*
INSERT INTO public.isla(
	nombre, modelo_general, modelo_especifico)
	VALUES ('Isla', null, null);
	
INSERT INTO public.video_cuestionario(
	nombre)
	VALUES ('Video1');

INSERT INTO public.nivel(
	id_isla, id_video_cuestionario)
	VALUES (1, 1);
*/
