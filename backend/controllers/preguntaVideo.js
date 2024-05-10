const express = require("express");
const router = express.Router();
router.use(express.json());

const { PrismaClient } = require("@prisma/client");
const e = require("express");
const prisma = new PrismaClient();

router.get("/", async (req, res) => {
    /*
    #swagger.tags = ['Pregunta Video']
    #swagger.description = 'Endpoint para obtener todas las preguntas de video cuestionario.'
    #swagger.responses[200] = {
        description: 'Preguntas de video cuestionario obtenidas correctamente.',
        content: {
            'application/json': {
                schema: {
                    type: 'array',
                    items: {
                        type: 'object',
                        properties: {
                            id_preguntas_video_cuestionario: { type: 'integer' },
                            id_parte_video_cuestionario: { type: 'integer' },
                            pregunta: { type: 'string' },
                            respuestas_video_cuestionario: {
                                type: 'array',
                                items: {
                                    type: 'object',
                                    properties: {
                                        id_respuestas_video_cuestionario: { type: 'integer' },
                                        id_preguntas_video_cuestionario: { type: 'integer' },
                                        respuesta: { type: 'string' },
                                        es_correcta: { type: 'boolean' }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    #swagger.responses[500] = {
        description: 'Error al obtener las preguntas de video cuestionario.',
        content: {
            'application/json': {
                schema: {
                    type: 'object',
                    properties: {
                        error: { type: 'string' }
                    }
                }
            }
        }
    }
    */
    try {
        const preguntas = await prisma.preguntas_video_cuestionario.findMany({
            include: { respuestas_video_cuestionario: true },
        });
        res.json(preguntas);
    } catch (error) {
        res.status(500).json({ error: "No se pudo obtener las preguntas" });
    }
});

router.get("/byParte/:id_parte", async (req, res) => {
    /*
    #swagger.tags = ['Pregunta Video']
    #swagger.description = 'Endpoint para obtener todas las preguntas de video cuestionario de una parte.'
    #swagger.parameters['id_parte'] = { description: 'Id de la parte de video cuestionario.' }
    #swagger.responses[200] = {
        description: 'Preguntas de video cuestionario obtenidas correctamente.',
        content: {
            'application/json': {
                schema: {
                    type: 'array',
                    items: {
                        type: 'object',
                        properties: {
                            id_preguntas_video_cuestionario: { type: 'integer' },
                            pregunta: { type: 'string' },
                            respuestas_video_cuestionario: {
                                type: 'array',
                                items: {
                                    type: 'object',
                                    properties: {
                                        id_respuestas_video_cuestionario: { type: 'integer' },
                                        respuesta: { type: 'string' },
                                        es_correcta: { type: 'boolean' }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    #swagger.responses[500] = {
        description: 'Error al obtener las preguntas de video cuestionario.',
        content: {
            'application/json': {
                schema: {
                    type: 'object',
                    properties: {
                        error: { type: 'string' }
                    }
                }
            }
        }
    }
    */
    const { id_parte } = req.params;
    try {
        const preguntas = await prisma.preguntas_video_cuestionario.findMany({
            where: { id_parte_video_cuestionario: parseInt(id_parte) },
            select: {
                id_preguntas_video_cuestionario: true,
                pregunta: true,
                respuestas_video_cuestionario: {
                    select: {
                        id_respuestas_video_cuestionario: true,
                        respuesta: true,
                        es_correcta: true,
                    },
                },
            },
        });
        res.json(preguntas);
    } catch (error) {
        res.status(500).json({ error: "No se pudo obtener las preguntas" });
    }
});

