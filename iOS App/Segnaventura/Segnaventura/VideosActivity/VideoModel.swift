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
    var nombre : String = ""
    var cantidadPartes : Int = 0
    var partes : [Partes] = [Partes]()
    
    enum CodingKeys : String, CodingKey {
        case nombre
        case cantidadPartes = "_count"
        case partes = "parte_video_cuestionario"
    }
}

// Partes de cada actividad
struct Partes : Decodable, Identifiable {
    var id = UUID()
    var nombre : String = ""
    var url_video : String = ""
    var preguntas : [Pregunta] = [Pregunta]()
    
    enum CodingKeys : String, CodingKey {
        case nombre
        case url_video
        case preguntas = "preguntas_video_cuestionario"
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
        case cantidadCorrectas = "_count"
        case respuestas = "respuestas_video_cuestionario"
    }
}

// Respuestas
struct Respuesta : Decodable, Identifiable, Hashable {
    var id = UUID()
    var respuesta : String = ""
    var es_correcta : Bool = false
    
    enum CodingKeys : String, CodingKey {
        case respuesta
        case es_correcta
    }
}
