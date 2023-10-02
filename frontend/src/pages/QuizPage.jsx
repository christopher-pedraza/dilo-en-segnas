import { useState } from "react";
import { Dialog } from "@headlessui/react";

import Navbar from "../components/Navbar";
import Item from "../components/Item";
import ItemToggle from "../components/ItemToggle";

export default function QuizPage() {
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
            <Dialog.Panel className="flex w-full max-w-md flex-col rounded-lg bg-white p-6">
              <form>
                <label htmlFor="quizName" className="text-2xl font-bold">
                  Nombre
                </label>
                <input
                  type="text"
                  id="quizName"
                  name="quizName"
                  placeholder="Ingresa el nombre del quiz"
                  className="w-full rounded-lg border border-slate-400 p-2 my-2"
                />
                <label htmlFor="quizCategory" className="text-2xl font-bold">
                  Categoría
                  <select
                    name="quizCategory"
                    id="quizCategory"
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
                <label htmlFor="quizPalabras" className="text-2xl font-bold">
                  Palabras
                </label>
                <div className="mb-6">
                  <ItemToggle />
                  <ItemToggle />
                  <ItemToggle />
                  <ItemToggle />
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
          <h2 className="text-3xl">Quiz</h2>
          <button
            onClick={() => setIsOpen(true)}
            className="p-2 text-white rounded-md"
            style={{ background: "#8712E0" }}
          >
            Crear Quiz
          </button>
        </div>
        <div>
          <Item />
          <Item />
          <Item />
        </div>
      </div>
    </>
  );
}
