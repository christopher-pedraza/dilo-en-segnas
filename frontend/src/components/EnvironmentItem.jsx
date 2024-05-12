/* eslint-disable react/prop-types */
import {
  FaEdit,
  FaTrash,
  FaCaretDown,
  FaCaretRight,
  FaPlus,
} from "react-icons/fa";
import CategoryList from "./CategoryList";

function EnvironmentItem({ environment, setEnvironments, navigate }) {
  const deleteEnvironment = (envId) => {
    setEnvironments((prev) => prev.filter((env) => env.id !== envId));
  };

  const editEnvironment = (envId) => {
    const newName = prompt("Editar el nombre del entorno:");
    if (newName) {
      setEnvironments((prev) =>
        prev.map((env) => (env.id === envId ? { ...env, name: newName } : env))
      );
    }
  };

  const toggleCategories = () => {
    setEnvironments((prev) =>
      prev.map((env) =>
        env.id === environment.id ? { ...env, isOpen: !env.isOpen } : env
      )
    );
  };

  const addCategory = (envId) => {
    const name = prompt("Nombre de la nueva categoría:");
    if (name) {
      setEnvironments((prev) =>
        prev.map((env) =>
          env.id === envId
            ? {
                ...env,
                categories: [...env.categories, { id: Date.now(), name }],
              }
            : env
        )
      );
    }
  };

  return (
    <div className="space-y-2">
      <div className="flex items-center justify-start space-x-2">
        <button
          className="p-1 bg-blue-500 text-white rounded"
          onClick={toggleCategories}
          title="Toggle Categorías"
        >
          {environment.isOpen ? <FaCaretDown /> : <FaCaretRight />}
        </button>
        <span className="flex-grow text-sm font-bold">
          {environment.nombre}
        </span>
        <div className="flex space-x-2">
          <button
            className="p-1 bg-indigo-500 text-white rounded"
            onClick={() => addCategory(environment.id_isla)}
            title="Agregar Categoría"
          >
            <FaPlus />
          </button>
          <button
            className="p-1 bg-green-500 text-white rounded"
            onClick={() => editEnvironment(environment.id_isla)}
            title="Editar Entorno"
          >
            <FaEdit />
          </button>
          <button
            className="p-1 bg-red-500 text-white rounded"
            onClick={() => deleteEnvironment(environment.id_isla)}
            title="Eliminar Entorno"
          >
            <FaTrash />
          </button>
        </div>
      </div>
      {environment.isOpen && (
        <CategoryList
          environment={environment}
          setEnvironments={setEnvironments}
          navigate={navigate}
        />
      )}
    </div>
  );
}

export default EnvironmentItem;