router.get("/:id", async (req, res) => {
    /*
    #swagger.tags = ['Pregunta Video']
    #swagger.description = 'Endpoint para obtener una pregunta de video cuestionario por id.'
    #swagger.parameters['id'] = { description: 'Id de la pregunta de video cuestionario.' }
    #swagger.responses[200] = {
        description: 'Pregunta de video cuestionario obtenida correctamente.',
        content: {
            'application/json': {
                schema: {
                    type: 'object',
                    properties: {
                        id_preguntas_video_cuestionario: { type: 'integer' },
                        id_parte_video_cuestionario: { type: 'integer' },
                        pregunta: { type: 'string' },
                        respuestas_video_cuestionario: {
                            type: 'array',
                            items: {
                                type: 'object',
                                properties: {
                                    id_respuestas_video_cuestionario: { type: 'integer' },
                                    respuesta: { type: 'string' },
                                    es_correcta: { type: 'boolean' }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    #swagger.responses[404] = {
        description: 'Pregunta de video cuestionario no encontrada.',
        content: {
            'application/json': {
                schema: {
                    type: 'object',
                    properties: {
                        error: { type: 'string' }
                    }
                }
            }
        }
    }
    */
    const { id } = req.params;
    try {
        const pregunta = await prisma.preguntas_video_cuestionario.findUnique({
            where: { id_preguntas_video_cuestionario: parseInt(id) },
            select: {
                id_preguntas_video_cuestionario: true,
                id_parte_video_cuestionario: true,
                pregunta: true,
                respuestas_video_cuestionario: {
                    select: {
                        id_respuestas_video_cuestionario: true,
                        respuesta: true,
                        es_correcta: true,
                    },
                },
            },
        });
        if (pregunta) {
            res.json(pregunta);
        } else {
            res.status(404).json({ error: "Pregunta no encontrada" });
        }
    } catch (error) {
        res.status(500).json({ error: "No se pudo obtener la pregunta" });
    }
});

router.post("/", async (req, res) => {
    /*
    #swagger.tags = ['Pregunta Video']
    #swagger.description = 'Endpoint para crear una nueva pregunta de video cuestionario.'
    #swagger.requestBody = {
        required: true,
        content: {
            'application/json': {
                schema: {
                    type: 'object',
                    properties: {
                        id_parte: { type: 'integer', description: 'Id de la parte de video cuestionario.' },
                        pregunta: { type: 'string', description: 'Texto de la pregunta.' },
                        respuestas: {
                            type: 'array',
                            items: {
                                type: 'object',
                                properties: {
                                    respuesta: { type: 'string', description: 'Texto de la respuesta.' },
                                    es_correcta: { type: 'boolean', description: 'Indica si la respuesta es correcta.' }
                                }
                            },
                            description: 'Array de respuestas.'
                        }
                    }
                }
            }
        }
    }
    #swagger.responses[200] = {
        description: 'Pregunta de video cuestionario creada correctamente.',
        content: {
            'application/json': {
                schema: {
                    type: 'object',
                    properties: {
                        pregunta: {
                            type: 'object',
                            properties: {
                                id_preguntas_video_cuestionario: { type: 'integer' },
                                id_parte_video_cuestionario: { type: 'integer' },
                                pregunta: { type: 'string' }
                            }
                        },
                        respuestas: {
                            type: 'array',
                            items: {
                                type: 'object',
                                properties: {
                                    respuesta: { type: 'string' },
                                    es_correcta: { type: 'boolean' }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    #swagger.responses[500] = {
        description: 'Error al crear la pregunta de video cuestionario.',
        content: {
            'application/json': {
                schema: {
                    type: 'object',
                    properties: {
                        error: { type: 'string' }
                    }
                }
            }
        }
    }
    */
    const { id_parte, pregunta, respuestas } = req.body;
    try {
        const preguntaCreada = await prisma.preguntas_video_cuestionario.create(
            {
                data: {
                    id_parte_video_cuestionario: id_parte,
                    pregunta: pregunta,
                },
            }
        );

        for (let i = 0; i < respuestas.length; i++) {
            const respuesta = respuestas[i];
            await prisma.respuestas_video_cuestionario.create({
                data: {
                    id_preguntas_video_cuestionario:
                        preguntaCreada.id_preguntas_video_cuestionario,
                    respuesta: respuesta.respuesta,
                    es_correcta: respuesta.es_correcta,
                },
            });
        }

        res.json({ pregunta: preguntaCreada, respuestas: respuestas });
    } catch (error) {
        res.status(500).json({ error: "No se pudo crear la pregunta" });
    }
});

module.exports = router;
