//
//  ProgresoViewModel.swift
//  Segnaventura
//
//  Created by Adrián Alejandro Ramírez Cruz on 17/10/23.
//

import Foundation
import SwiftUI

class ProgresoViewModel : ObservableObject {
    // Estructura para deserializar el JSON
    @Published var progreso = [ProgresoModel]()
    var id_progreso = 1
    
    // Funcion para leer un JSON de un API en linea y desearizarlo para poder guardarlo en un objeto que se pueda luego usar en la aplicacion
    
    func getProgresoData() async throws {
        // Guarda el URL donde esta almacenado el JSON
        guard let url = URL(string: "localhost:3000/progreso/get_data_islas_descubiertas/\(id_progreso)")
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
        // Para crear un objeto de ProgresoModel
        let results = try JSONDecoder().decode([ProgresoModel].self, from: data)
        print(results)
        DispatchQueue.main.async {
            self.progreso = results
        }
        
    }
}
