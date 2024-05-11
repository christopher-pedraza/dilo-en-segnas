import propTypes from "prop-types";
import { Button } from "@nextui-org/react";

// Iconos
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faArrowDown, faArrowUp } from "@fortawesome/free-solid-svg-icons";

import { put } from "src/utils/ApiRequests";

function IndexButtonsPregunta({
    setRefresh,
    id_parte,
    id_pregunta,
    index,
    preguntas_length,
}) {
    const handleMoveUp = () => {
        put(`preguntaVideo/cambiarIndice/${id_pregunta}`, {
            direccion: "up",
            id_parte: id_parte,
        }).then(() => {
            setRefresh((prev) => !prev);
        });
    };

    const handleMoveDown = () => {
        put(`preguntaVideo/cambiarIndice/${id_pregunta}`, {
            direccion: "down",
            id_parte: id_parte,
        }).then(() => {
            setRefresh((prev) => !prev);
        });
    };

    return (
        <div className="flex flex-col">
            <Button
                isIconOnly={true}
                size="sm"
                variant="light"
                onPress={() => {
                    handleMoveUp();
                }}
                isDisabled={index === 0}
            >
                <FontAwesomeIcon icon={faArrowUp} />
            </Button>
            <Button
                isIconOnly={true}
                size="sm"
                variant="light"
                onPress={() => {
                    handleMoveDown();
                }}
                isDisabled={index === preguntas_length - 1}
            >
                <FontAwesomeIcon icon={faArrowDown} />
            </Button>
        </div>
    );
}

IndexButtonsPregunta.propTypes = {
    setRefresh: propTypes.func.isRequired,
    id_nivel: propTypes.number.isRequired,
    id_parte: propTypes.number.isRequired,
    index: propTypes.number.isRequired,
    partes_length: propTypes.number.isRequired,
};

export default IndexButtonsPregunta;
