// Hooks
import { useEffect, useState } from "react";
import { useDisclosure } from "@nextui-org/react";

// Llamadas API
import { get } from "src/utils/ApiRequests";

// Enrutamiento
import { useParams, useNavigate } from "react-router-dom";

// Components
import Navbar from "../../components/Navbar";
import ModalEditarParteVideo from "./components/ModalEditarParteVideo";

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
    const navigate = useNavigate();

    // Disclosures para el modal
    const editDisclosure = useDisclosure();

    const [refresh, setRefresh] = useState(false);

    useEffect(() => {
        get(`parteVideo/${id_parte}`).then((data) => {
            setData(data);
        });
    }, [id_parte, refresh]);

    const handleReturn = () => {
        navigate(-1);
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
                            onPress={editDisclosure.onOpen}
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
            <ModalEditarParteVideo
                isOpen={editDisclosure.isOpen}
                onOpenChange={editDisclosure.onOpenChange}
                onClose={editDisclosure.onClose}
                id_parte={id_parte}
                setRefresh={setRefresh}
                data={data}
                setData={setData}
            />
        </div>
    );
}

export default ParteVideo;
