import {
  createBrowserRouter,
  createRoutesFromElements,
  Route,
  RouterProvider,
} from "react-router-dom";

import "./App.css";
import Root from "./pages/Parents/Root";
import NotFound from "./pages/Rutas/NotFound";
import CategoriesPage from "./pages/CategoriesPage";
import WordsPage from "./pages/WordsPage";
import QuizPage from "./pages/QuizPage";
import VideosPage from "./pages/VideosPage";
import VideoPartssPage from "./pages/VideoPartsPage";
import LoginPage from "./pages/LoginPage";
import SigninPage from "./pages/SigninPage";

const router = createBrowserRouter(
  createRoutesFromElements(
    <Route path="/" element={<Root />}>
      <Route index element={<LoginPage />} />
      <Route path="/login" element={<LoginPage />} />
      <Route path="/signin" element={<SigninPage />} />
      <Route path="/categories" element={<CategoriesPage />} />
      {/* <Route
          path="home"
          element={
            <ProtectedRoutes>
              <HomePage />
            </ProtectedRoutes>
          }
        />
        <Route
          path="reservacion"
          element={
            <ProtectedRoutes>
              <ReservacionSala />
            </ProtectedRoutes>
          }
        />
        <Route
          path="reservacion/confirmacion"
          element={
            <ProtectedRoutes>
              <Confirmacion />
            </ProtectedRoutes>
          }
        />
        <Route
          path="reservacion/resumen"
          element={
            <ProtectedRoutes>
              <ResumenReservacion />
            </ProtectedRoutes>
          }
        />
        <Route
          path="reservacion/equipo"
          element={
            <ProtectedRoutes>
              <SelectorEquipo />
            </ProtectedRoutes>
          }
        />
        <Route
          path="reservacion/sala"
          element={
            <ProtectedRoutes>
              <SelectorSala />
            </ProtectedRoutes>
          }
        />
         */}
      <Route path="*" element={<NotFound />} />
    </Route>
  )
);

function App() {
  return <RouterProvider router={router} />;
}

export default App;

// return (
//   <BrowserRouter>
//     <Routes>
//       <Route index element={<LoginPage />} />
//       <Route path="/login" element={<LoginPage />} />
//       <Route path="/signin" element={<SigninPage />} />
//       <Route path="/categories" element={<CategoriesPage />} />
//       <Route path="/categories/:id_category" element={<WordsPage />} />
//       <Route path="/quiz" element={<QuizPage />} />
//       <Route path="/videos" element={<VideosPage />} />
//       <Route path="/videos/:id_isla" element={<VideoPartssPage />} />
//     </Routes>
//   </BrowserRouter>
// );
