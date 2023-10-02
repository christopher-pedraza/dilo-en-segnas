//
//  VocabularioModel.swift
//  Segnaventura
//
//  Christopher Pedraza Pohlenz
//

import Foundation

// Modelo general que contiene una lista de las categorias del vocabulario
struct PalabrasVideosModel : Decodable, Equatable,Identifiable {
        var id = UUID()
        var palabra: String = ""
        var id_video_segna: String = ""
    
    //var categorias : [Categorias] = [Categorias]()
    
    enum CodingKeys : String, CodingKey {
        //case id
        case palabra
        case id_video_segna
     
    }
     /*
    static func !=(lhs: PalabrasVideosModel, rhs: PalabrasVideosModel) -> Bool {
            return lhs.palabra != rhs.palabra || lhs.id_video_segna != rhs.id_video_segna
        }
      */
     
     
    
}

