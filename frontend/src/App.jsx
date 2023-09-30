import { BrowserRouter, Routes, Route } from "react-router-dom";

import "./App.css";
import CategoriesPage from "./pages/CategoriesPage";
import WordsPage from "./pages/WordsPage";
import QuizPage from "./pages/QuizPage";

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route index element={<CategoriesPage />} />
        <Route path="/categories" element={<CategoriesPage />} />
        <Route path="/categories/:id_category" element={<WordsPage />} />
        <Route path="/quiz" element={<QuizPage />} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;
