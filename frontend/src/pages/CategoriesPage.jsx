import Navbar from "../components/Navbar";
import Item from "../components/Item";

export default function CategoriesPage() {
  const handleNewCategoryClick = () => {
    console.log("Button clicked for creating a new category");
  };

  return (
    <>
      <Navbar />
      <div className="max-w-3xl m-auto p-8">
        <div className="flex items-center justify-between">
          <h2 className="text-3xl">Categorías</h2>
          <button
            onClick={handleNewCategoryClick}
            className="p-2 text-white rounded-md"
            style={{ background: "#8712E0" }}
          >
            Crear Categoría
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
