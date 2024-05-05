const express = require("express");
const router = express.Router();
router.use(express.json());

const { PrismaClient } = require("@prisma/client");
const e = require("express");
const prisma = new PrismaClient();

const sha512 = require("js-sha512");

const jwt = require("jsonwebtoken");
const TOKEN_SECRET = process.env.TOKEN_SECRET;

router.post("/login", async (req, res) => {
    console.log(req.body);
    const { usuario, contrasegna } = req.body;
    try {
        const resultado = await prisma.miembro.findMany({
            where: {
                AND: {
                    usuario: usuario.toLowerCase(),
                    contrasegna: sha512(contrasegna),
                    es_administrador: { equals: true },
                },
            },
        });

        console.log(resultado.length);

        if (resultado.length != 0) {
            console.log(TOKEN_SECRET);
            const token = jwt.sign(
                { usuario: usuario.toLowerCase() },
                TOKEN_SECRET,
                {
                    expiresIn: "1d",
                }
            );
            console.log("Token: ", token);
            res.status(200).json({ autenticado: true, token: token });
        } else {
            res.status(403).json({ autenticado: false, token: "" });
        }
    } catch (err) {
        res.status(500).json({
            autenticado: false,
            token: "",
            message: `${err}`,
        });
    }
});

router.post("/registro", async (req, res) => {
    const { usuario, contrasegna, es_administrador } = req.body;
    try {
        const resultado = await prisma.miembro.create({
            data: {
                usuario: usuario.toLowerCase(),
                contrasegna: sha512(contrasegna),
                es_administrador: es_administrador,
            },
        });
        res.status(200).json(resultado);
    } catch (err) {
        res.status(500).json({ message: `${err}` });
    }
});

router.post("/authToken", async (req, res) => {
    const { token } = req.body;

    try {
        var decoded = jwt.verify(token, TOKEN_SECRET);
        res.status(200).json({ autenticado: true, usuario: decoded.usuario });
    } catch (err) {
        res.status(403).json({ autenticado: false, usuario: "" });
    }
});

module.exports = router;
