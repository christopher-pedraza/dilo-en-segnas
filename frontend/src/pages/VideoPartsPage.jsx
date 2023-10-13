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
    indice: -1,
    nombre: "",
    url_video: "",
    pregunta: "",
    respuesta1: "",
    respuesta2: "",
    respuesta3: "",
    respuesta4: "",
    respuestaC: 0,
  });

  // Estado para controlar las partes de video
  const [videoParts, setVideoParts] = useState([]);

  // Estado para controlar el ID de la parte de video a editar
  const [editID, setEditID] = useState();

  // Estado para controlar el refresh de la pagina
  const [refresh, setRefresh] = useState(0);

  // Destructuring del formData
  const {
    id_video_cuestionario,
    indice,
    nombre,
    url_video,
    pregunta,
    respuesta1,
    respuesta2,
    respuesta3,
    respuesta4,
    respuestaC,
  } = formData;

  // Funcion que se ejecuta cada vez que se cambia el valor de un input
  const handleChange = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  // Funcion que se ejecuta cuando se da click en el boton de crear
  const handleCreate = (e) => {
    e.preventDefault();
    axios
      .post("http://localhost:3000/videos/addParteSimplified", {
        id_video_cuestionario: parseInt(id_video_cuestionario),
        indice: parseInt(indice),
        nombre: nombre,
        url_video: url_video,
        pregunta: pregunta,
        respuesta1: respuesta1,
        respuesta2: respuesta2,
        respuesta3: respuesta3,
        respuesta4: respuesta4,
        respuestaC: parseInt(respuestaC),
      })
      .then((res) => {
        console.log(res);
        setFormData({
          id_video_cuestionario: videoData
            ? videoData.id_video_cuestionario
            : "",
          indice: -1,
          nombre: "",
          url_video: "",
          pregunta: "",
          respuesta1: "",
          respuesta2: "",
          respuesta3: "",
          respuesta4: "",
          respuestaC: 0,
        });
        setRefresh(refresh + 1);
      })
      .catch((err) => console.log(err));
    setIsOpenCreate(false);
  };

  // Funcion que se ejecuta cuando se da click en el boton de actualizar
  const handleUpdate = () => {
    axios
      .put(`http://localhost:3000/videos/updateParteSimplified/${editID}`, {
        id_video_cuestionario: parseInt(id_video_cuestionario),
        indice: parseInt(indice),
        nombre: nombre,
        url_video: url_video,
        pregunta: pregunta,
        respuesta1: respuesta1,
        respuesta2: respuesta2,
        respuesta3: respuesta3,
        respuesta4: respuesta4,
        respuestaC: parseInt(respuestaC),
      })
      .then((res) => {
        console.log(res);
        setFormData({
          id_video_cuestionario: videoData
            ? videoData.id_video_cuestionario
            : "",
          indice: -1,
          nombre: "",
          url_video: "",
          pregunta: "",
          respuesta1: "",
          respuesta2: "",
          respuesta3: "",
          respuesta4: "",
          respuestaC: 0,
        });
        setRefresh(refresh + 1);
      })
      .catch((err) => console.log(err));
    setIsOpenUpdate(false);
  };

  // Funcion que se ejecuta cuando se da click en el boton de eliminar
  const handleDelete = (deleteID) => {
    axios
      .delete(`http://localhost:3000/videos/removeParte/${deleteID}`)
      .then((res) => {
        console.log("DELETD RECORD::::", res);
        setRefresh(refresh + 1);
      })
      .catch((err) => console.log(err));
  };

  // Funcion que se ejecuta cuando se da click en el boton de editar
  const handleEdit = (editIDNotState) => {
    setIsOpenUpdate(true);
    axios
      .get(`http://localhost:3000/quiz/getParteSimplified/${editIDNotState}`)
      .then((res) => {
        setFormData(res.data);
        setEditID(editIDNotState);
      })
      .catch((err) => console.log(err));
  };

  // Funcion que obtiene todas las partes de video y las actualiza cada que se cambia el estado refresh
  useEffect(() => {
    axios
      .get(
        `http://localhost:3000/videos/getPartes/${formData.id_video_cuestionario}`
      )
      .then((res) => {
        setVideoParts(res.data);
        console.log(res.data);
      })
      .catch((err) => console.log(err));
  }, [refresh, formData.id_video_cuestionario]);

  // Efecto para reiniciar las palabras cuando cambia la categoría
  useEffect(() => {
    setFormData({
      ...formData,
      id_video_cuestionario: videoData ? videoData.id_video_cuestionario : "",
      indice: -1,
      nombre: "",
      url_video: "",
      pregunta: "",
      respuesta1: "",
      respuesta2: "",
      respuesta3: "",
      respuesta4: "",
      respuestaC: 0,
    });
  }, [formData.id_video_cuestionario]);

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
                  value={indice == -1 ? "" : indice}
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
                <label htmlFor="pregunta" className="text-2xl font-bold">
                  Pregunta
                </label>
                <input
                  type="text"
                  id="pregunta"
                  name="pregunta"
                  placeholder="Ingresa la pregunta del clip"
                  className="w-full rounded-lg border border-slate-400 p-2 my-2"
                  value={pregunta}
                  onChange={handleChange}
                />
                <label htmlFor="respuestas" className="text-2xl font-bold">
                  Posibles Respuestas
                </label>
                <input
                  type="text"
                  id="respuesta1"
                  name="respuesta1"
                  placeholder="Ingresa la posible respuesta 1"
                  className="w-full rounded-lg border border-slate-400 p-2 my-2"
                  value={respuesta1}
                  onChange={handleChange}
                />
                <input
                  type="text"
                  id="respuesta2"
                  name="respuesta2"
                  placeholder="Ingresa la posible respuesta 2"
                  className="w-full rounded-lg border border-slate-400 p-2 my-2"
                  value={respuesta2}
                  onChange={handleChange}
                />
                <input
                  type="text"
                  id="respuesta3"
                  name="respuesta3"
                  placeholder="Ingresa la posible respuesta 3"
                  className="w-full rounded-lg border border-slate-400 p-2 my-2"
                  value={respuesta3}
                  onChange={handleChange}
                />
                <input
                  type="text"
                  id="respuesta4"
                  name="respuesta4"
                  placeholder="Ingresa la posible respuesta 4"
                  className="w-full rounded-lg border border-slate-400 p-2 my-2"
                  value={respuesta4}
                  onChange={handleChange}
                />
                <label htmlFor="respuestaC" className="text-2xl font-bold">
                  Respuesta Correcta
                  <select
                    name="respuestaC"
                    id="respuestaC"
                    // defaultValue="default"
                    className="w-full rounded-lg border border-slate-400 p-2 my-2 text-base font-normal inactive"
                    value={respuestaC == 0 ? "default" : respuestaC}
                    onChange={handleChange}
                  >
                    <option value="default" disabled>
                      --- Selecciona una respuesta correcta ---
                    </option>
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                  </select>
                </label>

                <div className="flex items-center justify-end mt-1">
                  <button
                    className="rounded-lg border border-slate-400 bg-black px-4 py-2 text-white ml-2"
                    onClick={() => {
                      setIsOpenCreate(false);
                      setFormData({
                        id_video_cuestionario: videoData
                          ? videoData.id_video_cuestionario
                          : "",
                        indice: -1,
                        nombre: "",
                        url_video: "",
                        pregunta: "",
                        respuesta1: "",
                        respuesta2: "",
                        respuesta3: "",
                        respuesta4: "",
                        respuestaC: 0,
                      });
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

      {/* Dialogo Actualizar Parte Video */}
      <Dialog open={isOpenUpdate} onClose={() => setIsOpenUpdate(false)}>
        <Dialog open={isOpenUpdate} onClose={() => setIsOpenUpdate(false)}>
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
                  value={indice == -1 ? "" : indice}
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
                <label htmlFor="pregunta" className="text-2xl font-bold">
                  Pregunta
                </label>
                <input
                  type="text"
                  id="pregunta"
                  name="pregunta"
                  placeholder="Ingresa la pregunta del clip"
                  className="w-full rounded-lg border border-slate-400 p-2 my-2"
                  value={pregunta}
                  onChange={handleChange}
                />
                <label htmlFor="respuestas" className="text-2xl font-bold">
                  Posibles Respuestas
                </label>
                <input
                  type="text"
                  id="respuesta1"
                  name="respuesta1"
                  placeholder="Ingresa la posible respuesta 1"
                  className="w-full rounded-lg border border-slate-400 p-2 my-2"
                  value={respuesta1}
                  onChange={handleChange}
                />
                <input
                  type="text"
                  id="respuesta2"
                  name="respuesta2"
                  placeholder="Ingresa la posible respuesta 2"
                  className="w-full rounded-lg border border-slate-400 p-2 my-2"
                  value={respuesta2}
                  onChange={handleChange}
                />
                <input
                  type="text"
                  id="respuesta3"
                  name="respuesta3"
                  placeholder="Ingresa la posible respuesta 3"
                  className="w-full rounded-lg border border-slate-400 p-2 my-2"
                  value={respuesta3}
                  onChange={handleChange}
                />
                <input
                  type="text"
                  id="respuesta4"
                  name="respuesta4"
                  placeholder="Ingresa la posible respuesta 4"
                  className="w-full rounded-lg border border-slate-400 p-2 my-2"
                  value={respuesta4}
                  onChange={handleChange}
                />
                <label htmlFor="respuestaC" className="text-2xl font-bold">
                  Respuesta Correcta
                  <select
                    name="respuestaC"
                    id="respuestaC"
                    // defaultValue="default"
                    className="w-full rounded-lg border border-slate-400 p-2 my-2 text-base font-normal inactive"
                    value={respuestaC == 0 ? "default" : respuestaC}
                    onChange={handleChange}
                  >
                    <option value="default" disabled>
                      --- Selecciona una respuesta correcta ---
                    </option>
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                  </select>
                </label>

                <div className="flex items-center justify-end mt-1">
                  <button
                    className="rounded-lg border border-slate-400 bg-black px-4 py-2 text-white ml-2"
                    onClick={() => {
                      setIsOpenUpdate(false);
                      setFormData({
                        id_video_cuestionario: videoData
                          ? videoData.id_video_cuestionario
                          : "",
                        indice: -1,
                        nombre: "",
                        url_video: "",
                        pregunta: "",
                        respuesta1: "",
                        respuesta2: "",
                        respuesta3: "",
                        respuesta4: "",
                        respuestaC: 0,
                      });
                    }}
                  >
                    Cancelar
                  </button>
                  <button
                    className="rounded-lg border border-slate-400 px-4 py-2 text-white ml-2"
                    style={{ background: "#8712E0" }}
                    type="submit"
                    onClick={handleUpdate}
                  >
                    Actualizar
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
              onDelete={handleDelete}
              onEdit={handleEdit}
              onSetEditID={setEditID}
            />
          ))}
        </div>
      </div>
    </>
  );
}
