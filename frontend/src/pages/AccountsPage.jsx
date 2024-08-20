import { useState } from "react";
import Navbar from "../components/Navbar";

function HomePage() {
  const [users, setUsers] = useState([]);
  const [newUser, setNewUser] = useState({ username: "", password: "" });
  const [editingIndex, setEditingIndex] = useState(null);

  // Función para agregar o editar un usuario
  const handleAddOrEditUser = () => {
    if (editingIndex !== null) {
      // Editar usuario existente
      const updatedUsers = users.map((user, index) =>
        index === editingIndex ? newUser : user
      );
      setUsers(updatedUsers);
      setEditingIndex(null);
    } else {
      // Agregar nuevo usuario
      setUsers([...users, newUser]);
    }
    setNewUser({ username: "", password: "" });
  };

  // Función para seleccionar un usuario para editar
  const handleEditUser = (index) => {
    setNewUser(users[index]);
    setEditingIndex(index);
  };

  // Función para eliminar un usuario
  const handleDeleteUser = (index) => {
    const updatedUsers = users.filter((_, i) => i !== index);
    setUsers(updatedUsers);
  };

  return (
    <>
      <Navbar />
      <div className="flex flex-col items-center p-4">
        <h2 className="text-2xl font-semibold mb-4">
          Administración de Cuentas
        </h2>

        {/* Formulario para agregar/editar usuario */}
        <div className="mb-4">
          <input
            className="border p-2 mr-2"
            type="text"
            placeholder="Username"
            value={newUser.username}
            onChange={(e) =>
              setNewUser({ ...newUser, username: e.target.value })
            }
          />
          <input
            className="border p-2 mr-2"
            type="password"
            placeholder="Password"
            value={newUser.password}
            onChange={(e) =>
              setNewUser({ ...newUser, password: e.target.value })
            }
          />
          <button
            className="bg-blue-500 text-white px-4 py-2"
            onClick={handleAddOrEditUser}
          >
            {editingIndex !== null ? "Editar Usuario" : "Agregar Usuario"}
          </button>
        </div>

        {/* Lista de usuarios */}
        <div>
          <h3 className="text-xl font-semibold mb-2">Usuarios Actuales</h3>
          <ul>
            {users.map((user, index) => (
              <li key={index} className="mb-2">
                <span className="mr-4">{user.username}</span>
                <button
                  className="bg-yellow-500 text-white px-2 py-1 mr-2"
                  onClick={() => handleEditUser(index)}
                >
                  Editar
                </button>
                <button
                  className="bg-red-500 text-white px-2 py-1"
                  onClick={() => handleDeleteUser(index)}
                >
                  Eliminar
                </button>
              </li>
            ))}
          </ul>
        </div>
      </div>
    </>
  );
}

export default HomePage;
