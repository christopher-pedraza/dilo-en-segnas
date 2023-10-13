import { useState } from "react";
import NavbarLogin from "../components/NavbarLogin";

export default function LoginPage() {
  // Estado para controlar los valores del formulario de inicio de sesión
  const [loginData, setLoginData] = useState({
    username: "",
    password: "",
  });

  // Destructuring del loginData
  const { username, password } = loginData;

  // Función que se ejecuta cada vez que se cambia el valor de un input
  const handleChange = (e) => {
    setLoginData({ ...loginData, [e.target.name]: e.target.value });
  };

  // Función que se ejecuta cuando se da click en el botón de Iniciar Sesión
  const handleLogin = (e) => {
    e.preventDefault();
    // Aquí eventualmente agregaríamos la lógica para conectar con la API y autenticar al usuario
    console.log("Iniciando sesión con:", loginData);
  };

  return (
    <>
      <NavbarLogin />

      <div className="max-w-lg m-auto p-8 mt-20">
        <h2 className="text-3xl mb-4 text-center">Iniciar Sesión</h2>

        <form>
          <label htmlFor="username" className="block text-lg font-bold mb-2">
            Usuario
          </label>
          <input
            type="text"
            id="username"
            name="username"
            placeholder="Ingresa tu usuario"
            className="w-full rounded-lg border border-slate-400 p-2 my-2"
            value={username}
            onChange={handleChange}
          />

          <label htmlFor="password" className="block text-lg font-bold mb-2">
            Contraseña
          </label>
          <input
            type="password"
            id="password"
            name="password"
            placeholder="Ingresa tu contraseña"
            className="w-full rounded-lg border border-slate-400 p-2 my-2"
            value={password}
            onChange={handleChange}
          />

          <div className="flex items-center justify-center mt-4">
            <button
              className="rounded-lg border border-slate-400 px-4 py-2 text-white w-full transform hover:scale-105 hover:text-gray-300"
              style={{ background: "#8712E0" }}
              type="submit"
              onClick={handleLogin}
            >
              Iniciar Sesión
            </button>
          </div>
        </form>
      </div>
    </>
  );
}
