import { useEffect, useState } from "react";

// Llamadas a la API
import { get, post, del, put } from "src/utils/ApiRequests";

// Enrutamiento
import { useNavigate, useParams } from "react-router-dom";

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
// Up icon
import { faArrowUp } from "@fortawesome/free-solid-svg-icons";
// Down icon
import { faArrowDown } from "@fortawesome/free-solid-svg-icons";
// Youtube icon
import { faYoutube } from "@fortawesome/free-brands-svg-icons";

// Nextui components
import {
    Button,
    Modal,
    ModalContent,
    ModalHeader,
    ModalBody,
    ModalFooter,
    useDisclosure,
    Input,
} from "@nextui-org/react";

function NewActividadVideo() {
    const [partes, setPartes] = useState([]);
    // Variable para que se actualice la lista de partes cuando se elimina una
    const [refresh, setRefresh] = useState(false);
    // ID de la parte seleccionada que se quiere eliminar
    const [idToDelete, setIdToDelete] = useState(null);
    // Datos de la parte que se quiere agregar
    const [nombreNuevo, setNombreNuevo] = useState("");
    const [urlVideoNuevo, setUrlVideoNuevo] = useState("");
    // ID del video a desplegar
    const [idVideo, setIdVideo] = useState(null);

    // Disclosures para el modal
    const deleteDisclosure = useDisclosure();
    const createDisclosure = useDisclosure();
    const videoDisclosure = useDisclosure();

    const { id_nivel } = useParams();

    const navigate = useNavigate();

    useEffect(() => {
        get(`partesVideo/getByNivel/${id_nivel}`).then((data) => {
            // Ordenar las partes por el índice
            data.sort((a, b) => a.indice - b.indice);
            setPartes(data);
        });
    }, [id_nivel, refresh]);

    const handleEdit = (id_parte) => {
        navigate(`/videos/${id_nivel}/parte/${id_parte}`);
        console.log("Editando: ", id_parte);
    };

    const handleDelete = (id_parte) => {
        setIdToDelete(id_parte);
        deleteDisclosure.onOpen();
    };

    const handleMoveUp = (id_parte) => {
        put(`partesVideo/cambiarIndice/${id_parte}`, {
            direccion: "up",
            id_nivel: id_nivel,
        }).then(() => {
            setRefresh((prev) => !prev);
        });
    };

    const handleMoveDown = (id_parte) => {
        put(`partesVideo/cambiarIndice/${id_parte}`, {
            direccion: "down",
            id_nivel: id_nivel,
        }).then(() => {
            setRefresh((prev) => !prev);
        });
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
        createDisclosure.onOpen();
    };

    const confirmCreate = () => {
        post("partesVideo", {
            id_nivel: id_nivel,
            url_video: urlVideoNuevo,
            indice: 0,
            nombre: nombreNuevo,
        }).then((data) => {
            console.log(data);
            setPartes([...partes, data]);
        });
        createDisclosure.onClose();
        setNombreNuevo("");
        setUrlVideoNuevo("");
    };

    const handleViewVideo = (id_video) => {
        setIdVideo(id_video);
        videoDisclosure.onOpen();
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
                    {partes.map((parte, index) => (
                        <div
                            key={parte.id_parte_video_cuestionario}
                            className="flex items-center justify-between p-4 my-4 bg-white rounded-md shadow-md"
                        >
                            <div>
                                <h3 className="text-xl">{parte.nombre}</h3>
                                <p>{parte.url_video}</p>
                                <p>Índice: {parte.indice}</p>
                            </div>
                            <div className="flex justify-end">
                                <div className="flex items-center">
                                    <Button
                                        isIconOnly={true}
                                        color="primary"
                                        variant="light"
                                        onPress={() => {
                                            handleViewVideo(parte.url_video);
                                        }}
                                        className="mr-4"
                                    >
                                        <FontAwesomeIcon icon={faYoutube} />
                                    </Button>
                                    <Button
                                        isIconOnly={true}
                                        color="secondary"
                                        variant="light"
                                        onPress={() => {
                                            handleEdit(
                                                parte.id_parte_video_cuestionario
                                            );
                                        }}
                                        className="mr-4"
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
                                        className="mr-4"
                                    >
                                        <FontAwesomeIcon icon={faTrash} />
                                    </Button>
                                </div>
                                <div className="flex flex-col">
                                    <Button
                                        isIconOnly={true}
                                        variant="light"
                                        onPress={() => {
                                            handleMoveUp(
                                                parte.id_parte_video_cuestionario
                                            );
                                        }}
                                        isDisabled={index === 0}
                                    >
                                        <FontAwesomeIcon icon={faArrowUp} />
                                    </Button>
                                    <Button
                                        isIconOnly={true}
                                        variant="light"
                                        onPress={() => {
                                            handleMoveDown(
                                                parte.id_parte_video_cuestionario
                                            );
                                        }}
                                        isDisabled={index === partes.length - 1}
                                    >
                                        <FontAwesomeIcon icon={faArrowDown} />
                                    </Button>
                                </div>
                            </div>
                        </div>
                    ))}
                </div>
            </div>
            <Modal
                isOpen={createDisclosure.isOpen}
                onOpenChange={createDisclosure.onOpenChange}
                backdrop="blur"
            >
                <ModalContent>
                    {(onClose) => (
                        <>
                            <ModalHeader className="flex flex-col gap-1">
                                Agregar nueva parte
                            </ModalHeader>
                            <ModalBody>
                                <Input
                                    autoFocus
                                    label="Nombre"
                                    variant="bordered"
                                    value={nombreNuevo}
                                    onChange={(e) => {
                                        setNombreNuevo(e.target.value);
                                    }}
                                />
                                <Input
                                    label="URL del video"
                                    variant="bordered"
                                    value={urlVideoNuevo}
                                    onChange={(e) => {
                                        setUrlVideoNuevo(e.target.value);
                                    }}
                                />
                            </ModalBody>
                            <ModalFooter>
                                <Button
                                    color="danger"
                                    variant="light"
                                    onPress={onClose}
                                >
                                    Cancelar
                                </Button>
                                <Button color="success" onPress={confirmCreate}>
                                    Agregar
                                </Button>
                            </ModalFooter>
                        </>
                    )}
                </ModalContent>
            </Modal>

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

            <Modal
                isOpen={videoDisclosure.isOpen}
                onOpenChange={videoDisclosure.onOpenChange}
                backdrop="opaque"
                size="3xl"
            >
                <ModalContent>
                    <iframe
                        width={"100%"}
                        height={"432px"}
                        src={`https://www.youtube.com/embed/${idVideo}`}
                        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                        referrerPolicy="strict-origin-when-cross-origin"
                    />
                </ModalContent>
            </Modal>
        </div>
    );
}

export default NewActividadVideo;
