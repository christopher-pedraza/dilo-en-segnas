import {
    createBrowserRouter,
    createRoutesFromElements,
    Route,
    RouterProvider,
} from "react-router-dom";

import "./App.css";
import Root from "./pages/Parents/Root";
import NotFound from "./pages/Rutas/NotFound";
import ProtectedRoutes from "./pages/Rutas/ProtectedRoutes";
import CategoriesPage from "./pages/CategoriesPage";
import WordsPage from "./pages/WordsPage";
import QuizPage from "./pages/QuizPage";
import ActividadVideo from "./pages/NewActividadVideo";
import ParteVideo from "./pages/ParteVideo";
import LoginPage from "./pages/LoginPage";
import SigninPage from "./pages/SigninPage";
import Niveles from "./pages/Niveles";

function secured(Component) {
    return function WrappedComponent(props) {
        return (
            <ProtectedRoutes>
                <Component {...props} />
            </ProtectedRoutes>
        );
    };
}

const router = createBrowserRouter(
    createRoutesFromElements(
        <Route path="/" element={<Root />}>
            <Route index element={<LoginPage />} />
            <Route path="login" element={<LoginPage />} />
            <Route path="signin" element={<SigninPage />} />
            <Route path="categories" element={secured(CategoriesPage)()} />
            <Route
                path="categories/:id_category"
                element={secured(WordsPage)()}
            />
            <Route path="quiz" element={secured(QuizPage)()} />
            <Route
                path="videos/:id_nivel"
                element={secured(ActividadVideo)()}
            />
            <Route
                path="videos/:id_nivel/parte/:id_parte"
                element={secured(ParteVideo)()}
            />
            {/* <Route
                path="videos/:id_isla"
                element={secured(VideoPartssPage)()}
            /> */}
            <Route path="niveles" element={secured(Niveles)()} />
            <Route path="*" element={<NotFound />} />
        </Route>
    )
);

function App() {
    return <RouterProvider router={router} />;
}

export default App;
