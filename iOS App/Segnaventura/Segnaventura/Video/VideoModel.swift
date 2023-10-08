//
//  VideoModel.swift
//  Segnaventura
//
//  Created by Christopher Pedraza
//

import Foundation

// Modelo general para la actividad de videos
struct VideoModel : Decodable, Identifiable {
    var id = UUID()
    var titulo : String = ""
    var cantidadPartes : Int = 0
    var correctas : Int = 0
    var partes : [Partes] = [Partes]()
    
    enum CodingKeys : String, CodingKey {
        case titulo
        case cantidadPartes
        case correctas
        case partes
    }
}

// Partes de cada actividad
struct Partes : Decodable, Identifiable {
    var id = UUID()
    var titulo : String = ""
    var idVideo : String = ""
    var preguntas : [Pregunta] = [Pregunta]()
    
    enum CodingKeys : String, CodingKey {
        case titulo
        case idVideo
        case preguntas
    }
}

// Preguntas
struct Pregunta : Decodable, Identifiable, Hashable {
    var id = UUID()
    var pregunta : String = ""
    var cantidadCorrectas = 0
    var respuestas : [Respuesta] = [Respuesta]()
    
    enum CodingKeys : String, CodingKey {
        case pregunta
        case cantidadCorrectas
        case respuestas
    }
}

// Respuestas
struct Respuesta : Decodable, Identifiable, Hashable {
    var id = UUID()
    var respuesta : String = ""
    var esCorrecta : Bool = false
    
    enum CodingKeys : String, CodingKey {
        case respuesta
        case esCorrecta
    }
}
