import logo from "../assets/logo.png";
import { NavLink } from "react-router-dom";

export default function Navbar() {
  return (
    <nav
      className="flex items-center justify-between bg-black p-5"
      style={{ background: "#080945" }}
    >
      <div className="flex items-center">
        <NavLink
          to="/home"
          className="flex items-center text-white text-4xl font-bold"
        >
          <img
            src={logo}
            alt="Logo Dilo en señas"
            width="60"
            height="60"
            className="mr-4"
          />
          <p className="text-4xl font-bold text-white">Dilo en Señas</p>
        </NavLink>
      </div>

      <div className="flex">
        <div className="mx-4">
          <NavLink
            to="/accounts"
            className="text-white text-xl hover:text-gray-300 hover:underline"
          >
            Cuentas
          </NavLink>
        </div>
      </div>
    </nav>
  );
}
