//
//  SegnaventuraApp.swift
//  Segnaventura
//
//  Created by Alumno on 05/09/23.
//

import SwiftUI

@main
struct SegnaventuraApp: App {
    @StateObject var VocabularioVM = VocabularioViewModel()
    @StateObject var fsm = FileSystemManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(VocabularioVM)
                .environmentObject(fsm)
        }
    }
}
