import logo from "../assets/logo.png";

export default function Navbar() {
  return (
    <nav
      className="flex items-center justify-between bg-black p-5"
      style={{ background: "#080945" }}
    >
      <div className="flex items-center">
        <img
          src={logo}
          alt="Logo Dilo en señas"
          width="60"
          height="60"
          className="mr-4"
        />
        <p className="text-4xl font-bold text-white">Dilo en Señas</p>
      </div>

      <div className="flex">
        <div className="mx-4">
          <a
            href="/categories"
            className="text-white text-xl hover:text-gray-300 hover:underline"
          >
            Categorías
          </a>
        </div>
        <div className="mx-4">
          <a
            href="/quiz"
            className="text-white text-xl hover:text-gray-300 hover:underline"
          >
            Quiz
          </a>
        </div>
        <div className="mx-4">
          <a
            href="/clips"
            className="text-white text-xl hover:text-gray-300 hover:underline"
          >
            Clips
          </a>
        </div>
      </div>
    </nav>
  );
}
