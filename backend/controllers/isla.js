// const express = require("express");
// const router = express.Router();
// router.use(express.json());

// const { PrismaClient } = require("@prisma/client");
// const e = require("express");
// const prisma = new PrismaClient();

// router.get("/", async (req, res) => {
//     /*
//     #swagger.tags = ['Isla']
//     #swagger.description = 'Endpoint para obtener todas las islas.'
//     #swagger.responses[200] = {
//         description: 'Islas obtenidas correctamente.',
//         content: {
//             'application/json': {
//                 schema: {
//                     type: 'array',
//                     items: {
//                         type: 'object',
//                         properties: {
//                             id_isla: { type: 'integer' },
//                             nombre: { type: 'string' }
//                         }
//                     }
//                 }
//             }
//         }
//     }
//     #swagger.responses[500] = {
//         description: 'Error al obtener las islas.',
//         content: {
//             'application/json': {
//                 schema: {
//                     type: 'object',
//                     properties: {
//                         error: { type: 'string' }
//                     }
//                 }
//             }
//         }
//     }
//     */
//     try {
//         const resultado = await prisma.isla.findMany();
//         res.status(200).json(resultado);
//     } catch (err) {
//         res.status(500).json({ error: `${err}` });
//     }
// });
