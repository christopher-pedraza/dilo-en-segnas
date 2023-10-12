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
    var cantidadPartes : CantidadPartes = CantidadPartes()
    var partes : [Partes] = [Partes]()
    
    enum CodingKeys : String, CodingKey {
        case nombre
        case cantidadPartes = "_count"
        case partes = "parte_video_cuestionario"
    }
}

struct CantidadPartes : Decodable, Identifiable {
    var id = UUID()
    var parte_video_cuestionario: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case parte_video_cuestionario
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
struct Pregunta : Decodable, Identifiable {
    var id = UUID()
    var pregunta : String = ""
    var cantidadCorrectas: CantidadCorrectas = CantidadCorrectas()
    var respuestas : [Respuesta] = [Respuesta]()
    
    enum CodingKeys : String, CodingKey {
        case pregunta
        case cantidadCorrectas = "_count"
        case respuestas = "respuestas_video_cuestionario"
    }
}

struct CantidadCorrectas : Decodable, Identifiable {
    var id = UUID()
    var respuestas_video_cuestionario: Int = 0
    
    enum CodingKeys : String, CodingKey {
        case respuestas_video_cuestionario
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
