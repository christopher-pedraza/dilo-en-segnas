/* eslint-disable react/prop-types */
import { useState, useEffect } from "react";
import { Dialog } from "@headlessui/react";
import { useLocation } from "react-router-dom";
import axios from "axios";

import Navbar from "../components/Navbar";
import ItemWord from "../components/ItemWord";

export default function Wordspage(props) {
  const location = useLocation();
  // Accede a categoryData desde location.state si existe
  const categoryData = location.state ? location.state.categoryData : null;
  console.log(categoryData);

  // Estados para controlar si el modal esta abierto o cerrado
  let [isOpenCreate, setIsOpenCreate] = useState(false);
  let [isOpenUpdate, setIsOpenUpdate] = useState(false);

  // Estado para controlar el formulario
  const [formData, setFormData] = useState({
    id_isla: categoryData ? categoryData.id_isla : "",
    palabra: "",
    id_video_segna: "",
    url_icono: "",
  });

  // Estado para controlar las palabras
  const [words, setWords] = useState([]);

  // Estado para controlar el ID de la palabra a editar
  const [editID, setEditID] = useState();

  // Estado para controlar el refresh de la pagina
  const [refresh, setRefresh] = useState(0);

  // Destructuring del formData
  const { id_isla, palabra, id_video_segna, url_icono } = formData;

  // Funcion que se ejecuta cada vez que se cambia el valor de un input
  const handleChange = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  // Funcion que se ejecuta cuando se da click en el boton de crear
  const handleCreate = (e) => {
    e.preventDefault();
    if (id_isla && palabra && id_video_segna && url_icono) {
      axios
        .post("http://localhost:3000/palabras/add", formData)
        .then((res) => {
          console.log("res", res);
          setWords([...words, res.data]);
          setFormData({
            id_isla: categoryData ? categoryData.id_isla : "",
            palabra: "",
            id_video_segna: "",
            url_icono: "",
          });
        })
        .catch((err) => console.log(err));
    }
    setIsOpenCreate(false);
  };

  // Funcion que se ejecuta cuando se da click en el boton de actualizar
  const handleUpdate = () => {
    if (id_isla && palabra && id_video_segna && url_icono) {
      axios
        .put(`http://localhost:3000/palabras/update/${editID}`, formData)
        .then((res) => {
          setFormData({
            id_isla: categoryData ? categoryData.id_isla : "",
            palabra: "",
            id_video_segna: "",
            url_icono: "",
          });
          setRefresh(refresh + 1);
        })
        .catch((err) => console.log(err));
    }
    setIsOpenUpdate(false);
  };

  // Funcion que se ejecuta cuando se da click en el boton de eliminar
  const handleDelete = (deleteID) => {
    axios
      .delete(`http://localhost:3000/palabras/remove/${deleteID}`)
      .then((res) => {
        console.log("DELETD RECORD::::", res);
        setRefresh(refresh + 1);
      })
      .catch((err) => console.log(err));
  };

  // Funcion que se ejecuta cuando se da click en el boton de editar del componente Item
  const handleEdit = (editIDNotState) => {
    setIsOpenUpdate(true);
    axios
      .get(`http://localhost:3000/palabras/get/${editIDNotState}`)
      .then((res) => {
        setFormData(res.data);
        setEditID(editIDNotState);
      })
      .catch((err) => console.log(err));
  };

  // Funcion que obtiene todas las palabras de la categoria y las actualiza cada que cambia el estado refresh
  useEffect(() => {
    axios
      .get(`http://localhost:3000/palabras/getByCategoria/${formData.id_isla}`)
      .then((res) => {
        setWords(res.data);
      })
      .catch((err) => console.log(err));
  }, [refresh, formData.id_isla]);

  return (
    <>
      {/* Dialogo Crear Categoría */}
      <Dialog open={isOpenCreate} onClose={() => setIsOpenCreate(false)}>
        <Dialog open={isOpenCreate} onClose={() => setIsOpenCreate(false)}>
          {/* The backdrop, rendered as a fixed sibling to the panel container */}
          <div className="fixed inset-0 bg-black/30" aria-hidden="true" />

          {/* Full-screen container to center the panel */}
          <div className="fixed inset-0 grid place-items-center ">
            {/* The actual dialog panel  */}
            <Dialog.Panel className="flex w-full max-w-md flex-col rounded-lg bg-white p-6">
              <form>
                <label htmlFor="palabra" className="text-2xl font-bold">
                  Nombre
                </label>
                <input
                  type="text"
                  id="palabra"
                  name="palabra"
                  placeholder="Ingresa el nombre de la palabra"
                  className="w-full rounded-lg border border-slate-400 p-2 my-2"
                  value={palabra}
                  onChange={handleChange}
                />
                <label htmlFor="url_icono" className="text-2xl font-bold">
                  Imagen
                </label>
                <input
                  type="text"
                  id="url_icono"
                  name="url_icono"
                  placeholder="Ingresa el URL de la imagen"
                  className="w-full rounded-lg border border-slate-400 p-2 my-2"
                  value={url_icono}
                  onChange={handleChange}
                />
                <label htmlFor="id_video_segna" className="text-2xl font-bold">
                  Video
                </label>
                <input
                  type="text"
                  id="id_video_segna"
                  name="id_video_segna"
                  placeholder="Ingresa el URL del video"
                  className="w-full rounded-lg border border-slate-400 p-2 my-2"
                  value={id_video_segna}
                  onChange={handleChange}
                />
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

      {/* Dialogo Actualizar Categoría */}
      <Dialog open={isOpenUpdate} onClose={() => setIsOpenUpdate(false)}>
        <Dialog open={isOpenUpdate} onClose={() => setIsOpenUpdate(false)}>
          {/* The backdrop, rendered as a fixed sibling to the panel container */}
          <div className="fixed inset-0 bg-black/30" aria-hidden="true" />

          {/* Full-screen container to center the panel */}
          <div className="fixed inset-0 grid place-items-center ">
            {/* The actual dialog panel  */}
            <Dialog.Panel className="flex w-full max-w-md flex-col rounded-lg bg-white p-6">
              <form>
                <label htmlFor="palabra" className="text-2xl font-bold">
                  Nombre
                </label>
                <input
                  type="text"
                  id="palabra"
                  name="palabra"
                  placeholder="Ingresa el nombre de la palabra"
                  className="w-full rounded-lg border border-slate-400 p-2 my-2"
                  value={palabra}
                  onChange={handleChange}
                />
                <label htmlFor="url_icono" className="text-2xl font-bold">
                  Imagen
                </label>
                <input
                  type="text"
                  id="url_icono"
                  name="url_icono"
                  placeholder="Ingresa el URL de la imagen"
                  className="w-full rounded-lg border border-slate-400 p-2 my-2"
                  value={url_icono}
                  onChange={handleChange}
                />
                <label htmlFor="id_video_segna" className="text-2xl font-bold">
                  Video
                </label>
                <input
                  type="text"
                  id="id_video_segna"
                  name="id_video_segna"
                  placeholder="Ingresa el URL del video"
                  className="w-full rounded-lg border border-slate-400 p-2 my-2"
                  value={id_video_segna}
                  onChange={handleChange}
                />
                <div className="flex items-center justify-end mt-1">
                  <button
                    className="rounded-lg border border-slate-400 bg-black px-4 py-2 text-white ml-2"
                    onClick={() => {
                      setIsOpenUpdate(false);
                      setFormData({
                        palabra: "",
                        id_video_segna: "",
                        url_icono: "",
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
          {/* Add The category name to palabras () */}
          <h2 className="text-3xl">Palabras ({categoryData.nombre})</h2>
          <button
            onClick={() => setIsOpenCreate(true)}
            className="p-2 text-white rounded-md"
            style={{ background: "#8712E0" }}
          >
            Crear Palabra
          </button>
        </div>
        <div>
          {/* Map que muestra cada palabra del array words */}
          {words.map((word, index) => (
            <ItemWord
              key={index}
              data={word}
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
