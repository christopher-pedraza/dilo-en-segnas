import { useState } from "react";
import { Switch } from "@headlessui/react";

export default function ItemToggle() {
  const [enabled, setEnabled] = useState(false);

  return (
    <div className="flex items-center justify-between w-full rounded-lg border border-slate-400 p-2 my-2">
      <h3 className="text-xl">Item</h3>
      <div className="flex items-center">
        <Switch
          checked={enabled}
          onChange={setEnabled}
          style={{
            backgroundColor: enabled ? "#8712E0" : "#CBD5E0", // Reemplaza con tu código hexadecimal
          }}
          className="relative inline-flex h-6 w-11 items-center rounded-full"
        >
          <span className="sr-only">Enable notifications</span>
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
