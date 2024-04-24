// Hooks
import { useEffect, useState } from "react";

// Llamadas API
import { get } from "src/utils/ApiRequests";

// Enrutamiento
import { useParams } from "react-router-dom";

// Components
import Navbar from "../components/Navbar";

function ParteVideo() {
    // Obtener del url el id de la parte de video
    const { id_parte } = useParams();

    // Informacion de la parte
    const [data, setData] = useState([]);

    useEffect(() => {
        get(`partesVideo/${id_parte}`).then((data) => {
            setData(data);
        });
    }, [id_parte]);

    return (
        <div>
            <Navbar />
            {data.nombre}
        </div>
    );
}

export default ParteVideo;
