//
//  coreML-starter.swift
//
//  
//

import SwiftUI

@main
struct coreML_starterApp: App {
    
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
