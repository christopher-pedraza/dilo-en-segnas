//
//  ProgresoModel.swift
//  Segnaventura
//
//  Created by Adrián Alejandro Ramírez Cruz on 17/10/23.
//

import Foundation

// Modelo para obtener el progreso de islas descubiertas
struct ProgresoModel: Decodable, Identifiable {
    var id = UUID()
    var id_miembro: Int = 0
    var id_isla: Int = 0
    var isla: Isla = Isla()
}

struct Isla: Decodable, Identifiable {
    var id = UUID()
    var id_isla: Int = 0
    var nombre: String = ""
    var modelo_general: String = ""
    var modelo_especifico: String = ""
    var nivel: [Nivel] = [Nivel]()
}

struct Nivel : Decodable, Identifiable {
    var id = UUID()
    var id_nivel : Int = 0
    var id_isla : Int = 0
    var id_video_cuestionario : Int = 0
    var id_quiz : Int = 0
    var id_treasure_hunt : Int = 0
    var quiz : Quiz = Quiz()
    var treasure_hunt : TreasureHunt = TreasureHunt()
    var video_cuestionario : VideoCuestionario = VideoCuestionario()
    var progreso_nivel : [ProgresoNivel] = [ProgresoNivel]()
}


struct Quiz : Decodable, Identifiable {
    var id = UUID()
    var id_quiz : Int = 0
    var id_isla : Int = 0
    var nombre : String = ""
}

struct TreasureHunt : Decodable, Identifiable {
    var id = UUID()
    var id_treasure_hunt : Int = 0
    var id_isla : Int = 0
    var id_modelo_coml : Int = 0
}

struct VideoCuestionario : Decodable, Identifiable {
    var id = UUID()
    var id_video_cuestionario : Int = 0
    var nombre : String = ""
    var id_isla : Int = 0
}

struct ProgresoNivel : Decodable, Identifiable {
    var id = UUID()
    var id_miembro : Int = 0
    var id_nivel : Int = 0
    var completada_treasure_hunt : Bool = false
    var completada_videos_cuestionario : Bool = false
    var completada_quiz : Bool = false
}
