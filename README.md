![Swift](https://img.shields.io/badge/swift-F54A2A?style=for-the-badge&logo=swift&logoColor=white)
![NodeJS]( 	https://img.shields.io/badge/Node.js-43853D?style=for-the-badge&logo=node.js&logoColor=white)
![ExpressJS](https://img.shields.io/badge/Express.js-404D59?style=for-the-badge)
![PostgreSQL](  https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
![Prisma](https://img.shields.io/badge/Prisma-3982CE?style=for-the-badge&logo=Prisma&logoColor=white)
![React](https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB)
![Tailwind CSS](https://img.shields.io/badge/Tailwind_CSS-38B2AC?style=for-the-badge&logo=tailwind-css&logoColor=white)


![GitHub contributors](https://img.shields.io/github/contributors/christopher-pedraza/segnaventuras)
![GitHub last commit (by committer)](https://img.shields.io/github/last-commit/christopher-pedraza/segnaventuras)
![](https://badgen.net/github/issues/christopher-pedraza/segnaventuras)
![](https://badgen.net/github/open-issues/christopher-pedraza/segnaventuras)
![](https://badgen.net/github/closed-issues/christopher-pedraza/segnaventuras)

# Señaventuras

## Instrucciones para configurar la base de datos y el API

1. Crea un usuario para que se conecte a la base de datos:
```
CREATE ROLE NOMBRE_USUARIO PASSWORD 'CONTRASEÑA' NOSUPERUSER CREATEDB INHERIT LOGIN;
```
Este usuario no tendrá permisos de superuser, podrá crear bases de datos, heredará permisos básicos y podrá hacer login.

2. En la carpeta de backend/ crea un archivo ```.env``` y coloca la siguiente línea (utiliza el usuario que acabas de crear en el punto previo):
```
PORT = 3000
DATABASE_URL="postgresql://USUARIO:CONTRASEÑA@localhost:PUERTO_BD/NOMBRE_BASE_DATOS?schema=NOMBRE_SCHEMA"
```

3. Abre una terminal/ventana de comandos en la carpeta backend/ y corre el siguiente comando para instalar todas las dependencias necesarias para el API
   - Necesitas tener instalado Node.js para poder correr esto. Si nunca lo has instalado visita: ![Descargas Node.js](https://nodejs.org/es/download) 
```
npm i
```

4. En la misma terminal, corre el siguiente comando para generar las tablas de la base de datos:
```
npx prisma migrate deploy --name 8
```
