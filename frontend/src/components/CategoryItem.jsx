/* eslint-disable react/prop-types */
import { FaEdit, FaTrash } from "react-icons/fa";

function CategoryItem({ category, environment, setEnvironments, navigate }) {
  const deleteCategory = (catId) => {
    setEnvironments((prev) =>
      prev.map((env) =>
        env.id === environment.id
          ? {
              ...env,
              categories: env.categories.filter((cat) => cat.id !== catId),
            }
          : env
      )
    );
  };

  const editCategory = (catId) => {
    const newName = prompt("Editar el nombre de la categoría:");
    if (newName) {
      setEnvironments((prev) =>
        prev.map((env) =>
          env.id === environment.id
            ? {
                ...env,
                categories: env.categories.map((cat) =>
                  cat.id === catId ? { ...cat, name: newName } : cat
                ),
              }
            : env
        )
      );
    }
  };

  return (
    <div className="flex items-center justify-between py-1">
      <span
        className="text-xs cursor-pointer"
        // onClick={() => navigate(`/${environment.nombre}/${category.nombre}`)}
        onClick={() => navigate(`/${environment.id_isla}/${category.id_nivel}`)}
      >
        {category.nombre}
      </span>
      <div className="flex space-x-2">
        <button
          className="p-1 bg-green-500 text-white rounded"
          onClick={() => editCategory(category.id_nivel)}
          title="Editar Categoría"
        >
          <FaEdit />
        </button>
        <button
          className="p-1 bg-red-500 text-white rounded"
          onClick={() => deleteCategory(category.id_nivel)}
          title="Eliminar Categoría"
        >
          <FaTrash />
        </button>
      </div>
    </div>
  );
}

export default CategoryItem;
