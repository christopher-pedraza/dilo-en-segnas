const express = require("express");
const router = express.Router();
router.use(express.json());

const { PrismaClient } = require("@prisma/client");
const e = require("express");
const prisma = new PrismaClient();

router.get("/", async (req, res) => {
    /*
    #swagger.tags = ['Nivel']
    #swagger.description = 'Endpoint para obtener todos los niveles.'
    #swagger.responses[200] = {
        description: 'Niveles obtenidos correctamente.',
        content: {
            'application/json': {
                schema: {
                    type: 'array',
                    items: {
                        type: 'object',
                        properties: {
                            id_nivel: { type: 'integer' },
                            id_isla: { type: 'integer' },
                            nombre: { type: 'string' }
                        }
                    }
                }
            }
        }
    }
    #swagger.responses[500] = {
        description: 'Error al obtener los niveles.',
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
        const resultado = await prisma.nivel.findMany();
        res.status(200).json(resultado);
    } catch (err) {
        res.status(500).json({ error: `${err}` });
    }
});

router.get("/getByIsla/:id", async (req, res) => {
    /*
    #swagger.tags = ['Nivel']
    #swagger.description = 'Endpoint para obtener los niveles por id de isla.'
    #swagger.parameters['id'] = {
        in: 'path',
        description: 'ID de la isla.',
        required: true,
        type: 'integer'
    }
    #swagger.responses[200] = {
        description: 'Niveles obtenidos correctamente.',
        content: {
            'application/json': {
                schema: {
                    type: 'array',
                    items: {
                        type: 'object',
                        properties: {
                            id_nivel: { type: 'integer' },
                            id_isla: { type: 'integer' },
                            nombre: { type: 'string' }
                        }
                    }
                }
            }
        }
    }
    #swagger.responses[500] = {
        description: 'Error al obtener los niveles.',
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
        const { id } = req.params;
        const resultado = await prisma.nivel.findMany({
            where: {
                id_isla: parseInt(id),
            },
        });
        res.status(200).json(resultado);
    } catch (err) {
        res.status(500).json({ error: `${err}` });
    }
});

router.get("/videoCuestionario/:id_nivel", async (req, res) => {
    /*
    #swagger.tags = ['Nivel']
    #swagger.description = 'Endpoint para obtener el video del cuestionario de un nivel.'
    #swagger.parameters['id_nivel'] = {
        in: 'path',
        description: 'ID del nivel.',
        required: true,
        type: 'integer'
    }
    #swagger.responses[200] = {
        description: 'Video del cuestionario obtenido correctamente.',
        content: {
            'application/json': {
                schema: {
                    type: 'object',
                    properties: {
                        url_video_cuestionario: { type: 'string' }
                    }
                }
            }
        }
    }
    #swagger.responses[500] = {
        description: 'Error al obtener el video del cuestionario.',
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
        const { id_nivel } = req.params;
        const partes = await prisma.parte_video_cuestionario.findMany({
            where: {
                id_nivel: parseInt(id_nivel),
            },
            select: {
                _count: true,
                nombre: true,
                url_video: true,
                indice: true,
                preguntas_video_cuestionario: {
                    select: {
                        _count: true,
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
            orderBy: {
                indice: "asc",
            },
        });

        const cantidadPartes = partes.length;

        const resultado = {
            _count: {
                parte_video_cuestionario: cantidadPartes,
            },
            parte_video_cuestionario: partes,
        };

        res.status(200).json(resultado);
    } catch (err) {
        res.status(500).json({ error: `${err}` });
    }
});

router.post("/", async (req, res) => {
    /*
    #swagger.tags = ['Nivel']
    #swagger.description = 'Endpoint para crear un nuevo nivel.'
    #swagger.requestBody = {
        content: {
            'application/json': {
                schema: {
                    type: 'object',
                    properties: {
                        id_isla: { type: 'integer' },
                        nombre: { type: 'string' },
                    },
                    required: ['id_isla']
                }
            }
        }
    }
    #swagger.responses[200] = {
        description: 'Nivel creado correctamente.',
        content: {
            'application/json': {
                schema: {
                    type: 'object',
                    properties: {
                        id_nivel: { type: 'integer' },
                        id_isla: { type: 'integer' },
                        nombre: { type: 'string' }
                    }
                }
            }
        }
    }
    #swagger.responses[500] = {
        description: 'Error al crear el nivel.',
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
        const { id_isla, nombre } = req.body;
        const resultado = await prisma.nivel.create({
            data: {
                id_isla: id_isla,
                nombre: nombre,
            },
        });
        res.status(200).json(resultado);
    } catch (err) {
        res.status(500).json({ error: `${err}` });
    }
});

router.put("/:id_nivel", async (req, res) => {
    /*
    #swagger.tags = ['Nivel']
    #swagger.description = 'Endpoint para actualizar un nivel.'
    #swagger.parameters['id_nivel'] = {
        in: 'path',
        description: 'ID del nivel a actualizar.',
        required: true,
        type: 'integer'
    }
    #swagger.requestBody = {
        content: {
            'application/json': {
                schema: {
                    type: 'object',
                    properties: {
                        id_isla: { type: 'integer' },
                        nombre: { type: 'string' },
                    },
                    required: ['id_isla', 'nombre']
                }
            }
        }
    }
    #swagger.responses[200] = {
        description: 'Nivel actualizado correctamente.',
        content: {
            'application/json': {
                schema: {
                    type: 'object',
                    properties: {
                        id_nivel: { type: 'integer' },
                        id_isla: { type: 'integer' },
                        nombre: { type: 'string' }
                    }
                }
            }
        }
    }
    #swagger.responses[500] = {
        description: 'Error al actualizar el nivel.',
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
        const { id_nivel } = req.params;
        const { id_isla, nombre } = req.body;
        const resultado = await prisma.nivel.update({
            where: { id_nivel: parseInt(id_nivel) },
            data: {
                id_isla: id_isla,
                nombre: nombre,
            },
        });
        res.status(200).json(resultado);
    } catch (err) {
        res.status(500).json({ error: `${err}` });
    }
});

router.delete("/:id_nivel", async (req, res) => {
    /*
    #swagger.tags = ['Nivel']
    #swagger.description = 'Endpoint para eliminar un nivel.'
    #swagger.parameters['id_nivel'] = {
        in: 'path',
        description: 'ID del nivel a eliminar.',
        required: true,
        type: 'integer'
    }
    #swagger.responses[200] = {
        description: 'Nivel eliminado correctamente.',
        content: {
            'application/json': {
                schema: {
                    type: 'object',
                    properties: {
                        id_nivel: { type: 'integer' },
                        id_isla: { type: 'integer' },
                        nombre: { type: 'string' }
                    }
                }
            }
        }
    }
    #swagger.responses[500] = {
        description: 'Error al eliminar el nivel.',
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
        const { id_nivel } = req.params;
        const resultado = await prisma.nivel.delete({
            where: { id_nivel: parseInt(id_nivel) },
        });
        res.status(200).json(resultado);
    } catch (err) {
        res.status(500).json({ error: `${err}` });
    }
});

module.exports = router;

/*
INSERT INTO public.isla(
	nombre, modelo_general, modelo_especifico)
	VALUES ('Isla', null, null);

INSERT INTO public.nivel(
	id_isla, nombre)
	VALUES (1, 'Nivel 1');

INSERT INTO public.nivel(
    id_isla, nombre)
    VALUES (1, 'Nivel 2');

INSERT INTO public.nivel(
    id_isla, nombre)
    VALUES (1, 'Nivel 3');

INSERT INTO public.nivel(
    id_isla, nombre)
    VALUES (1, 'Nivel 4');

INSERT INTO public.nivel(
    id_isla, nombre)
    VALUES (1, 'Nivel 5');
*/
