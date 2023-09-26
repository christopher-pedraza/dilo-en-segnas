//
//  SegnaventuraApp.swift
//  Segnaventura
//
//  Christopher Pedraza Pohlenz
//

import SwiftUI

@main
struct SegnaventuraApp: App {
    // Se pasaran como environmentObjects estos dos objetos para que puedan ser usados
    // en las demas vistas
    @StateObject var VocabularioVM = VocabularioViewModel()
    @StateObject var VideoVM = VideoViewModel()
    @StateObject var fsm = FileSystemManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(VocabularioVM)
                .environmentObject(VideoVM)
                .environmentObject(fsm)
        }
    }
}
