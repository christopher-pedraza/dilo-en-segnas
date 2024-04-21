import Navbar from "../components/Navbar";
import { useParams } from "react-router-dom";

function NewActividadVideo() {
    // Get the id from the URL
    const { id_isla } = useParams();
    console.log(id_isla);

    return (
        <div>
            <Navbar />
            <div className="max-w-3xl m-auto p-8">
                <div className="flex items-center justify-between">
                    <h2 className="text-3xl">Actividad de Videos</h2>
                    <button
                        className="p-2 text-white rounded-md"
                        style={{ background: "#8712E0" }}
                    >
                        Agregar Parte
                    </button>
                </div>
                <div></div>
            </div>
        </div>
    );
}

export default NewActividadVideo;
