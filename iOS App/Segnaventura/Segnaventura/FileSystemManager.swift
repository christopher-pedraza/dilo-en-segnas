//
//  FileSystemManager.swift
//  Segnaventura
//
//  Created by Alumno on 07/09/23.
//

import Foundation

class FileSystemManager : ObservableObject{
    @Published var vocabularioAprendido: [String] = []
    
    var fileURL: URL = {
        let docDir = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        return docDir.appendingPathComponent("Vocabulario.plist")
    }()
    
    func save(strings: [String]) throws {
        let d = try PropertyListEncoder().encode(strings)
        try d.write(to: self.fileURL, options: [.atomic])
    }
    
    func load() throws -> [String] {
        let d = try Data(contentsOf: self.fileURL)
        return try PropertyListDecoder().decode(Array<String>.self, from: d)
    }
    
    func agregarPalabra(palabra: String) throws {
        vocabularioAprendido.append(palabra)
        try save(strings: vocabularioAprendido)
    }
    
    func quitarPalabra(palabra: String) throws {
        if let index = vocabularioAprendido.firstIndex(of: palabra) {
            vocabularioAprendido.remove(at: index)
        }
        try save(strings: vocabularioAprendido)
    }
    
}
