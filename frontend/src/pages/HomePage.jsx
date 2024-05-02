import { useState, useEffect } from "react";
import { useNavigate, useParams } from "react-router-dom";
import EnvironmentList from "../components/EnvironmentList";

function HomePage() {
  const navigate = useNavigate();
  const { envName, categoryName } = useParams();
  const [environments, setEnvironments] = useState([]);

  useEffect(() => {
    const initialEnvironments = [
      { id: 1, name: "Env1", categories: [{ id: 1, name: "Cat1" }] },
      { id: 2, name: "Env2", categories: [{ id: 2, name: "Cat2" }] },
    ];
    setEnvironments(initialEnvironments);
  }, []);

  return (
    <div className="flex">
      <EnvironmentList
        environments={environments}
        setEnvironments={setEnvironments}
        navigate={navigate}
      />
      <div className="w-9/12 p-4">
        <h1 className="text-2xl font-bold">Contenido de la Categoría</h1>
        <p className="text-xl">Entorno: {envName || "No especificado"}</p>
        <p className="text-xl">
          Categoría: {categoryName || "No especificada"}
        </p>
      </div>
    </div>
  );
}

export default HomePage;
