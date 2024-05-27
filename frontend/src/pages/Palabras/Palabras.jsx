import { useEffect, useState } from "react";

// Llamadas a la API
import { get, del } from "src/utils/ApiRequests";

// Fontawesome icons
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
// Plus icon
import { faPlus } from "@fortawesome/free-solid-svg-icons";
// X icon
import { faTimes } from "@fortawesome/free-solid-svg-icons";

// Nextui components
import { Button, useDisclosure, Card } from "@nextui-org/react";

// Componentes
import ModalCreatePalabra from "./components/ModalCreatePalabra";

import propTypes from "prop-types";

function ActividadVideo({ id_nivel }) {
    const [palabras, setPalabras] = useState([]);
    // Disclosures para el modal
    const createDisclosure = useDisclosure();

    // let { id_nivel } = useParams();
    id_nivel = parseInt(id_nivel);

    useEffect(() => {
        get(`palabra/${id_nivel}`).then((data) => {
            console.log(data);
            setPalabras(data);
        });
    }, [id_nivel]);

    const handleCreate = () => {
        createDisclosure.onOpen();
    };

    const handleEliminate = (id_palabra) => {
        del(`palabra/${id_palabra}`).then((data) => {
            console.log(data);
            setPalabras(
                palabras.filter((palabra) => palabra.id_palabra !== id_palabra)
            );
        });
    };

    return (
        <div>
            <div className="max-w-3xl m-auto p-8">
                <div className="flex items-center justify-between">
                    <h2 className="text-3xl">Palabras del nivel</h2>
                    <Button
                        startContent={<FontAwesomeIcon icon={faPlus} />}
                        color="success"
                        onPress={handleCreate}
                    >
                        Palabra
                    </Button>
                </div>
                <div>
                    {palabras.map((parte) => (
                        <Card
                            key={parte.id_palabra}
                            className="my-4 p-4 justify-between flex flex-row items-center"
                        >
                            {parte.palabra}
                            <Button
                                color="danger"
                                isIconOnly
                                onPress={() =>
                                    handleEliminate(parte.id_palabra)
                                }
                            >
                                <FontAwesomeIcon icon={faTimes} />
                            </Button>
                        </Card>
                    ))}
                </div>
            </div>
            <ModalCreatePalabra
                isOpen={createDisclosure.isOpen}
                onOpenChange={createDisclosure.onOpenChange}
                onClose={createDisclosure.onClose}
                id_nivel={id_nivel}
                palabras={palabras}
                setPalabras={setPalabras}
            />
        </div>
    );
}

ActividadVideo.propTypes = {
    id_nivel: propTypes.string.isRequired,
};

export default ActividadVideo;
