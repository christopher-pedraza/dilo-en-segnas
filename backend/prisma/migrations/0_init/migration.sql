CREATE TABLE "miembro" (
    "id_miembro" SERIAL NOT NULL,
    "usuario" TEXT NOT NULL,
    "contrasegna" TEXT NOT NULL,
    "es_administrador" BOOLEAN NOT NULL,

    CONSTRAINT "miembro_pkey" PRIMARY KEY ("id_miembro")
);

CREATE TABLE "isla" (
    "id_isla" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "modelo_general" BYTEA,
    "modelo_especifico" BYTEA,

    CONSTRAINT "isla_pkey" PRIMARY KEY ("id_isla")
);

CREATE TABLE "video_cuestionario" (
    "id_video_cuestionario" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,

    "id_isla" INTEGER NOT NULL REFERENCES "isla"("id_isla") ON DELETE NO ACTION ON UPDATE NO ACTION,

    CONSTRAINT "video_cuestionario_pkey" PRIMARY KEY ("id_video_cuestionario")
);

CREATE TABLE "quiz" (
    "id_quiz" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,

    "id_isla" INTEGER NOT NULL REFERENCES "isla"("id_isla") ON DELETE NO ACTION ON UPDATE NO ACTION,

    CONSTRAINT "quiz_pkey" PRIMARY KEY ("id_quiz")
);

CREATE TABLE "modelo_coml" (
    "id_modelo_coml" SERIAL NOT NULL,

    "id_isla" INTEGER NOT NULL REFERENCES "isla"("id_isla") ON DELETE NO ACTION ON UPDATE NO ACTION,

    CONSTRAINT "modelo_coml_pkey" PRIMARY KEY ("id_modelo_coml")
);

CREATE TABLE "treasure_hunt" (
    "id_treasure_hunt" SERIAL NOT NULL,

    "id_isla" INTEGER NOT NULL REFERENCES "isla"("id_isla") ON DELETE NO ACTION ON UPDATE NO ACTION,
    "id_modelo_coml" INTEGER NOT NULL REFERENCES "modelo_coml"("id_modelo_coml") ON DELETE NO ACTION ON UPDATE NO ACTION,

    CONSTRAINT "treasure_hunt_pkey" PRIMARY KEY ("id_treasure_hunt")
);

CREATE TABLE "nivel" (
    "id_nivel" SERIAL NOT NULL,

    "id_isla" INTEGER REFERENCES "isla"("id_isla") ON DELETE NO ACTION ON UPDATE NO ACTION,
    "id_video_cuestionario" INTEGER REFERENCES "video_cuestionario"("id_video_cuestionario") ON DELETE NO ACTION ON UPDATE NO ACTION,
    "id_quiz" INTEGER REFERENCES "quiz"("id_quiz") ON DELETE NO ACTION ON UPDATE NO ACTION,
    "id_treasure_hunt" INTEGER REFERENCES "treasure_hunt"("id_treasure_hunt") ON DELETE NO ACTION ON UPDATE NO ACTION,

    CONSTRAINT "nivel_pkey" PRIMARY KEY ("id_nivel")
);

CREATE TABLE "progreso_islas" (
    "id_miembro" INTEGER NOT NULL REFERENCES "miembro"("id_miembro") ON DELETE NO ACTION ON UPDATE NO ACTION,
    "id_isla" INTEGER NOT NULL REFERENCES "isla"("id_isla") ON DELETE NO ACTION ON UPDATE NO ACTION,

    CONSTRAINT "progreso_islas_pkey" PRIMARY KEY ("id_miembro","id_isla")
);

CREATE TABLE "progreso_nivel" (
    "completada_treasure_hunt" BOOLEAN,
    "completada_videos_cuestionario" BOOLEAN,
    "completada_quiz" BOOLEAN,

    "id_miembro" INTEGER NOT NULL REFERENCES "miembro"("id_miembro") ON DELETE NO ACTION ON UPDATE NO ACTION,
    "id_nivel" INTEGER NOT NULL REFERENCES "nivel"("id_nivel") ON DELETE NO ACTION ON UPDATE NO ACTION,

    CONSTRAINT "progreso_nivel_pkey" PRIMARY KEY ("id_miembro","id_nivel")
);

CREATE TABLE "palabra" (
    "id_palabra" SERIAL NOT NULL,
    "palabra" TEXT NOT NULL,
    "id_video_segna" TEXT NOT NULL,
    "url_icono" TEXT NOT NULL,
    "escaneable" BOOLEAN NOT NULL,

    "id_isla" INTEGER NOT NULL REFERENCES "isla"("id_isla") ON DELETE NO ACTION ON UPDATE NO ACTION,

    CONSTRAINT "palabra_pkey" PRIMARY KEY ("id_palabra")
);

CREATE TABLE "parte_video_cuestionario" (
    "id_parte_video_cuestionario" SERIAL NOT NULL,
    "url_video" TEXT NOT NULL,
    "indice" INTEGER NOT NULL,
    "nombre" TEXT NOT NULL,
    
    "id_video_cuestionario" INTEGER NOT NULL REFERENCES "video_cuestionario"("id_video_cuestionario") ON DELETE CASCADE ON UPDATE NO ACTION,

    CONSTRAINT "parte_video_cuestionario_pkey" PRIMARY KEY ("id_parte_video_cuestionario")
);

CREATE TABLE "palabras_video_cuestionario" (
    "id_video_cuestionario" INTEGER NOT NULL REFERENCES "video_cuestionario"("id_video_cuestionario") ON DELETE CASCADE ON UPDATE NO ACTION,
    "id_palabra" INTEGER NOT NULL REFERENCES "palabra"("id_palabra") ON DELETE CASCADE ON UPDATE NO ACTION,

    CONSTRAINT "palabras_video_cuestionario_pkey" PRIMARY KEY ("id_video_cuestionario","id_palabra")
);

CREATE TABLE "preguntas_video_cuestionario" (
    "id_preguntas_video_cuestionario" SERIAL NOT NULL,
    "pregunta" TEXT NOT NULL,

    "id_parte_video_cuestionario" INTEGER NOT NULL REFERENCES "parte_video_cuestionario"("id_parte_video_cuestionario") ON DELETE CASCADE ON UPDATE NO ACTION,

    CONSTRAINT "preguntas_video_cuestionario_pkey" PRIMARY KEY ("id_preguntas_video_cuestionario")
);

CREATE TABLE "respuestas_video_cuestionario" (
    "id_respuestas_video_cuestionario" SERIAL NOT NULL,
    "respuesta" TEXT NOT NULL,
    "es_correcta" BOOLEAN NOT NULL,

    "id_preguntas_video_cuestionario" INTEGER NOT NULL REFERENCES "preguntas_video_cuestionario"("id_preguntas_video_cuestionario") ON DELETE CASCADE ON UPDATE NO ACTION,

    CONSTRAINT "respuestas_video_cuestionario_pkey" PRIMARY KEY ("id_respuestas_video_cuestionario")
);

CREATE TABLE "detalles_quiz" (
    "id_quiz" INTEGER NOT NULL REFERENCES "quiz"("id_quiz") ON DELETE CASCADE ON UPDATE NO ACTION,
    "id_palabra" INTEGER NOT NULL REFERENCES "palabra"("id_palabra") ON DELETE CASCADE ON UPDATE NO ACTION,
    
    CONSTRAINT "detalles_quiz_pkey" PRIMARY KEY ("id_quiz","id_palabra")
);