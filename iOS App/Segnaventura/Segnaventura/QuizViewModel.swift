//
//  QuizViewModel.swift
//  Segnaventura
//
//  Created by David E Cavazos on 28/09/23.
//

import Foundation
import SwiftUI

class QuizViewModel : ObservableObject {
    // Estructura para deserializar el JSON
    @Published var examen = QuizModel()
    
    // Funcion para leer un JSON de un API en linea y desearizarlo para poder guardarlo
    // en un objeto que se pueda luego usar en la aplicacion
    func getQuizzes() async throws {
        // Guarda el URL donde esta almacenado el JSON
        guard let url = URL(string: "https://api.npoint.io/9bb0462abe5af707401e")
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
            
            // Los datos obtenidos del API se decodifican usando la estructura en el VocabularioModel
            // Para crear un objeto de VocabularioModel
            let results = try JSONDecoder().decode(QuizModel.self, from: data)
            DispatchQueue.main.async {
                self.examen = results
            }
    }
}
