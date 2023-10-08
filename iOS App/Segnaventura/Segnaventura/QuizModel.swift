//
//  VocabularioModel.swift
//  Segnaventura
//
//  Christopher Pedraza Pohlenz
//

import Foundation

// Modelo general que contiene una lista de las categorias del vocabulario
struct QuizModel : Decodable, Identifiable {
    var id = UUID()
    var quizzes : [Quiz] = [Quiz]()
    var palabras : [Palabra] = [Palabra]()
    
    enum CodingKeys : String, CodingKey {
        case quizzes
        case palabras
    }
    
}

struct Quiz: Decodable, Identifiable {
    var id = UUID()
    var id_isla : Int = 0
    
    
    enum CodingKeys : String, CodingKey {
        case id
        case id_isla
    }
}


struct DetallesQuiz: Decodable, Identifiable {
    var id = UUID()
    var id_quiz : Int = 0
    var respuesta_palabra : Int = 0
    
    
    enum CodingKeys : String, CodingKey {
        case id
        case id_quiz
        case respuesta_palabra
    }
}


struct Palabra: Decodable, Identifiable {
    var id = UUID()
    var palabra : String = ""
    var link_senia : String = ""
    var id_isla : Int = 0
    
    
    enum CodingKeys : String, CodingKey {
        case id
        case palabra
        case link_senia
        case id_isla
    }
}



