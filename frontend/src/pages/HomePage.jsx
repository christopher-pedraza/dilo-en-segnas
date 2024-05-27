import { useState, useEffect } from "react";
import { useNavigate, useParams } from "react-router-dom";
import EnvironmentList from "../components/EnvironmentList";
import { Tabs, Tab, Card, CardBody } from "@nextui-org/react";
import Navbar from "../components/Navbar";
import ActividadVideo from "./ActividadVideo/ActividadVideo";

function HomePage() {
    const navigate = useNavigate();
    const { envName, categoryName } = useParams();
    const [environments, setEnvironments] = useState([]);
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState(null);

    useEffect(() => {
        const fetchEnvironments = async () => {
            setLoading(true);
            try {
                const response = await fetch(
                    "http://localhost:3000/isla/withNiveles"
                );
                if (!response.ok)
                    throw new Error("Network response was not ok");
                const data = await response.json();
                console.log(data);
                setEnvironments(data);
            } catch (err) {
                setError(err.message);
            } finally {
                setLoading(false);
            }
        };

        fetchEnvironments();
    }, []);

    if (loading) return <div>Loading...</div>;
    if (error) return <div>Error: {error}</div>;

    return (
        <>
            <Navbar />
            <div className="flex">
                <EnvironmentList
                    environments={environments}
                    setEnvironments={setEnvironments}
                    navigate={navigate}
                />
                <div className="w-9/12 p-4">
                    {envName && categoryName ? (
                        <div>
                            <h1 className="text-2xl font-bold">
                                Contenido de la Categoría
                            </h1>
                            <Tabs aria-label="Options">
                                <Tab key="palabras" title="Palabras"></Tab>
                                <Tab key="videos" title="Actividad de videos">
                                    <ActividadVideo
                                        id_isla={envName}
                                        id_nivel={categoryName}
                                    />
                                </Tab>
                            </Tabs>
                        </div>
                    ) : null}
                </div>
            </div>
        </>
    );
}

export default HomePage;
