import { BrowserRouter, Routes, Route } from "react-router-dom";

import "./App.css";
import CategoriesPage from "./pages/CategoriesPage";
import WordsPage from "./pages/WordsPage";
import QuizPage from "./pages/QuizPage";
import VideosPage from "./pages/VideosPage";
import VideoPartssPage from "./pages/VideoPartsPage";

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route index element={<CategoriesPage />} />
        <Route path="/categories" element={<CategoriesPage />} />
        <Route path="/categories/:id_category" element={<WordsPage />} />
        <Route path="/quiz" element={<QuizPage />} />
        <Route path="/videos" element={<VideosPage />} />
        <Route path="/videos/:id_isla" element={<VideoPartssPage />} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;
