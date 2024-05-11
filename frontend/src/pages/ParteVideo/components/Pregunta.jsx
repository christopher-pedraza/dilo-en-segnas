// NextUi Components
import {
    Divider,
    Button,
    Checkbox,
    Input,
    Card,
    CardHeader,
    CardBody,
    CardFooter,
} from "@nextui-org/react";

// Iconos
import { faTrash } from "@fortawesome/free-solid-svg-icons";
import { faPencilAlt } from "@fortawesome/free-solid-svg-icons";
import { faPlus } from "@fortawesome/free-solid-svg-icons";

// Components
import BotonPregunta from "./components/BotonPregunta";
import IndexButtonsPregunta from "./components/IndexButtonsPregunta";
import RespuestaVideo from "./components/RespuestaVideo";

import propTypes from "prop-types";

function Pregunta({ datos_pregunta }) {
    const { pregunta, respuestas_video_cuestionario } = datos_pregunta;

    return (
        <Card className="mb-4">
            <CardHeader className="flex items-center">
                <Input
                    label="Pregunta"
                    isReadOnly
                    value={pregunta}
                    variant="underlined"
                    className="mr-4"
                />
                {/* </Card> */}
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
                <IndexButtonsPregunta />
            </CardHeader>
            <CardBody>
                {respuestas_video_cuestionario &&
                    respuestas_video_cuestionario.map((respuesta, index) => (
                        <RespuestaVideo
                            key={index}
                            datos_respuesta={respuesta}
                        />
                    ))}
                <div className="w-full flex justify-center">
                    <BotonPregunta
                        handlePress={() => {}}
                        icon={faPlus}
                        color="success"
                        variant="ghost"
                        classes={"mt-4"}
                    />
                </div>
            </CardBody>
        </Card>
    );
}

Pregunta.propTypes = {
    datos_pregunta: propTypes.object.isRequired,
};

export default Pregunta;
