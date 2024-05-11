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

import propTypes from "prop-types";

function Pregunta() {
    return (
        <Card>
            <CardHeader className="flex items-center">
                {/* <Card
                    fullWidth
                    shadow="none"
                    isPressable
                    onPress={() => {
                        alert("Hola");
                    }}
                    disableAnimation
                    disableRipple
                > */}
                <Input
                    label="Pregunta"
                    isReadOnly
                    value="Crees que deberia"
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
            {/* <Divider /> */}
            <CardBody>
                <div className="flex items-center">
                    <Checkbox
                        color="success"
                        radius="full"
                        isSelected={true}
                        isReadOnly
                    />
                    <Input
                        label="Respuesta"
                        isReadOnly
                        value="Si"
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

export default Pregunta;
