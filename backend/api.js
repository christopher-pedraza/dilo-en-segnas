/*
npm init
npm install express
npm install dotenv
npm install pg
npm install prisma --save-dev
npx prisma init
npm install @prisma/client
*/

const express = require("express");
const dotenv = require("dotenv");
const cors = require("cors");

dotenv.config();

const app = express();

// Habilitar CORS para todas las rutas
app.use(cors());

// Para poder trabajar con JSONS
app.use(express.json());
// Para escribir datos en el body al hacer post o put
app.use(express.urlencoded({ extended: true }));

// Para poder usar todas las rutas
app.use(require("./routes/routes.js"));

// Se inicializa la API en el puerto especificado por el archivo .env
app.listen(process.env.PORT, () => {
  console.log(`Listening on port ${process.env.PORT}`);
});
