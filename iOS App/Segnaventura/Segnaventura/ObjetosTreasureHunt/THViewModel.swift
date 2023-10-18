//
//  THViewModel.swift
//  Segnaventura
//
//

import Foundation
import SwiftUI

class THViewModel : ObservableObject {
    // Estructura para deserializar el JSON
    @Published var palabras = [THModel]()
//    var id_treasure_hunt = 1
    
    // Funcion para leer un JSON de un API en linea y desearizarlo para poder guardarlo
    // en un objeto que se pueda luego usar en la aplicacion
    func getObjetoData() async throws {

        // Guarda el URL donde esta almacenado el JSON
//        guard let url = URL(string: "http://localhost:3000/treasure/getPalabrasByActividad/\(id_treasure_hunt)")
        guard let url = URL(string: "https://api.npoint.io/9f74e98fd247a194639b")
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
            let results = try JSONDecoder().decode([THModel].self, from: data)
            print(results)
            DispatchQueue.main.async {
                self.palabras = results
            }
    }
}
