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
    @StateObject private var predictionStatus = PredictionStatus()
    @StateObject var palabraVideosVM = PalabraVideosViewModel()
    @StateObject var AccesoVM = AccesoViewModel()
    
    init() {
        
        /*
        let customColorNavBar = UIColor(Color(red: 21 / 255, green: 17 / 255, blue: 28 / 255))
        let navBarAppearance = UINavigationBarAppearance()
        ///navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = customColorNavBar
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        // Set the appearance for compact navigation bars (when scrolling)
        //navBarAppearance.compactAppearance = navBarAppearance
        */
        
        let customColorNavBar = UIColor(Color(red: 21 / 255, green: 17 / 255, blue: 28 / 255))
                let navBarAppearance = UINavigationBarAppearance()
                navBarAppearance.backgroundColor = customColorNavBar
                
                // Customize the font for the navigation bar title text
                // let titleFont = UIFont(name: "Poppins-SemiBold", size: 24)!
                // navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: titleFont]
                
                // Set backgroundEffect to nil to remove the white space
                navBarAppearance.backgroundEffect = nil
                
                UINavigationBar.appearance().standardAppearance = navBarAppearance
                UINavigationBar.appearance().compactAppearance = navBarAppearance
                UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
            
            // Set the appearance for full-height navigation bars (when not scrolling)
       // navBarAppearance.scrollEdgeAppearance = navBarAppearance
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(VocabularioVM)
                .environmentObject(VideoVM)
                .environmentObject(fsm)
                .environmentObject(palabraVideosVM)
                .environmentObject(predictionStatus)
        }
    }
}
