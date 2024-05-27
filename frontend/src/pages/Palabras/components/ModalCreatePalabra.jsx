// Nextui components
import {
    Button,
    Modal,
    ModalContent,
    ModalHeader,
    ModalBody,
    ModalFooter,
    Input,
} from "@nextui-org/react";

// Api Requests
import { post } from "src/utils/ApiRequests";

// Hooks
import { useState } from "react";

import propTypes from "prop-types";

function ModalCreatePalabra({
    isOpen,
    onOpenChange,
    onClose,
    id_nivel,
    palabras,
    setPalabras,
}) {
    // Datos de la parte que se quiere agregar
    const [palabra, setPalabra] = useState("");
    const [urlVideo, setUrlVideo] = useState("");
    const [urlIcono, setUrlIcono] = useState("");

    const confirmCreate = (e) => {
        e.preventDefault();

        post("palabra", {
            id_nivel,
            palabra,
            id_video_segna: urlVideo,
            url_icono: urlIcono,
        }).then((data) => {
            console.log(data);
            setPalabras([...palabras, data]);
        });
        onClose();
        setPalabra("");
        setUrlIcono("");
        setUrlVideo("");
    };

    const handleClose = () => {
        onClose();
        setPalabra("");
        setUrlIcono("");
        setUrlVideo("");
    };

    return (
        <Modal
            isOpen={isOpen}
            onOpenChange={(isOpen) => {
                if (!isOpen) {
                    handleClose();
                }
                onOpenChange(isOpen);
            }}
            backdrop="blur"
        >
            <ModalContent>
                {() => (
                    <>
                        <ModalHeader className="flex flex-col gap-1">
                            Agregar nueva palabra
                        </ModalHeader>
                        <form onSubmit={confirmCreate}>
                            <ModalBody>
                                <Input
                                    autoFocus
                                    label="Nombre"
                                    variant="bordered"
                                    value={palabra}
                                    onChange={(e) => {
                                        setPalabra(e.target.value);
                                    }}
                                />
                                <Input
                                    label="Url del video"
                                    variant="bordered"
                                    value={urlVideo}
                                    onChange={(e) => {
                                        setUrlVideo(e.target.value);
                                    }}
                                />
                                <Input
                                    label="Url del icono"
                                    variant="bordered"
                                    value={urlIcono}
                                    onChange={(e) => {
                                        setUrlIcono(e.target.value);
                                    }}
                                />
                            </ModalBody>
                            <ModalFooter>
                                <Button
                                    color="danger"
                                    variant="light"
                                    onPress={handleClose}
                                >
                                    Cancelar
                                </Button>
                                <Button color="success" type="submit">
                                    Agregar
                                </Button>
                            </ModalFooter>
                        </form>
                    </>
                )}
            </ModalContent>
        </Modal>
    );
}

ModalCreatePalabra.propTypes = {
    isOpen: propTypes.bool.isRequired,
    onOpenChange: propTypes.func.isRequired,
    onClose: propTypes.func.isRequired,
    id_nivel: propTypes.number.isRequired,
    palabras: propTypes.array.isRequired,
    setPalabras: propTypes.func.isRequired,
};

export default ModalCreatePalabra;
