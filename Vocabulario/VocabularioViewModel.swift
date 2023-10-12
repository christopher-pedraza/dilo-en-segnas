//
//  VocabularioViewModel.swift
//  Segnaventura
//
//  Christopher Pedraza Pohlenz
//

import Foundation
import SwiftUI

class VocabularioViewModel : ObservableObject {
    // Estructura para deserializar el JSON
    @Published var vocabulario = VocabularioModel()
    
    // Funcion para leer un JSON de un API en linea y desearizarlo para poder guardarlo
    // en un objeto que se pueda luego usar en la aplicacion
    func getVocabularioData() async throws {

        // Guarda el URL donde esta almacenado el JSON
        guard let url = URL(string: "http://localhost:3000/categorias/getAllWithPalabras")
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
            let results = try JSONDecoder().decode(VocabularioModel.self, from: data)
            DispatchQueue.main.async {
                self.vocabulario = results
            }
    }
}
