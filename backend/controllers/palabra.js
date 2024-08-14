const express = require("express");
const router = express.Router();
router.use(express.json());

const { PrismaClient } = require("@prisma/client");
const e = require("express");
const prisma = new PrismaClient();

router.get("/:id_nivel", async (req, res) => {
    /*
    #swagger.tags = ['Palabra']
    #swagger.description = 'Endpoint para obtener las palabras de un nivel'
    #swagger.parameters['id_nivel'] = { description: 'Id del nivel', type:
    'Integer' }
    */
    const { id_nivel } = req.params;
    const palabras = await prisma.palabra.findMany({
        where: {
            id_nivel: parseInt(id_nivel),
        },
    });
    res.json(palabras);
});

router.get("/", async (req, res) => {
    /*
    #swagger.tags = ['Palabra']
    #swagger.description = 'Endpoint para obtener todas las palabras'
    #swagger.responses[200] = {
        description: 'Palabras encontradas',
        content: {
            "application/json": {
                schema: {
                    type: 'array',
                    items: {
                        type: 'object',
                        properties: {
                            palabra: { type: 'string' },
                            id_video_segna: { type: 'string' },
                            url_icono: { type: 'string' }
                        }
                    }
                }
            }
        }
    }
    */
    const palabras = await prisma.palabra.findMany({
        select: {
            palabra: true,
            id_video_segna: true,
            url_icono: true,
        },
    });
    res.json(palabras);
});

router.post("/", async (req, res) => {
    /*
    #swagger.tags = ['Palabra']
    #swagger.description = 'Endpoint para crear una palabra'
    */
    const { palabra, id_video_segna, id_nivel, url_icono } = req.body;
    const response = await prisma.palabra.create({
        data: {
            palabra,
            id_video_segna,
            id_nivel,
            url_icono,
        },
    });
    res.json(response);
});

router.delete("/:id_palabra", async (req, res) => {
    /*
    #swagger.tags = ['Palabra']
    #swagger.description = 'Endpoint para eliminar una palabra'
    #swagger.parameters['id_palabra'] = { description: 'Id de la palabra', type:
    'Integer' }
    */
    const { id_palabra } = req.params;
    const palabra = await prisma.palabra.delete({
        where: {
            id_palabra: parseInt(id_palabra),
        },
    });
    res.json(palabra);
});

module.exports = router;
