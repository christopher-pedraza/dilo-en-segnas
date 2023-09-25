//
//  ContentView.swift
//  Segnaventura
//
//  Christopher Pedraza Pohlenz
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    var body: some View {
        // Tab view con las dos demos de las funcionalidades
        NavigationView{
            

            TabView {
                VocabularioDataDemo()
                    .tabItem {
                        Label("VocabularioDataDemo", systemImage: "gearshape.2.fill")}
                FileManagerDemo()
                    .tabItem {
                        Label("FileManagerDemo", systemImage: "gearshape.2.fill")
                    }
                LaunchScreenView()
                    .tabItem {
                        Label("Scanner", systemImage: "gearshape.2.fill")
                    }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
