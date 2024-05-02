/* eslint-disable react/prop-types */
import EnvironmentItem from "./EnvironmentItem";
import { FaPlus } from "react-icons/fa";

function EnvironmentList({ environments, setEnvironments, navigate }) {
  const addEnvironment = () => {
    const name = prompt("Nombre del nuevo entorno:");
    if (name) {
      setEnvironments([
        ...environments,
        { id: Date.now(), name, categories: [] },
      ]);
    }
  };

  return (
    <div className="w-3/12 p-4 space-y-4">
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
        <EnvironmentItem
          key={env.id}
          environment={env}
          setEnvironments={setEnvironments}
          navigate={navigate}
        />
      ))}
    </div>
  );
}

export default EnvironmentList;
