import { useSelector } from "react-redux";
import { selectNivel } from "src/redux/Slices/nivelSlice";
import { useEffect, useState } from "react";
import { get, post, del } from "src/utils/ApiRequests";

// Components
import Navbar from "../components/Navbar";

// Fontawesome icons
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
// Trash icon
import { faTrash } from "@fortawesome/free-solid-svg-icons";
// Pencil icon
import { faPencilAlt } from "@fortawesome/free-solid-svg-icons";
// Plus icon
import { faPlus } from "@fortawesome/free-solid-svg-icons";

// Nextui components
import {
    Button,
    Modal,
    ModalContent,
    ModalHeader,
    ModalBody,
    ModalFooter,
    useDisclosure,
} from "@nextui-org/react";

function NewActividadVideo() {
    const nivel = useSelector(selectNivel);
    const [partes, setPartes] = useState([]);
    // Variable para que se actualice la lista de partes cuando se elimina una
    const [refresh, setRefresh] = useState(false);
    // ID de la parte seleccionada que se quiere eliminar
    const [idToDelete, setIdToDelete] = useState(null);

    // Disclosures para el modal
    const deleteDisclosure = useDisclosure();
    const editDisclosure = useDisclosure();

    useEffect(() => {
        get(`partesVideo/getByNivel/${nivel}`).then((data) => {
            setPartes(data);
        });
    }, [nivel, refresh]);

    const handleEdit = (id_parte) => {
        console.log("Editando: ", id_parte);
    };

    const handleDelete = (id_parte) => {
        setIdToDelete(id_parte);
        deleteDisclosure.onOpen();
    };

    const confirmDelete = () => {
        if (idToDelete !== null) {
            del(`partesVideo/${idToDelete}`).then(() => {
                setRefresh((prev) => !prev);
            });
        }
        deleteDisclosure.onClose(); // Close the delete confirmation modal
        setIdToDelete(null); // Reset the id to delete
    };

    const handleCreate = () => {
        console.log("Creando");
        post("partesVideo", {
            id_nivel: nivel,
            url_video: "url",
            indice: 0,
            nombre: "nombre",
        }).then((data) => {
            console.log(data);
            setPartes([...partes, data]);
        });
    };

    return (
        <div>
            <Navbar />
            <div className="max-w-3xl m-auto p-8">
                <div className="flex items-center justify-between">
                    <h2 className="text-3xl">Actividad de Videos</h2>
                    <Button
                        startContent={<FontAwesomeIcon icon={faPlus} />}
                        color="success"
                        onPress={handleCreate}
                    >
                        Parte
                    </Button>
                </div>
                <div>
                    {partes.map((parte) => (
                        <div
                            key={parte.id_parte_video_cuestionario}
                            className="flex items-center justify-between p-4 my-4 bg-white rounded-md shadow-md"
                        >
                            <div>
                                <h3 className="text-xl">{parte.nombre}</h3>
                                <p>{parte.url_video}</p>
                            </div>
                            <div>
                                <Button
                                    isIconOnly={true}
                                    color="info"
                                    onPress={() => {
                                        handleEdit(
                                            parte.id_parte_video_cuestionario
                                        );
                                    }}
                                >
                                    <FontAwesomeIcon icon={faPencilAlt} />
                                </Button>
                                <Button
                                    isIconOnly={true}
                                    color="danger"
                                    onPress={() => {
                                        handleDelete(
                                            parte.id_parte_video_cuestionario
                                        );
                                    }}
                                >
                                    <FontAwesomeIcon icon={faTrash} />
                                </Button>
                            </div>
                        </div>
                    ))}
                </div>
            </div>
            <Modal
                isOpen={deleteDisclosure.isOpen}
                onOpenChange={deleteDisclosure.onOpenChange}
                backdrop="blur"
            >
                <ModalContent>
                    {(onClose) => (
                        <>
                            <ModalHeader className="flex flex-col gap-1">
                                Eliminar parte
                            </ModalHeader>
                            <ModalBody>
                                <p>
                                    ¿Estás seguro que deseas eliminar esta parte
                                    de la actividad?
                                </p>
                            </ModalBody>
                            <ModalFooter>
                                <Button
                                    color="primary"
                                    variant="light"
                                    onPress={onClose}
                                >
                                    Cancelar
                                </Button>
                                <Button color="danger" onPress={confirmDelete}>
                                    Eliminar
                                </Button>
                            </ModalFooter>
                        </>
                    )}
                </ModalContent>
            </Modal>
        </div>
    );
}

export default NewActividadVideo;
