//
//  AccesoViewModel.swift
//  Segnaventura
//
//  Created by Alumno on 16/10/23.
//

import Foundation
import SwiftUI

class AccesoViewModel : ObservableObject {
    // Estructura para deserializar el JSON
    @Published var accesoValido: Bool = false
    var user: String = ""
    var password: String = ""
    
    // Funcion para leer un JSON de un API en linea y desearizarlo para poder guardarlo
    // en un objeto que se pueda luego usar en la aplicacion
    func validarAcceso() async throws {
        // Guarda el URL donde esta almacenado el JSON
        // https://localhost:3000/miembros/login_app
        guard let url = URL(string: "https://api.npoint.io/a0cf4bef432c171ee4a4")
        else {
            print("Error: Invalid URL")
            return
        }
        //  Realiza un request al URL
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let body: [String: Any] = ["usuario": user, "contrasegna": password]
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        
        urlRequest.setValue("\(String(describing: jsonData?.count))", forHTTPHeaderField: "Content-Length")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = jsonData
        
        // Obtiene los datos del request
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        // Si es que hubo un error en el request
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            print("Error: HTTP Request Failed")
            return
        }
        
        // Los datos obtenidos del API se decodifican usando la estructura en el Model
        let results = try JSONDecoder().decode(accesoModel.self, from: data)
        DispatchQueue.main.async {
            self.accesoValido = results.tiene_acceso
            print(results)
        }
    }
}

struct accesoModel: Codable {
    var tiene_acceso: Bool = false
    
    enum CodingKeys: CodingKey {
        case tiene_acceso
    }
}
