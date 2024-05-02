import { useState } from "react";
import {
  FaPlus,
  FaEdit,
  FaTrash,
  FaCaretDown,
  FaCaretRight,
} from "react-icons/fa";

function SinglePageTree() {
  const [environments, setEnvironments] = useState([]);
  const [selectedCategory, setSelectedCategory] = useState("");

  // Función para agregar entornos
  const addEnvironment = () => {
    const name = prompt("Nombre del nuevo entorno:");
    if (name) {
      setEnvironments([
        ...environments,
        { id: Date.now(), name, categories: [] },
      ]);
    }
  };

  // Función para eliminar entornos
  const deleteEnvironment = (envId) => {
    setEnvironments(environments.filter((env) => env.id !== envId));
  };

  // Función para editar entornos
  const editEnvironment = (envId) => {
    const newName = prompt("Editar el nombre del entorno:");
    if (newName) {
      const updatedEnvironments = environments.map((env) => {
        if (env.id === envId) {
          return { ...env, name: newName };
        }
        return env;
      });
      setEnvironments(updatedEnvironments);
    }
  };

  // Función para agregar categorías a un entorno específico
  const addCategory = (envId) => {
    const name = prompt("Nombre de la nueva categoría:");
    if (name) {
      const updatedEnvironments = environments.map((env) => {
        if (env.id === envId) {
          return {
            ...env,
            categories: [...env.categories, { id: Date.now(), name }],
          };
        }
        return env;
      });
      setEnvironments(updatedEnvironments);
    }
  };

  // Función para eliminar categorías de un entorno específico
  const deleteCategory = (envId, catId) => {
    const updatedEnvironments = environments.map((env) => {
      if (env.id === envId) {
        return {
          ...env,
          categories: env.categories.filter((cat) => cat.id !== catId),
        };
      }
      return env;
    });
    setEnvironments(updatedEnvironments);
  };

  // Función para editar categorías en un entorno específico
  const editCategory = (envId, catId) => {
    const newName = prompt("Editar el nombre de la categoría:");
    if (newName) {
      const updatedEnvironments = environments.map((env) => {
        if (env.id === envId) {
          return {
            ...env,
            categories: env.categories.map((cat) => {
              if (cat.id === catId) {
                return { ...cat, name: newName };
              }
              return cat;
            }),
          };
        }
        return env;
      });
      setEnvironments(updatedEnvironments);
    }
  };

  const toggleCategories = (envId) => {
    setEnvironments(
      environments.map((env) => {
        if (env.id === envId) {
          return { ...env, isOpen: !env.isOpen };
        }
        return env;
      })
    );
  };

  const handleCategoryClick = (categoryName) => {
    setSelectedCategory(categoryName);
  };

  return (
    <div className="flex">
      <div className="w-1/6 p-4 space-y-4">
        <button
          className="p-2 rounded bg-blue-500 text-white"
          onClick={addEnvironment}
          title="Crear Entorno"
        >
          <div className="flex items-center gap-2">
            <FaPlus />
            <p>Agregar Entorno</p>
          </div>
        </button>
        {environments.map((env) => (
          <div key={env.id} className="space-y-2">
            <div className="flex items-center justify-start space-x-2">
              <button
                className="p-1 bg-blue-500 text-white rounded"
                onClick={() => toggleCategories(env.id)}
                title="Toggle Categorías"
              >
                {env.isOpen ? <FaCaretDown /> : <FaCaretRight />}
              </button>
              <span className="flex-grow text-sm font-bold">{env.name}</span>
              <div className="flex space-x-2">
                <button
                  className="p-1 bg-indigo-500 text-white rounded"
                  onClick={() => addCategory(env.id)}
                  title="Agregar Categoría"
                >
                  <FaPlus />
                </button>
                <button
                  className="p-1 bg-green-500 text-white rounded"
                  onClick={() => editEnvironment(env.id)}
                  title="Editar Entorno"
                >
                  <FaEdit />
                </button>
                <button
                  className="p-1 bg-red-500 text-white rounded"
                  onClick={() => deleteEnvironment(env.id)}
                  title="Eliminar Entorno"
                >
                  <FaTrash />
                </button>
              </div>
            </div>
            {env.isOpen &&
              env.categories.map((cat) => (
                <div
                  key={cat.id}
                  className="ml-6 flex items-center justify-between"
                >
                  <span
                    className="text-xs cursor-pointer"
                    onClick={() => handleCategoryClick(cat.name)}
                  >
                    {cat.name}
                  </span>
                  <div className="flex space-x-2">
                    <button
                      className="p-1 bg-green-500 text-white rounded"
                      onClick={() => editCategory(env.id, cat.id)}
                      title="Editar Categoría"
                    >
                      <FaEdit />
                    </button>
                    <button
                      className="p-1 bg-red-500 text-white rounded"
                      onClick={() => deleteCategory(env.id, cat.id)}
                      title="Eliminar Categoría"
                    >
                      <FaTrash />
                    </button>
                  </div>
                </div>
              ))}
          </div>
        ))}
      </div>
      <div className="w-5/6 p-4">
        {selectedCategory && <p className="text-xl">{selectedCategory}</p>}
      </div>
    </div>
  );
}

export default SinglePageTree;
