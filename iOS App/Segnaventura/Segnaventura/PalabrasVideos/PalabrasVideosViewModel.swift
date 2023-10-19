//
//  PalabrasVideosViewModel.swift
//  Segnaventura
//
//  Created by David E Cavazos on 28/09/23.
//

import Foundation

class PalabraVideosViewModel : ObservableObject {
    // Estructura para deserializar el JSON
    //@Published var palabras_videos = PalabrasVideosModel()
    @Published var palabras = [PalabrasVideosModel]()
    
    
    // Funcion para leer un JSON de un API en linea y desearizarlo para poder guardarlo
    // en un objeto que se pueda luego usar en la aplicacion
    func getPalabrasVideos() async throws {
        // Guarda el URL donde esta almacenado el JSON
        guard let url = URL(string: "https://api.npoint.io/013db6c57f27144c9c04")//"http://localhost:3000/quiz/getPalabrasByQuiz/1")
                else {
                    return
                }
            
            //  Realiza un request al URL
            let urlRequest = URLRequest(url: url)
        do{
            // Obtiene los datos del request
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            // Si es que hubo un error en el request
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                print("Error: HTTP Request Failed")
                return
            }
            
            // Los datos obtenidos del API se decodifican usando la estructura en el VocabularioModel
            // Para crear un objeto de VocabularioModel
            let results = try JSONDecoder().decode([PalabrasVideosModel].self, from: data)
            DispatchQueue.main.async {
                self.palabras = results
            }
            
           
            print("Data fetched successfully")
        }
        catch {
                print("Error: \(error)")
            }
        
            
    }
}

