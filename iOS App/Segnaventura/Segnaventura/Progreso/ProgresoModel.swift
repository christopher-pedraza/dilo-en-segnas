//
//  ProgresoModel.swift
//  Segnaventura
//
//  Created by Adrián Alejandro Ramírez Cruz on 17/10/23.
//

import Foundation

// Modelo para obtener el progreso de islas descubiertas
struct ProgresoModel : Decodable, Identifiable {
    var id = UUID()
    var id_miembro : Int = 0
    var id_isla : Int = 0
    var isla : Isla = Isla()
}

struct Isla : Decodable, Identifiable {
    var id = UUID()
    var id_isla : Int = 0
    var nombre : String = ""
    var modelo_general : String = ""
    var modelo_especifico : String = ""
    var nivel : [Int] = []
}
