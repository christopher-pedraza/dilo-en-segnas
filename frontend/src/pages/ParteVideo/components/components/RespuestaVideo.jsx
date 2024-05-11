// NextUi components
import { Checkbox, Input } from "@nextui-org/react";

// Fontawesome icons
import { faPencilAlt, faTrash } from "@fortawesome/free-solid-svg-icons";

// Components
import BotonPregunta from "./BotonPregunta";

import propTypes from "prop-types";

function RespuestaVideo({ datos_respuesta }) {
    const { respuesta, es_correcta } = datos_respuesta;

    return (
        <div className="flex items-center">
            <Checkbox
                color="success"
                radius="full"
                isSelected={es_correcta}
                isReadOnly
                className="mr-1"
            />
            <Input
                isReadOnly
                value={respuesta}
                variant="underlined"
                className="mr-4"
            />
            <BotonPregunta
                handlePress={() => {}}
                icon={faPencilAlt}
                color="secondary"
                variant="light"
                classes={"mr-4"}
            />
            <BotonPregunta
                handlePress={() => {}}
                icon={faTrash}
                color="danger"
                variant="light"
                classes={"mr-4"}
            />
        </div>
    );
}

RespuestaVideo.propTypes = {
    respuesta: propTypes.string.isRequired,
};

export default RespuestaVideo;
