-- CreateTable
CREATE TABLE "miembro" (
    "id_miembro" SERIAL NOT NULL,
    "usuario" TEXT NOT NULL,
    "contrasegna" TEXT NOT NULL,
    "es_administrador" BOOLEAN NOT NULL,

    CONSTRAINT "miembro_pkey" PRIMARY KEY ("id_miembro")
);

-- CreateTable
CREATE TABLE "isla" (
    "id_isla" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "modelo_general" BYTEA,
    "modelo_especifico" BYTEA,

    CONSTRAINT "isla_pkey" PRIMARY KEY ("id_isla")
);

-- CreateTable
CREATE TABLE "video_cuestionario" (
    "id_video_cuestionario" SERIAL NOT NULL,
    "id_isla" INTEGER NOT NULL,

    CONSTRAINT "video_cuestionario_pkey" PRIMARY KEY ("id_video_cuestionario")
);

-- CreateTable
CREATE TABLE "quiz" (
    "id_quiz" SERIAL NOT NULL,
    "id_isla" INTEGER NOT NULL,
    "nombre" TEXT NOT NULL,

    CONSTRAINT "quiz_pkey" PRIMARY KEY ("id_quiz")
);

-- CreateTable
CREATE TABLE "modelo_coml" (
    "id_modelo_coml" SERIAL NOT NULL,
    "id_isla" INTEGER NOT NULL,

    CONSTRAINT "modelo_coml_pkey" PRIMARY KEY ("id_modelo_coml")
);

-- CreateTable
CREATE TABLE "treasure_hunt" (
    "id_treasure_hunt" SERIAL NOT NULL,
    "id_isla" INTEGER NOT NULL,
    "id_modelo_coml" INTEGER NOT NULL,

    CONSTRAINT "treasure_hunt_pkey" PRIMARY KEY ("id_treasure_hunt")
);

-- CreateTable
CREATE TABLE "nivel" (
    "id_nivel" SERIAL NOT NULL,
    "id_isla" INTEGER NOT NULL,
    "id_video_cuestionario" INTEGER NOT NULL,
    "id_quiz" INTEGER NOT NULL,
    "id_treasure_hunt" INTEGER NOT NULL,

    CONSTRAINT "nivel_pkey" PRIMARY KEY ("id_nivel")
);

-- CreateTable
CREATE TABLE "palabra" (
    "id_palabra" SERIAL NOT NULL,
    "id_isla" INTEGER NOT NULL,
    "palabra" TEXT NOT NULL,
    "id_video_segna" TEXT NOT NULL,
    "url_icono" TEXT NOT NULL,

    CONSTRAINT "palabra_pkey" PRIMARY KEY ("id_palabra")
);

-- CreateTable
CREATE TABLE "parte_video_cuestionario" (
    "id_parte_video_cuestionario" SERIAL NOT NULL,
    "id_video_cuestionario" INTEGER NOT NULL,
    "url_video" TEXT NOT NULL,
    "indice" INTEGER NOT NULL,

    CONSTRAINT "parte_video_cuestionario_pkey" PRIMARY KEY ("id_parte_video_cuestionario")
);

-- CreateTable
CREATE TABLE "palabras_video_cuestionario" (
    "id_video_cuestionario" INTEGER NOT NULL,
    "id_palabra" INTEGER NOT NULL,

    CONSTRAINT "palabras_video_cuestionario_pkey" PRIMARY KEY ("id_video_cuestionario","id_palabra")
);

-- CreateTable
CREATE TABLE "preguntas_video_cuestionario" (
    "id_preguntas_video_cuestionario" SERIAL NOT NULL,
    "id_parte_video_cuestionario" INTEGER NOT NULL,
    "pregunta" TEXT NOT NULL,

    CONSTRAINT "preguntas_video_cuestionario_pkey" PRIMARY KEY ("id_preguntas_video_cuestionario")
);

-- CreateTable
CREATE TABLE "respuestas_video_cuestionario" (
    "id_respuestas_video_cuestionario" SERIAL NOT NULL,
    "id_preguntas_video_cuestionario" INTEGER NOT NULL,
    "respuesta" TEXT NOT NULL,
    "es_correcta" BOOLEAN NOT NULL,

    CONSTRAINT "respuestas_video_cuestionario_pkey" PRIMARY KEY ("id_respuestas_video_cuestionario")
);

