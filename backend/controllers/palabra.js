const express = require("express");
const router = express.Router();
router.use(express.json());

const { PrismaClient } = require("@prisma/client");
const e = require("express");
const prisma = new PrismaClient();

// Reemplaza -> https://api.npoint.io/013db6c57f27144c9c04
router.get("/:id_nivel", async (req, res) => {
    /*
    #swagger.tags = ['Palabra']
    #swagger.description = 'Endpoint para obtener las palabras de un nivel'
    #swagger.parameters['id_nivel'] = { description: 'Id del nivel', type: 'Integer' }
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
    #swagger.responses[500] = {
        description: 'Error message',
        content: {
            'application/json': {
                schema: {
                    type: 'object',
                    properties: {
                        message: { type: 'string' }
                    }
                }
            }
        }
    }
    */
    try {
        const { id_nivel } = req.params;
        const palabras = await prisma.palabra.findMany({
            where: {
                id_nivel: parseInt(id_nivel),
            },
            select: {
                palabra: true,
                id_video_segna: true,
                url_icono: true,
            },
        });
        res.json(palabras);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
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
    #swagger.responses[500] = {
        description: 'Error message',
        content: {
            'application/json': {
                schema: {
                    type: 'object',
                    properties: {
                        message: { type: 'string' }
                    }
                }
            }
        }
    }
    */
    try {
        const palabras = await prisma.palabra.findMany({
            select: {
                palabra: true,
                id_video_segna: true,
                url_icono: true,
            },
        });
        res.json(palabras);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.post("/", async (req, res) => {
    /*
    #swagger.tags = ['Palabra']
    #swagger.description = 'Endpoint para crear una palabra'
    #swagger.responses[500] = {
        description: 'Error message',
        content: {
            'application/json': {
                schema: {
                    type: 'object',
                    properties: {
                        message: { type: 'string' }
                    }
                }
            }
        }
    }
    */
    try {
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
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.delete("/:id_palabra", async (req, res) => {
    /*
    #swagger.tags = ['Palabra']
    #swagger.description = 'Endpoint para eliminar una palabra'
    #swagger.parameters['id_palabra'] = { description: 'Id de la palabra', type:
    'Integer' }
    #swagger.responses[500] = {
        description: 'Error message',
        content: {
            'application/json': {
                schema: {
                    type: 'object',
                    properties: {
                        message: { type: 'string' }
                    }
                }
            }
        }
    }
    */
    try {
        const { id_palabra } = req.params;
        const palabra = await prisma.palabra.delete({
            where: {
                id_palabra: parseInt(id_palabra),
            },
        });
        res.json(palabra);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

module.exports = router;
