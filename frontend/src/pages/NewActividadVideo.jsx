import Navbar from "../components/Navbar";
import { useParams } from "react-router-dom";
import { useSelector } from "react-redux";
import { selectNivel } from "src/redux/Slices/nivelSlice";
import { useEffect, useState } from "react";
import { get } from "src/utils/ApiRequests";

// Fontawesome icons
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
// Trash icon
import { faTrash } from "@fortawesome/free-solid-svg-icons";
// Pencil icon
import { faPencilAlt } from "@fortawesome/free-solid-svg-icons";
// Plus icon
import { faPlus } from "@fortawesome/free-solid-svg-icons";

// Nextui components
import { Button } from "@nextui-org/react";

function NewActividadVideo() {
    const nivel = useSelector(selectNivel);
    const [partes, setPartes] = useState([]);

    useEffect(() => {
        get(`partesVideo/getByNivel/${nivel}`).then((data) => {
            console.log(data);
            setPartes(data);
        });
    }, [nivel]);

    const handleEdit = (id_parte) => {
        console.log("Editando: ", id_parte);
    };

    const handleDelete = (id_parte) => {
        console.log("Eliminando: ", id_parte);
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
        </div>
    );
}

export default NewActividadVideo;
