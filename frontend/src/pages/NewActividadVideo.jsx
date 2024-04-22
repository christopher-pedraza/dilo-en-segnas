import Navbar from "../components/Navbar";
import { useParams } from "react-router-dom";
import { useSelector } from "react-redux";
import { selectNivel } from "src/redux/Slices/nivelSlice";
import { useEffect, useState } from "react";
import { get } from "src/utils/ApiRequests";

function NewActividadVideo() {
    const nivel = useSelector(selectNivel);
    const [partes, setPartes] = useState([]);

    useEffect(() => {
        get("partesVideo/getByNivel/1").then((data) => {
            setPartes(data);
        });
    }, []);

    return (
        <div>
            <Navbar />
            <div className="max-w-3xl m-auto p-8">
                <div className="flex items-center justify-between">
                    <h2 className="text-3xl">Actividad de Videos</h2>
                    <button
                        className="p-2 text-white rounded-md"
                        style={{ background: "#8712E0" }}
                    >
                        Agregar Parte
                    </button>
                </div>
                <div>
                    {partes.map((parte) => (
                        <div
                            key={parte.id_pvc}
                            className="flex items-center justify-between p-4 my-4 bg-white rounded-md shadow-md"
                        >
                            <div>
                                <h3 className="text-xl">{parte.nombre}</h3>
                                <p>{parte.url_video}</p>
                            </div>
                            <div>
                                <button
                                    className="p-2 text-white rounded-md"
                                    style={{ background: "#8712E0" }}
                                >
                                    Editar
                                </button>
                                <button
                                    className="p-2 text-white rounded-md"
                                    style={{ background: "#8712E0" }}
                                >
                                    Eliminar
                                </button>
                            </div>
                        </div>
                    ))}
                </div>
            </div>
        </div>
    );
}

export default NewActividadVideo;
