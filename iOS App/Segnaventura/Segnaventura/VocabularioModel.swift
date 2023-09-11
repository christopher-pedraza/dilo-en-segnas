//
//  VocabularioModel.swift
//  Segnaventura
//
//  Created by Alumno on 05/09/23.
//

import Foundation

struct VocabularioModel : Decodable, Identifiable {
    var id = UUID()
    var categorias : [Categorias] = [Categorias]()
    
    enum CodingKeys : String, CodingKey {
        case categorias
    }
    
}

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

struct Vocabulario: Decodable, Identifiable {
    var id = UUID()
    var id_palabra : String = ""
    var palabra_espagnol : String = ""
    var url_audio : String = ""
    var url_video : String = ""
    var url_imagen : String = ""
    
    enum CodingKeys : String, CodingKey {
        case id_palabra
        case palabra_espagnol
        case url_audio
        case url_video
        case url_imagen
    }
}
