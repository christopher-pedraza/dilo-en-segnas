//
//  VocabularioModel.swift
//  Segnaventura
//
//  Christopher Pedraza Pohlenz
//

import Foundation

// Modelo general que contiene una lista de las categorias del vocabulario
struct VocabularioModel : Decodable, Identifiable {
    var id = UUID()
    var categorias : [Categorias] = [Categorias]()
    
    enum CodingKeys : String, CodingKey {
        case categorias
    }
    
}

// Categorias del vocabulario.
// Identificado por su id y nombre
// Contiene a su vez una lista de vocabulario
struct Categorias: Decodable, Identifiable {
    var id = UUID()
    var id_categoria : String = ""
    var nombre_categoria : String = ""
    var vocabulario : [Vocabulario] = [Vocabulario]()
    
    enum CodingKeys : String, CodingKey {
        case id_categoria
        case nombre_categoria
        case vocabulario
    }
}

// Vocabulario
// Identificado por su id
// Contiene otros datos como la palabra en espagnol, y los urls al audio, video e imagen
struct Vocabulario: Decodable, Identifiable {
    var id = UUID()
    var id_palabra : String = ""
    var palabra_espagnol : String = ""
    var url_audio : String = ""
    var id_video : String = ""
    var url_imagen : String = ""
    
    enum CodingKeys : String, CodingKey {
        case id_palabra
        case palabra_espagnol
        case url_audio
        case id_video
        case url_imagen
    }
}
