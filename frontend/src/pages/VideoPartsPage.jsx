import { useState, useEffect } from "react";
import { Dialog } from "@headlessui/react";
import { useLocation } from "react-router-dom";
import axios from "axios";

import Navbar from "../components/Navbar";
import ItemVideoPart from "../components/ItemVideoPart";

export default function VideoPartsPage() {
  const location = useLocation();
  // Accede a videoData desde location.state si existe
  const videoData = location.state ? location.state.videoData : null;

  // Estados para controlar si el modal esta abierto o cerrado
  let [isOpenCreate, setIsOpenCreate] = useState(false);
  let [isOpenUpdate, setIsOpenUpdate] = useState(false);

  // Estado para controlar el formulario
  const [formData, setFormData] = useState({
    id_video_cuestionario: videoData ? videoData.id_video_cuestionario : "",
    indice: null,
    nombre: "",
    url_video: "",
    preguntas: [],
  });

  // Estado para controlar las partes de video
  const [videoParts, setVideoParts] = useState([]);

  // Estado para controlar el ID de la parte de video a editar
  const [editID, setEditID] = useState();

  // Estado para controlar el refresh de la pagina
  const [refresh, setRefresh] = useState(0);

  // Destructuring del formData
  const { id_video_cuestionario, indice, nombre, url_video, preguntas } =
    formData;

  // Funcion que se ejecuta cada vez que se cambia el valor de un input
  const handleChange = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  // Funcion que se ejecuta cuando se da click en el boton de crear
  const handleCreate = (e) => {
    e.preventDefault();
    if (
      id_video_cuestionario &&
      indice >= 0 &&
      nombre &&
      url_video &&
      preguntas
    ) {
      axios
        .post("http://localhost:3000/video/addParte", formData)
        .then((res) => {
          setVideoParts([...videoParts, res.data]);
          console.log(res.data);
          setFormData({
            id_video_cuestionario: videoData
              ? videoData.id_video_cuestionario
              : "",
            indice: -1,
            nombre: "",
            url_video: "",
            preguntas: [],
          });
        })
        .catch((err) => console.log(err));
    }
    setIsOpenCreate(false);
  };

  // Funcion que obtiene todas las partes de video y las actualiza cada que se cambia el estado refresh
  useEffect(() => {
    axios
      .get(
        `http://localhost:3000/video/getComplete/${formData.id_video_cuestionario}`
      )
      .then((res) => {
        setVideoParts(res.data.parte_video_cuestionario);
      })
      .catch((err) => console.log(err));
  }, [refresh, formData.id_video_cuestionario]);

  return (
    <>
      {/* Dialogo Crear Parte Video */}
      <Dialog open={isOpenCreate} onClose={() => setIsOpenCreate(false)}>
        <Dialog open={isOpenCreate} onClose={() => setIsOpenCreate(false)}>
          {/* The backdrop, rendered as a fixed sibling to the panel container */}
          <div className="fixed inset-0 bg-black/30" aria-hidden="true" />

          {/* Full-screen container to center the panel */}
          <div className="fixed inset-0 grid place-items-center ">
            {/* The actual dialog panel  */}
            <Dialog.Panel className="flex w-full max-w-md flex-col rounded-lg bg-white p-6">
              <form>
                <label htmlFor="nombre" className="text-2xl font-bold">
                  Nombre
                </label>
                <input
                  type="text"
                  id="nombre"
                  name="nombre"
                  placeholder="Ingresa el nombre de la palabra"
                  className="w-full rounded-lg border border-slate-400 p-2 my-2"
                  value={nombre}
                  onChange={handleChange}
                />
                <label htmlFor="indice" className="text-2xl font-bold">
                  Indice
                </label>
                <input
                  type="number"
                  id="indice"
                  name="indice"
                  placeholder="Ingresa el numero de indice"
                  className="w-full rounded-lg border border-slate-400 p-2 my-2"
                  value={indice}
                  onChange={handleChange}
                />
                <label htmlFor="url_video" className="text-2xl font-bold">
                  Video
                </label>
                <input
                  type="text"
                  id="url_video"
                  name="url_video"
                  placeholder="Ingresa el URL del video"
                  className="w-full rounded-lg border border-slate-400 p-2 my-2"
                  value={url_video}
                  onChange={handleChange}
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

                <div className="flex items-center justify-end mt-1">
                  <button
                    className="rounded-lg border border-slate-400 bg-black px-4 py-2 text-white ml-2"
                    onClick={() => {
                      setIsOpenCreate(false);
                    }}
                  >
                    Cancelar
                  </button>
                  <button
                    className="rounded-lg border border-slate-400 px-4 py-2 text-white ml-2"
                    style={{ background: "#8712E0" }}
                    type="submit"
                    onClick={handleCreate}
                  >
                    Crear
                  </button>
                </div>
              </form>
            </Dialog.Panel>
          </div>
        </Dialog>
        ;
      </Dialog>

      <Navbar />

      <div className="max-w-3xl m-auto p-8">
        <div className="flex items-center justify-between">
          {/* Add The video name to video parts () */}
          <h2 className="text-3xl">Partes de Video ({videoData.nombre})</h2>
          <button
            onClick={() => setIsOpenCreate(true)}
            className="p-2 text-white rounded-md"
            style={{ background: "#8712E0" }}
          >
            Crear Parte de Video
          </button>
        </div>
        <div>
          {/* Map que muestra cada parte de video */}
          {videoParts.map((videoPart, index) => (
            <ItemVideoPart
              key={index}
              data={videoPart}
              onEdit={setFormData}
              onSetEditID={setEditID}
              onDelete={setRefresh}
            />
          ))}
        </div>
      </div>
    </>
  );
}
