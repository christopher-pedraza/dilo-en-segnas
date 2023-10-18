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
