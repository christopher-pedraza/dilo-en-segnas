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
    useDisclosure,
} from "@nextui-org/react";

// Iconos
import { faTrash } from "@fortawesome/free-solid-svg-icons";
import { faPencilAlt } from "@fortawesome/free-solid-svg-icons";
import { faPlus } from "@fortawesome/free-solid-svg-icons";

// Components
import BotonPregunta from "./components/BotonPregunta";
import IndexButtonsPregunta from "./components/IndexButtonsPregunta";
import RespuestaVideo from "./components/RespuestaVideo";
import ModalEditarPregunta from "./components/ModalEditarPregunta";

import propTypes from "prop-types";

function Pregunta({ array_index, datos_pregunta, setPreguntas }) {
    const {
        id_preguntas_video_cuestionario,
        pregunta,
        respuestas_video_cuestionario,
    } = datos_pregunta;

    const editarPreguntaDisclosure = useDisclosure();

    return (
        <div>
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
                        handlePress={editarPreguntaDisclosure.onOpen}
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
                        respuestas_video_cuestionario.map(
                            (respuesta, index) => (
                                <RespuestaVideo
                                    key={index}
                                    datos_respuesta={respuesta}
                                />
                            )
                        )}
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
            <ModalEditarPregunta
                isOpen={editarPreguntaDisclosure.isOpen}
                onOpenChange={editarPreguntaDisclosure.onOpenChange}
                onClose={editarPreguntaDisclosure.onClose}
                id_pregunta={id_preguntas_video_cuestionario}
                array_index={array_index}
                setPreguntas={setPreguntas}
                preguntaActual={pregunta}
            />
        </div>
    );
}

Pregunta.propTypes = {
    array_index: propTypes.number,
    datos_pregunta: propTypes.object,
    setPreguntas: propTypes.func,
};

export default Pregunta;
