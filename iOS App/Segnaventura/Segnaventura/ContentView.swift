//
//  ContentView.swift
//  Segnaventura
//
//  Christopher Pedraza Pohlenz
//

import SwiftUI
import RealityKit
import Combine

struct ContentView: View {
    
    @EnvironmentObject var ARVM: ARExperience
    
    init() {
           // Customize the TabView appearance
           let tabBarAppearance = UITabBarAppearance()
           tabBarAppearance.backgroundColor = UIColor(Color(red: 21 / 255, green: 17 / 255, blue: 28 / 255))
           tabBarAppearance.stackedLayoutAppearance.selected.iconColor = UIColor.white
           tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white]
           tabBarAppearance.stackedLayoutAppearance.normal.iconColor = UIColor.gray
           tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]

           UITabBar.appearance().standardAppearance = tabBarAppearance
           UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
       }

    var body: some View {
        
        // Tab view con las dos demos de las funcionalidades
        /*
        switch true {
        case ARVM.isTH_Active:
            return AnyView(LaunchScreenView())
        case ARVM.isQuiz_Active:
            return AnyView(PreguntasPalabrasActivity())
        case ARVM.isVideo_Active:
            return AnyView(VideosActivity())
        default:
            return AnyView(ARViewContainer().edgesIgnoringSafeArea(.all))
        }
        */
        
        NavigationView {
            TabView {
                VocabularioDataDemo()
                    .tabItem {
                        Label("VocabularioDataDemo", systemImage: "gearshape.2.fill")}
                FileManagerDemo()
                    .tabItem {
                        Label("FileManagerDemo", systemImage: "gearshape.2.fill")
                    }
                PreguntasPalabrasActivity()
                    .tabItem {
                        Label("Quiz", systemImage: "gearshape.2.fill")
                    }
                VideosActivity(correctAnswers: 0)
                    .tabItem {
                        Label("VideosDemo", systemImage: "gearshape.2.fill")
                    }
                LaunchScreenView()
                    .tabItem {
                        Label("Scanner", systemImage: "gearshape.2.fill")
                    }
                Temp()
                    //.edgesIgnoringSafeArea(.all)
                    .tabItem {
                        Label("AR", systemImage: "gearshape.2.fill")
                    }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
         
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
