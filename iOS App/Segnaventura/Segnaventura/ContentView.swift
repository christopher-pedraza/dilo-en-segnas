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
                ARViewContainer(arExperience: ARExperience())
                    //.edgesIgnoringSafeArea(.all)
                    .tabItem {
                        Label("AR", systemImage: "gearshape.2.fill")
                    }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

// Esta estructura es un adaptador que permite integrar la vista de AR en SwiftUI
struct ARViewContainer: UIViewRepresentable {
    let arExperience: ARExperience

    func makeUIView(context: Context) -> ARView {
        return arExperience.arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
