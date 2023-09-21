//
//  VideoViewModel.swift
//  Segnaventura
//
//  Christopher Pedraza Pohlenz
//

import Foundation
import SwiftUI

class VideoViewModel : ObservableObject {
    // Estructura para deserializar el JSON
    @Published var videos = VideoModel()
    // Variable para checar si ya se acabo de cargar los datos de la API
    @Published var isLoading = false
    
    // Funcion para leer un JSON de un API en linea y desearizarlo para poder guardarlo
    // en un objeto que se pueda luego usar en la aplicacion
    func getVideosData() async throws {
        // Guarda el URL donde esta almacenado el JSON
        guard let url = URL(string: "https://api.npoint.io/f1594ddf5377c0be680a")
                else {
                    print("Error: Invalid URL")
                    return
                }
            
            //  Realiza un request al URL
            let urlRequest = URLRequest(url: url)
            // Obtiene los datos del request
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            // Si es que hubo un error en el request
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                print("Error: HTTP Request Failed")
                return
            }
            
            // Los datos obtenidos del API se decodifican usando la estructura en el VideoModel
            // Para crear un objeto de VideoModel
            let results = try JSONDecoder().decode(VideoModel.self, from: data)
            DispatchQueue.main.async {
                print(results)
                self.videos = results
            }
    }
}
