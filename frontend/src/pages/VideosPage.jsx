import { useState } from "react";
import { Dialog } from "@headlessui/react";

import Navbar from "../components/Navbar";
import ItemVideos from "../components/ItemVideos";
import VideoPart from "../components/VideoPart";

export default function VideosPage() {
  let [isOpen, setIsOpen] = useState(false);

  return (
    <>
      <Dialog open={isOpen} onClose={() => setIsOpen(false)}>
        <Dialog open={isOpen} onClose={() => setIsOpen(false)}>
          {/* The backdrop, rendered as a fixed sibling to the panel container */}
          <div className="fixed inset-0 bg-black/30" aria-hidden="true" />

          {/* Full-screen container to center the panel */}
          <div className="fixed inset-0 grid place-items-center ">
            {/* The actual dialog panel  */}
            <Dialog.Panel
              className="flex w-full max-w-lg flex-col rounded-lg bg-white p-6 overflow-y-scroll"
              style={{ maxHeight: 480 }}
            >
              <form>
                <label htmlFor="clipName" className="text-2xl font-bold">
                  Nombre
                </label>
                <input
                  type="text"
                  id="clipName"
                  name="clipName"
                  placeholder="Ingresa el título del clip"
                  className="w-full rounded-lg border border-slate-400 p-2 my-2"
                />
                <label htmlFor="clipCategory" className="text-2xl font-bold">
                  Categoría
                  <select
                    name="clipCategory"
                    id="clipCategory"
                    defaultValue="default"
                    className="w-full rounded-lg border border-slate-400 p-2 my-2 text-base font-normal inactive"
                  >
                    <option value="default" disabled>
                      --- Selecciona una categoria ---
                    </option>
                    <option value="comidas">Comidas</option>
                    <option value="naturaleza">Naturaleza</option>
                    <option value="colores">Colores</option>
                  </select>
                </label>
                <label htmlFor="clipWord" className="text-2xl font-bold">
                  Palabra
                  <select
                    name="clipWord"
                    id="clipWord"
                    defaultValue="default"
                    className="w-full rounded-lg border border-slate-400 p-2 my-2 text-base font-normal inactive"
                  >
                    <option value="default" disabled>
                      --- Selecciona una palabra ---
                    </option>
                    <option value="manzana">Manzana</option>
                    <option value="platano">Plátano</option>
                    <option value="fresa">Fresa</option>
                  </select>
                </label>
                <label htmlFor="clipParts" className="text-2xl font-bold">
                  Cantidad de partes
                </label>
                <input
                  type="number"
                  id="clipParts"
                  name="clipParts"
                  placeholder="Ingresa la cantidad de partes que tendrá el clip"
                  className="w-full rounded-lg border border-slate-400 p-2 my-2"
                />
                <div>
                  <VideoPart />
                  <VideoPart />
                </div>
                <div className="flex items-center justify-end mt-1">
                  <button
                    className="rounded-lg border border-slate-400 bg-black px-4 py-2 text-white ml-2"
                    onClick={() => setIsOpen(false)}
                  >
                    Cancelar
                  </button>
                  <button
                    className="rounded-lg border border-slate-400 px-4 py-2 text-white ml-2"
                    style={{ background: "#8712E0" }}
                    type="submit"
                    onClick={() => setIsOpen(false)}
                  >
                    Crear
                  </button>
                </div>
              </form>
            </Dialog.Panel>
          </div>
        </Dialog>
        ;
      </Dialog>

      <Navbar />
      <div className="max-w-3xl m-auto p-8">
        <div className="flex items-center justify-between">
          <h2 className="text-3xl">Videos</h2>
          <button
            onClick={() => setIsOpen(true)}
            className="p-2 text-white rounded-md"
            style={{ background: "#8712E0" }}
          >
            Crear Video
          </button>
        </div>
        <div>
          <ItemVideos />
          <ItemVideos />
          <ItemVideos />
        </div>
      </div>
    </>
  );
}
