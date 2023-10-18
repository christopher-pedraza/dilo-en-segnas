//
//  THModel.swift
//  Segnaventura
//
//  Created by Alumno on 13/10/23.
//

import Foundation

// Modelo general que contains a list of the vocabulary categories
struct THModel: Decodable, Identifiable {
    var id = UUID()
    var palabra : String = ""
    var url_icono : String = ""
    var id_video_segna : String = ""
    
    enum CodingKeys: String, CodingKey {
        case palabra
        case url_icono
        case id_video_segna
    }
}

//typealias THModelList = [THModel]
