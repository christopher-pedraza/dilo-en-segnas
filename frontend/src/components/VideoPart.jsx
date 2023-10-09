export default function VideoPart() {
  return (
    <>
      <label htmlFor="clipVideo" className="text-2xl font-bold">
        Video
      </label>
      <input
        type="text"
        id="clipVideo"
        name="clipVideo"
        placeholder="Ingresa el URL del video"
        className="w-full rounded-lg border border-slate-400 p-2 my-2"
      />
      <label htmlFor="clipPregunta" className="text-2xl font-bold">
        Pregunta
      </label>
      <input
        type="text"
        id="clipPregunta"
        name="clipPregunta"
        placeholder="Ingresa la pregunta del clip"
        className="w-full rounded-lg border border-slate-400 p-2 my-2"
      />
      <label htmlFor="clipPRespuestas" className="text-2xl font-bold">
        Posibles Respuestas
      </label>
      <input
        type="text"
        id="clipPRespuesta1"
        name="clipPRespuesta1"
        placeholder="Ingresa la posible respuesta 1"
        className="w-full rounded-lg border border-slate-400 p-2 my-2"
      />
      <input
        type="text"
        id="clipPRespuesta2"
        name="clipPRespuesta2"
        placeholder="Ingresa la posible respuesta 2"
        className="w-full rounded-lg border border-slate-400 p-2 my-2"
      />
      <input
        type="text"
        id="clipPRespuesta3"
        name="clipPRespuesta3"
        placeholder="Ingresa la posible respuesta 3"
        className="w-full rounded-lg border border-slate-400 p-2 my-2"
      />
      <input
        type="text"
        id="clipPRespuesta4"
        name="clipPRespuesta4"
        placeholder="Ingresa la posible respuesta 4"
        className="w-full rounded-lg border border-slate-400 p-2 my-2"
      />
      <label htmlFor="clipRespuestaC" className="text-2xl font-bold">
        Respuesta Correcta
        <select
          name="clipRespuestaC"
          id="clipRespuestaC"
          defaultValue="default"
          className="w-full rounded-lg border border-slate-400 p-2 my-2 text-base font-normal inactive"
        >
          <option value="default" disabled>
            --- Selecciona una respuesta correcta ---
          </option>
          <option value="respuestac1">1</option>
          <option value="respuestac2">2</option>
          <option value="respuestac3">3</option>
          <option value="respuestac4">4</option>
        </select>
      </label>
    </>
  );
}
