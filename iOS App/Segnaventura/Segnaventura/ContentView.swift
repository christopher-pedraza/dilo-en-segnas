//
//  ContentView.swift
//  Segnaventura
//
//  Christopher Pedraza Pohlenz
//

import SwiftUI

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
                Acceso()
                    .tabItem {
                        Label("Acceso", systemImage: "gearshape.2.fill")
                    }
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
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
