import { BrowserRouter, Routes, Route } from "react-router-dom";

import "./App.css";
import CategoriesPage from "./pages/CategoriesPage";
import WordsPage from "./pages/WordsPage";

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route index element={<CategoriesPage />} />
        <Route path="/categories" element={<CategoriesPage />} />
        <Route path="/categories/:id_category" element={<WordsPage />} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;
