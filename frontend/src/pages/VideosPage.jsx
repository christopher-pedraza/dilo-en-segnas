import { useState, useEffect } from "react";
import { Dialog } from "@headlessui/react";
import axios from "axios";

import Navbar from "../components/Navbar";
import ItemVideos from "../components/ItemVideos";
import ItemToggle from "../components/ItemToggle";

export default function VideosPage() {
  // Estados para controlar si el modal esta abierto o cerrado
  let [isOpenCreate, setIsOpenCreate] = useState(false);
  let [isOpenUpdate, setIsOpenUpdate] = useState(false);

  // Estado para controlar el formulario
  const [formData, setFormData] = useState({
    id_isla: 0,
    nombre: "",
    palabras: [],
  });

  // Estado para controlar los videos
  const [videos, setVideos] = useState([]);

  // Estado para controlar las categorias
  const [categories, setCategories] = useState([]);

  // Estado para controlar las palabras
  const [words, setWords] = useState([]);

  // Estado para controlar el ID del quiz a editar
  const [editID, setEditID] = useState();

  // Estado para controlar el refresh de la pagina
  const [refresh, setRefresh] = useState(0);

  // Destructuring del formData
  const { id_isla, nombre, palabras } = formData;

  // Funcion que se ejecuta cada vez que se cambia el valor de un input
  const handleChange = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  // Funcion que obtiene todos los videos y los actualiza cada que cambia el estado refresh
  useEffect(() => {
    axios
      .get("http://localhost:3000/videos/getAll")
      .then((res) => setVideos(res.data))
      .catch((err) => console.log(err));
  }, [refresh]);

  // Funcion que obtiene todas las categorias
  useEffect(() => {
    axios
      .get("http://localhost:3000/categorias/getAll")
      .then((res) => {
        setCategories(res.data);
      })
      .catch((err) => console.log(err));
  }, []);

  // Funcion que obtiene todas las palabras de una categoría
  useEffect(() => {
    axios
      .get(`http://localhost:3000/palabras/getByCategoria/${formData.id_isla}`)
      .then((res) => {
        setWords(res.data);
        console.log(res.data);
      })
      .catch((err) => console.log(err));
  }, [formData.id_isla]);

  return (
    <>
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
                  placeholder="Ingresa el nombre del quiz"
                  className="w-full rounded-lg border border-slate-400 p-2 my-2"
                  value={nombre}
                  onChange={handleChange}
                />
                <label htmlFor="id_isla" className="text-2xl font-bold">
                  Categoría
                  <select
                    name="id_isla"
                    id="id_isla"
                    className="w-full rounded-lg border border-slate-400 p-2 my-2 text-base font-normal inactive"
                    value={id_isla == 0 ? "default" : id_isla}
                    onChange={handleChange}
                  >
                    <option value="default" disabled>
                      --- Selecciona una categoria ---
                    </option>
                    {categories.map((category, index) => (
                      <option key={index} value={category.id_isla}>
                        {category.nombre}
                      </option>
                    ))}
                  </select>
                </label>
                <label htmlFor="palabras" className="text-2xl font-bold">
                  Palabras
                </label>
                <div className="mb-6">
                  {words.map((word, index) => (
                    <ItemToggle
                      key={index}
                      data={word}
                      // onToggle={handleToggle}
                    />
                  ))}
                </div>
                <div className="flex items-center justify-end mt-1">
                  <button
                    className="rounded-lg border border-slate-400 bg-black px-4 py-2 text-white ml-2"
                    onClick={() => setIsOpenCreate(false)}
                  >
                    Cancelar
                  </button>
                  <button
                    className="rounded-lg border border-slate-400 px-4 py-2 text-white ml-2"
                    style={{ background: "#8712E0" }}
                    type="submit"
                    onClick={() => setIsOpenCreate(false)}
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
          <h2 className="text-3xl">Videos</h2>
          <button
            onClick={() => setIsOpenCreate(true)}
            className="p-2 text-white rounded-md"
            style={{ background: "#8712E0" }}
          >
            Crear Video
          </button>
        </div>
        <div>
          <ItemVideos />
          <ItemVideos />
          <ItemVideos />
        </div>
      </div>
    </>
  );
}
