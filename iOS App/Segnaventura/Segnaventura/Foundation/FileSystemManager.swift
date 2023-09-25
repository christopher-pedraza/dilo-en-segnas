//
//  FileSystemManager.swift
//  Segnaventura
//
//  Christopher Pedraza Pohlenz
//

import Foundation

// Objeto para leer y guardar una lista de strings en los archivos del sistema
class FileSystemManager : ObservableObject{
    // Vocabulario que se lee de los archivos del sistema
    @Published var vocabularioAprendido: [String] = []
    
    // Obtiene el URL de los documentos de la aplicacion para poder ubicar el archivo donde se guardan
    // los datos
    var fileURL: URL = {
        let docDir = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        return docDir.appendingPathComponent("Vocabulario.plist")
    }()
    
    // Guarda un arreglo de strings en el archivo
    func save(strings: [String]) throws {
        // Codifica un arreglo de Strings en una propertyList
        let d = try PropertyListEncoder().encode(strings)
        // Guarda en el URL del archivo la propertyList
        // El atributo atomic es importante porque va a asegurarse que todos los datos se escriban juntos.
        // Si no estuviera, podrian estarse escribiendo cuando una funcion accede al archivo y leeria solo
        // una parte actualizada
        try d.write(to: self.fileURL, options: [.atomic])
    }
    
    // Carga los datos del archivo a un arreglo de strings
    func load() throws -> [String] {
        // Obtiene los datos del URL del archivo
        let d = try Data(contentsOf: self.fileURL)
        // Decodifica la propertyList como un arreglo de Strings a partir de los datos leidos del archivo
        return try PropertyListDecoder().decode(Array<String>.self, from: d)
    }
    
    // Funcion para agregar una palabra al arreglo de strings y llamar a la funcion para escribir en el
    // archivo
    func agregarPalabra(palabra: String) throws {
        // Agregar la palabra recibida al arreglo
        vocabularioAprendido.append(palabra)
        // Pasa el arreglo actualizado a la funcion para escribir en el archivo
        try save(strings: vocabularioAprendido)
    }
    
    // Funcion para eliminar una palabra al arreglo de strings y llamar a la funcion para escribir en el
    // archivo
    func quitarPalabra(palabra: String) throws {
        // Obtiene el indice en el arreglo de la palabra que se desea eliminar
        if let index = vocabularioAprendido.firstIndex(of: palabra) {
            // Se elimina del arreglo el elemento en el indice encontrado
            vocabularioAprendido.remove(at: index)
        }
        // Pasa el arreglo actualizado a la funcion para escribir en el archivo
        try save(strings: vocabularioAprendido)
    }
}
