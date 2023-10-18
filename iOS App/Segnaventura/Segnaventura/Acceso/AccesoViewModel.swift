//
//  AccesoViewModel.swift
//  Segnaventura
//
//  Created by Alumno on 16/10/23.
//

import Foundation
import SwiftUI
import ActionButton
import Combine

@MainActor
class AccesoViewModel : ObservableObject {
    // Estructura para deserializar el JSON
    @Published var accesoValido: Bool = false
    @Published var user: String = ""
    @Published var password: String = ""
    @Published var buttonState: ActionButtonState = .disabled(title: "Llena todos los campos!", systemImage: "exclamationmark.circle")
    
    private var cancellables: Set<AnyCancellable> = []
    
    private var userIsValidPublisher: AnyPublisher<Bool, Never> {
        $user
            .map { value in
                !value.isEmpty
            }
            .eraseToAnyPublisher()
    }
    
    private var passwordIsValidPublisher: AnyPublisher<Bool, Never> {
        $password
            .map { value in
                !value.isEmpty
            }
            .eraseToAnyPublisher()
    }
    
    init() {
        userIsValidPublisher
            .combineLatest(passwordIsValidPublisher)
            .map { val1, val2 in
                val1 && val2
            }
            .map { fieldsValid -> ActionButtonState in
                if fieldsValid {
                    return .enabled(title: "Acceder", systemImage: "checkmark.circle")
                }
                return .disabled(title: "Llena todos los campos!", systemImage: "exclamationmark.circle")
            }
            .assign(to: \.buttonState, on: self)
            .store(in: &cancellables)
    }
    
    func validarAcceso() async throws {
        buttonState = .loading(title: "Procesando", systemImage: "person")
        
        // https://localhost:3000/miembros/login_app
        guard let url = URL(string: "https://api.npoint.io/b46d652b7819266d5f48")
        else {
            print("Error: Invalid URL")
            return
        }
        var urlRequest = URLRequest(url: url)
        
        /*
        urlRequest.httpMethod = "POST"
        
        let body: [String: Any] = ["usuario": user, "contrasegna": password]
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        
        urlRequest.setValue("\(String(describing: jsonData?.count))", forHTTPHeaderField: "Content-Length")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = jsonData
         */
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            print("Error: HTTP Request Failed")
            return
        }
        
        let results = try JSONDecoder().decode(accesoModel.self, from: data)
        DispatchQueue.main.async {
            self.accesoValido = results.tiene_acceso
            self.buttonState = .enabled(title: "Acceder", systemImage: "checkmark.circle")
        }
        
    }
}

struct accesoModel: Decodable {
    var tiene_acceso: Bool = false
    
    enum CodingKeys: CodingKey {
        case tiene_acceso
    }
}
