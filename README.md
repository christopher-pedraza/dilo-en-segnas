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

## Instrucciones para configurar la base de datos
**NOTA:** En las próximas instrucciones, los elementos entre ```[]``` son donde introduces los datos que quieras, pero es necesario quitar los ```[]``` y solo dejar el dato.

1. Instala PostgreSQL de: [https://www.postgresql.org/download/](https://www.postgresql.org/download/)

2. Crea un usuario para que se conecte a la base de datos:
```
CREATE ROLE [NOMBRE_USUARIO] PASSWORD '[CONTRASEÑA]' NOSUPERUSER CREATEDB INHERIT LOGIN;
```
Este usuario no tendrá permisos de superuser, podrá crear bases de datos, heredará permisos básicos y podrá hacer login.

3. Crea una Base de Datos con el rol recien creado como dueño. Lo puedes hacer desde pgAdmin4 con el QueryTool o con una terminal/linea de comandos:
    - Terminal/linea de comandos:
        ```
        CREATE DATABASE segnaventura OWNER [ROL];
        ```
    - QueryTool en pgAdmin4:
      ![Instrucciones para crear base de datos en pgAdmin4](https://github.com/christopher-pedraza/segnaventuras/assets/62347713/99eaaf08-3bdc-47b9-b7f5-7d1896403c36)


## Instrucciones para configurar la API

1. En la carpeta de backend/ crea un archivo ```.env``` y coloca las siguientes líneas (utiliza el usuario que acabas de crear):
```
PORT = 3000
DATABASE_URL="postgresql://[USUARIO]:[CONTRASEÑA]@localhost:[PUERTO_BD]/[NOMBRE_BASE_DATOS]?schema=[NOMBRE_SCHEMA]"
```

2. Abre una terminal/ventana de comandos en la carpeta backend/ y corre el siguiente comando para instalar todas las dependencias necesarias para el API
   - Necesitas tener instalado Node.js para poder correr esto. Si nunca lo has instalado visita: [https://nodejs.org/es/download](https://nodejs.org/es/download) 
```
npm i
```

3. En la misma terminal, corre el siguiente comando para generar las tablas de la base de datos:
```
npx prisma migrate reset
```

4. Corre el API desde la carpeta backend/ corriendo el comando:
```
npm run start
```
