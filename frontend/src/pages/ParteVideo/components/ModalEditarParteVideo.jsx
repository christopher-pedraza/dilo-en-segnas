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
import { put } from "src/utils/ApiRequests";

// Hooks
import { useState } from "react";

import propTypes from "prop-types";

function ModalCreateParteVideo({
    isOpen,
    onOpenChange,
    onClose,
    id_parte,
    data,
    setData,
}) {
    // Datos de la parte que se quiere agregar
    const [nombreNuevo, setNombreNuevo] = useState();
    const [urlVideoNuevo, setUrlVideoNuevo] = useState();

    const confirmEdit = () => {
        put(`parteVideo/${id_parte}`, {
            nombre: nombreNuevo,
            url_video: urlVideoNuevo,
        }).then(() => {
            setData((prevData) => {
                return {
                    ...prevData,
                    nombre: nombreNuevo,
                    url_video: urlVideoNuevo,
                };
            });
        });
        onClose();
        setNombreNuevo(data.nombre);
        setUrlVideoNuevo(data.url_video);
    };

    const handleClose = () => {
        onClose();
        setNombreNuevo(data.nombre);
        setUrlVideoNuevo(data.url_video);
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
                            Editar datos de la parte
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
                                onPress={handleClose}
                            >
                                Cancelar
                            </Button>
                            <Button color="success" onPress={confirmEdit}>
                                Guardar
                            </Button>
                        </ModalFooter>
                    </>
                )}
            </ModalContent>
        </Modal>
    );
}

ModalCreateParteVideo.propTypes = {
    isOpen: propTypes.bool.isRequired,
    onOpenChange: propTypes.func.isRequired,
    onClose: propTypes.func.isRequired,
    id_parte: propTypes.number.isRequired,
    data: propTypes.object.isRequired,
    setData: propTypes.func.isRequired,
};

export default ModalCreateParteVideo;
