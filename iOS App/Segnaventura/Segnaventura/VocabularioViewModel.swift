//
//  VocabularioViewModel.swift
//  Segnaventura
//
//  Created by Alumno on 05/09/23.
//

import Foundation
import SwiftUI

class VocabularioViewModel : ObservableObject {
    @Published var vocabulario = VocabularioModel()
    
    func getVocabularioData() async throws {
        guard let url = URL(string: "https://jsonkeeper.com/b/E6FK")
                else {
                    print("Error: Invalid URL")
                    return
                }
            
            let urlRequest = URLRequest(url: url)
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                print("Error: HTTP Request Failed")
                return
            }

            let results = try JSONDecoder().decode(VocabularioModel.self, from: data)
            
            DispatchQueue.main.async {
                self.vocabulario = results
            }
    }
}
