import { useState, useEffect } from "react";
import { useNavigate, useParams } from "react-router-dom";
import {
  FaPlus,
  FaEdit,
  FaTrash,
  FaCaretDown,
  FaCaretRight,
} from "react-icons/fa";

function HomePage() {
  const navigate = useNavigate();
  const { envName, categoryName } = useParams();
  const [environments, setEnvironments] = useState([]);

  // Simular carga de datos
  useEffect(() => {
    const initialEnvironments = [
      { id: 1, name: "Env1", categories: [{ id: 1, name: "Cat1" }] },
      { id: 2, name: "Env2", categories: [{ id: 2, name: "Cat2" }] },
    ];
    setEnvironments(initialEnvironments);
  }, [envName, categoryName]);

  const addEnvironment = () => {
    const name = prompt("Nombre del nuevo entorno:");
    if (name) {
      setEnvironments([
        ...environments,
        { id: Date.now(), name, categories: [] },
      ]);
    }
    console.log("Información actualizada enviada a la API:", environments);
  };

  const deleteEnvironment = (envId) => {
    setEnvironments(environments.filter((env) => env.id !== envId));
    console.log("Información actualizada enviada a la API:", environments);
  };

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
    console.log("Información actualizada enviada a la API:", environments);
  };

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
      console.log("Información actualizada enviada a la API:", environments);
    }
  };

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
    console.log("Información actualizada enviada a la API:", environments);
  };

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
      console.log("Información actualizada enviada a la API:", environments);
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

  const handleCategoryClick = (envName, categoryName) => {
    navigate(`/${envName}/${categoryName}`);
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
                    onClick={() => handleCategoryClick(env.name, cat.name)}
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
        <h1 className="text-2xl font-bold">Contenido de la Categoría</h1>
        {/* Muestra el nombre del entorno y la categoría seleccionados */}
        <p className="text-xl">Entorno: {envName || "No especificado"}</p>
        <p className="text-xl">
          Categoría: {categoryName || "No especificada"}
        </p>
      </div>
    </div>
  );
}

export default HomePage;
