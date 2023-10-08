/* eslint-disable react/prop-types */
import { useState } from "react";
import { Switch } from "@headlessui/react";

export default function ItemToggle({ data, onToggle }) {
  const [enabled, setEnabled] = useState(false);

  const handleToggle = () => {
    setEnabled(!enabled); // Invertir el valor de enabled
    // Llamar a la función proporcionada por el padre y pasar la palabra y el estado actual
    onToggle(data.id_palabra, !enabled);
  };

  return (
    <div className="flex items-center justify-between w-full rounded-lg border border-slate-400 p-2 my-2">
      <h3 className="text-xl">{data.palabra}</h3>
      <div className="flex items-center">
        <Switch
          checked={enabled}
          onChange={handleToggle}
          style={{
            backgroundColor: enabled ? "#8712E0" : "#CBD5E0", // Reemplaza con tu código hexadecimal
          }}
          className="relative inline-flex h-6 w-11 items-center rounded-full"
        >
          <span className="sr-only">Enable Item</span>
          <span
            className={`${
              enabled ? "translate-x-6" : "translate-x-1"
            } inline-block h-4 w-4 transform rounded-full bg-white transition`}
          />
        </Switch>
      </div>
    </div>
  );
}
