import { useState, useEffect } from "react";
import Navbar from "../components/Navbar";

function AccountsPage() {
  const [users, setUsers] = useState([]);
  const [newUser, setNewUser] = useState({ usuario: "", contrasegna: "" });
  const [editingUserId, setEditingUserId] = useState(null);

  // Función para obtener todos los usuarios de la API
  const fetchUsers = async () => {
    try {
      const response = await fetch("http://localhost:3000/miembro/");
      if (!response.ok) {
        throw new Error("Error al obtener los usuarios.");
      }
      const data = await response.json();
      setUsers(data);
    } catch (error) {
      alert(error.message); // Mostrar el error en una alerta del navegador
    }
  };

  useEffect(() => {
    // Llamada inicial para obtener los usuarios
    fetchUsers();
  }, []);

  // Función para agregar un nuevo usuario
  const handleAddUser = async () => {
    try {
      const response = await fetch("http://localhost:3000/miembro/registro", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(newUser),
      });

      if (!response.ok) {
        throw new Error("Error al agregar el usuario.");
      }

      fetchUsers(); // Volvemos a obtener los usuarios después de agregar uno nuevo
      setNewUser({ usuario: "", contrasegna: "" });
    } catch (error) {
      alert(error.message); // Mostrar el error en una alerta del navegador
    }
  };

  // Función para editar un usuario
  const handleEditUser = async () => {
    if (editingUserId === null) return;

    try {
      const response = await fetch(
        `http://localhost:3000/miembro/${editingUserId}`,
        {
          method: "PUT",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify(newUser),
        }
      );

      if (!response.ok) {
        throw new Error("Error al editar el usuario.");
      }

      fetchUsers(); // Volvemos a obtener los usuarios después de la edición
      setNewUser({ usuario: "", contrasegna: "" });
      setEditingUserId(null);
    } catch (error) {
      alert(error.message); // Mostrar el error en una alerta del navegador
    }
  };

  // Función para seleccionar un usuario para editar
  const startEditUser = (user) => {
    setNewUser({ usuario: user.usuario, contrasegna: "" });
    setEditingUserId(user.id_miembro);
  };

  // Función para eliminar un usuario
  const handleDeleteUser = async (id_miembro) => {
    try {
      const response = await fetch(
        `http://localhost:3000/miembro/${id_miembro}`,
        {
          method: "DELETE",
        }
      );

      if (!response.ok) {
        throw new Error("Error al eliminar el usuario.");
      }

      fetchUsers(); // Volvemos a obtener los usuarios después de la eliminación
    } catch (error) {
      alert(error.message); // Mostrar el error en una alerta del navegador
    }
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
            placeholder="Usuario"
            value={newUser.usuario}
            onChange={(e) =>
              setNewUser({ ...newUser, usuario: e.target.value })
            }
          />
          <input
            className="border p-2 mr-2"
            type="password"
            placeholder="Contraseña"
            value={newUser.contrasegna}
            onChange={(e) =>
              setNewUser({ ...newUser, contrasegna: e.target.value })
            }
          />
          <button
            className="bg-blue-500 text-white px-4 py-2"
            onClick={editingUserId !== null ? handleEditUser : handleAddUser}
          >
            {editingUserId !== null ? "Editar Usuario" : "Agregar Usuario"}
          </button>
        </div>

        {/* Lista de usuarios */}
        <div className="w-full max-w-3xl">
          <h3 className="text-xl font-semibold mb-2">Usuarios Actuales</h3>
          <ul>
            {users.map((user) => (
              <li
                key={user.id_miembro}
                className="grid grid-cols-12 gap-4 items-center mb-2"
              >
                <span className="col-span-6 truncate">{user.usuario}</span>
                <button
                  className="col-span-3 bg-yellow-500 text-white px-2 py-1"
                  onClick={() => startEditUser(user)}
                >
                  Editar
                </button>
                <button
                  className="col-span-3 bg-red-500 text-white px-2 py-1"
                  onClick={() => handleDeleteUser(user.id_miembro)}
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

export default AccountsPage;
