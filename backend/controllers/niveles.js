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

router.post("/", async (req, res) => {
    try {
        const { id_isla } = req.body;
        const resultado = await prisma.nivel.create({
            data: {
                id_isla: id_isla,
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
	id_isla, nombre, modelo_general, modelo_especifico)
	VALUES (1, 'Isla', null, null);

INSERT INTO public.nivel(
	id_nivel, id_isla, nombre)
	VALUES (1, 1, 'Nivel 1');

INSERT INTO public.nivel(
    id_nivel, id_isla, nombre)
    VALUES (2, 1, 'Nivel 2');

INSERT INTO public.nivel(
    id_nivel, id_isla, nombre)
    VALUES (3, 1, 'Nivel 3');

INSERT INTO public.nivel(
    id_nivel, id_isla, nombre)
    VALUES (4, 1, 'Nivel 4');

INSERT INTO public.nivel(
    id_nivel, id_isla, nombre)
    VALUES (5, 1, 'Nivel 5');
*/
