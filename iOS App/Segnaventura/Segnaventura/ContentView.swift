//
//  ContentView.swift
//  Segnaventura
//
//  Christopher Pedraza Pohlenz
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // Tab view con las dos demos de las funcionalidades
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
