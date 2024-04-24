// Hooks
import { useEffect, useState } from "react";

// Llamadas API
import { get } from "src/utils/ApiRequests";

// Enrutamiento
import { useParams, useHistory } from "react-router-dom";

// Components
import Navbar from "../components/Navbar";

// NextUI components
import { Button } from "@nextui-org/react";

// Fontawesome icons
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
// Plus icon
import { faPlus } from "@fortawesome/free-solid-svg-icons";
// Pencil icon
import { faPencilAlt } from "@fortawesome/free-solid-svg-icons";
// Left arrow icon
import { faArrowLeft } from "@fortawesome/free-solid-svg-icons";

function ParteVideo() {
    // Obtener del url el id de la parte de video
    const { id_parte } = useParams();

    // Informacion de la parte
    const [data, setData] = useState([]);

    // Historial de navegacion
    const history = useHistory();

    useEffect(() => {
        get(`partesVideo/${id_parte}`).then((data) => {
            setData(data);
        });
    }, [id_parte]);

    const handleReturn = () => {
        history.goBack();
    };

    return (
        <div>
            <Navbar />
            <div className="max-w-3xl m-auto p-8">
                <div className="flex items-center justify-between">
                    <div className="flex items-center">
                        <Button
                            isIconOnly
                            variant="light"
                            onPress={handleReturn}
                        >
                            <FontAwesomeIcon icon={faArrowLeft} />
                        </Button>
                        <h2 className="text-3xl">{data.nombre}</h2>
                    </div>
                    <div className="flex items-center">
                        <Button
                            startContent={
                                <FontAwesomeIcon icon={faPencilAlt} />
                            }
                            color="secondary"
                            onPress={() => {}}
                            className="mr-2"
                        >
                            Editar datos
                        </Button>
                        <Button
                            startContent={<FontAwesomeIcon icon={faPlus} />}
                            color="success"
                            onPress={() => {}}
                        >
                            Pregunta
                        </Button>
                    </div>
                </div>
            </div>
        </div>
    );
}

export default ParteVideo;