-- CreateTable
CREATE TABLE "detalles_quiz" (
    "id_quiz" INTEGER NOT NULL,
    "id_palabra" INTEGER NOT NULL,

    CONSTRAINT "detalles_quiz_pkey" PRIMARY KEY ("id_quiz","id_palabra")
);

-- AddForeignKey
ALTER TABLE "video_cuestionario" ADD CONSTRAINT "video_cuestionario_id_isla_fkey" FOREIGN KEY ("id_isla") REFERENCES "isla"("id_isla") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "quiz" ADD CONSTRAINT "quiz_id_isla_fkey" FOREIGN KEY ("id_isla") REFERENCES "isla"("id_isla") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "modelo_coml" ADD CONSTRAINT "modelo_coml_id_isla_fkey" FOREIGN KEY ("id_isla") REFERENCES "isla"("id_isla") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "treasure_hunt" ADD CONSTRAINT "treasure_hunt_id_isla_fkey" FOREIGN KEY ("id_isla") REFERENCES "isla"("id_isla") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "treasure_hunt" ADD CONSTRAINT "treasure_hunt_id_modelo_coml_fkey" FOREIGN KEY ("id_modelo_coml") REFERENCES "modelo_coml"("id_modelo_coml") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "nivel" ADD CONSTRAINT "nivel_id_isla_fkey" FOREIGN KEY ("id_isla") REFERENCES "isla"("id_isla") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "nivel" ADD CONSTRAINT "nivel_id_video_cuestionario_fkey" FOREIGN KEY ("id_video_cuestionario") REFERENCES "video_cuestionario"("id_video_cuestionario") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "nivel" ADD CONSTRAINT "nivel_id_quiz_fkey" FOREIGN KEY ("id_quiz") REFERENCES "quiz"("id_quiz") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "nivel" ADD CONSTRAINT "nivel_id_treasure_hunt_fkey" FOREIGN KEY ("id_treasure_hunt") REFERENCES "treasure_hunt"("id_treasure_hunt") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "palabra" ADD CONSTRAINT "palabra_id_isla_fkey" FOREIGN KEY ("id_isla") REFERENCES "isla"("id_isla") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "parte_video_cuestionario" ADD CONSTRAINT "parte_video_cuestionario_id_video_cuestionario_fkey" FOREIGN KEY ("id_video_cuestionario") REFERENCES "video_cuestionario"("id_video_cuestionario") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "palabras_video_cuestionario" ADD CONSTRAINT "palabras_video_cuestionario_id_video_cuestionario_fkey" FOREIGN KEY ("id_video_cuestionario") REFERENCES "video_cuestionario"("id_video_cuestionario") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "palabras_video_cuestionario" ADD CONSTRAINT "palabras_video_cuestionario_id_palabra_fkey" FOREIGN KEY ("id_palabra") REFERENCES "palabra"("id_palabra") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "preguntas_video_cuestionario" ADD CONSTRAINT "preguntas_video_cuestionario_id_parte_video_cuestionario_fkey" FOREIGN KEY ("id_parte_video_cuestionario") REFERENCES "parte_video_cuestionario"("id_parte_video_cuestionario") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "respuestas_video_cuestionario" ADD CONSTRAINT "respuestas_video_cuestionario_id_preguntas_video_cuestiona_fkey" FOREIGN KEY ("id_preguntas_video_cuestionario") REFERENCES "preguntas_video_cuestionario"("id_preguntas_video_cuestionario") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "detalles_quiz" ADD CONSTRAINT "detalles_quiz_id_quiz_fkey" FOREIGN KEY ("id_quiz") REFERENCES "quiz"("id_quiz") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "detalles_quiz" ADD CONSTRAINT "detalles_quiz_id_palabra_fkey" FOREIGN KEY ("id_palabra") REFERENCES "palabra"("id_palabra") ON DELETE NO ACTION ON UPDATE NO ACTION;