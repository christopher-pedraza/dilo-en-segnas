//
//  VideoModel.swift
//  Segnaventura
//
//  Created by Christopher Pedraza
//

import Foundation

// Modelo general que contiene una lista de las categorias del vocabulario
struct VideoModel : Decodable, Identifiable {
    var id = UUID()
    var cantidadPartes : Int = 0
    var partes : [Partes] = [Partes]()
    
    enum CodingKeys : String, CodingKey {
        case cantidadPartes
        case partes
    }
}

struct Partes : Decodable, Identifiable {
    var id = UUID()
    var titulo : String = ""
    var urlVideo : String = ""
    var preguntas : [Pregunta] = [Pregunta]()
    
    enum CodingKeys : String, CodingKey {
        case titulo
        case urlVideo
        case preguntas
    }
}

struct Pregunta : Decodable, Identifiable {
    var id = UUID()
    var pregunta : String = ""
    var respuestas : [Respuesta] = [Respuesta]()
    
    enum CodingKeys : String, CodingKey {
        case pregunta
        case respuestas
    }
}

struct Respuesta : Decodable, Identifiable {
    var id = UUID()
    var respuesta : String = ""
    
    enum CodingKeys : String, CodingKey {
        case respuesta
    }
}
