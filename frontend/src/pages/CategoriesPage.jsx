import { useState, useEffect } from "react";
import { Dialog } from "@headlessui/react";
import axios from "axios";

import Navbar from "../components/Navbar";
import ItemCategory from "../components/ItemCategory";

export default function CategoriesPage() {
  // Estados para controlar si el modal esta abierto o cerrado
  let [isOpenCreate, setIsOpenCreate] = useState(false);
  let [isOpenUpdate, setIsOpenUpdate] = useState(false);

  // Estado para controlar el formulario
  const [formData, setFormData] = useState({
    nombre: "",
  });

  // Estado para controlar las categorias
  const [categories, setCategories] = useState([]);

  // Estado para controlar el ID de la categoria a editar
  const [editID, setEditID] = useState();

  // Estado para controlar el refresh de la pagina
  const [refresh, setRefresh] = useState(0);

  // Destructuring del formData
  const { nombre } = formData;

  // Funcion que se ejecuta cada vez que se cambia el valor de un input
  const handleChange = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  // Funcion que se ejecuta cuando se da click en el boton de crear
  const handleCreate = (e) => {
    e.preventDefault();
    if (nombre) {
      axios
        .post("http://localhost:3000/categorias/add", formData)
        .then((res) => {
          setCategories([...categories, res.data]);
          setFormData({ nombre: "" });
        })
        .catch((err) => console.log(err));
    }
    setIsOpenCreate(false);
  };

  // Funcion que se ejecuta cuando se da click en el boton de actualizar
  const handleUpdate = () => {
    if (nombre) {
      axios
        .put(`http://localhost:3000/categorias/update/${editID}`, formData)
        .then((res) => {
          setFormData({ nombre: "" });
          setRefresh(refresh + 1);
        })
        .catch((err) => console.log(err));
    }
    setIsOpenUpdate(false);
  };

  // Funcion que se ejecuta cuando se da click en el boton de eliminar
  const handleDelete = (deleteID) => {
    axios
      .delete(`http://localhost:3000/categorias/remove/${deleteID}`)
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
      .get(`http://localhost:3000/categorias/get/${editIDNotState}`)
      .then((res) => {
        setFormData(res.data);
        setEditID(editIDNotState);
      })
      .catch((err) => console.log(err));
  };

  // Funcion que obtiene todas las categorias y las actualiza cada que cambia el estado refresh
  useEffect(() => {
    axios
      .get("http://localhost:3000/categorias/getAll")
      .then((res) => {
        setCategories(res.data);
      })
      .catch((err) => console.log(err));
  }, [refresh]);

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
                <label htmlFor="nombre" className="text-2xl font-bold">
                  Título
                </label>
                <input
                  type="text"
                  id="nombre"
                  name="nombre"
                  placeholder="Ingresa el título de la categoría"
                  className="w-full rounded-lg border border-slate-400 p-2 my-2"
                  value={nombre}
                  onChange={handleChange}
                />
                <div className="flex items-center justify-end mt-1">
                  <button
                    className="rounded-lg border border-slate-400 bg-black px-4 py-2 text-white ml-2"
                    onClick={() => {
                      setIsOpenCreate(false);
                      setFormData({ nombre: "" });
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
                <label htmlFor="nombre" className="text-2xl font-bold">
                  Título
                </label>
                <input
                  type="text"
                  id="nombre"
                  name="nombre"
                  placeholder="Ingresa el título de la categoría"
                  className="w-full rounded-lg border border-slate-400 p-2 my-2"
                  value={nombre}
                  onChange={handleChange}
                />
                <div className="flex items-center justify-end mt-1">
                  <button
                    className="rounded-lg border border-slate-400 bg-black px-4 py-2 text-white ml-2"
                    onClick={() => {
                      setIsOpenCreate(false);
                      setFormData({ nombre: "" });
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
          <h2 className="text-3xl">Categorías</h2>
          <button
            onClick={() => setIsOpenCreate(true)}
            className="p-2 text-white rounded-md"
            style={{ background: "#8712E0" }}
          >
            Crear Categoría
          </button>
        </div>
        <div>
          {/* Map que muestra cada categoría del array categories */}
          {categories.map((category, index) => (
            <ItemCategory
              key={index}
              data={category}
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
