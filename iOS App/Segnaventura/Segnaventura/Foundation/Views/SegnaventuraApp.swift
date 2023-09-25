//
//  SegnaventuraApp.swift
//  Segnaventura
//
//  Christopher Pedraza Pohlenz
//

import SwiftUI

@main
struct SegnaventuraApp: App {
    // Se pasaran como environmentObjects estos tres objetos para que puedan ser usados
    // en las demas vistas
    @StateObject var VocabularioVM = VocabularioViewModel()
    @StateObject var fsm = FileSystemManager()
    @StateObject private var predictionStatus = PredictionStatus()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(VocabularioVM)
                .environmentObject(fsm)
                .environmentObject(predictionStatus)
        }
    }
}

