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
    @EnvironmentObject var AccesoVM : AccesoViewModel
    @EnvironmentObject var MI: menuIndex
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
    
    @State var index: Int = 1
    
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
        
        if MI.index == 1 {
            menuPage()
        } else if MI.index == 2 {
            Temp()
        } else if MI.index == 3 {
            VocabularioDataDemo()
        } else if MI.index == 4 {
            PerfilView()
        }
        
        /*
        if AccesoVM.accesoValido {
            NavigationView {
                TabView {
                    
                    VocabularioDataDemo()
                        .tabItem {
                            Label("VocabularioDataDemo", systemImage: "gearshape.2.fill")}
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
                    ARViewContainer().edgesIgnoringSafeArea(.all)
                        .tabItem {
                            Label("AR", systemImage: "gearshape.2.fill")
                        }
                    PerfilView()
                        .tabItem {
                            Label("Perfil", systemImage: "person.crop.circle")
                        }
                }
            }.navigationViewStyle(StackNavigationViewStyle())
        } else {
            Login()
        }
        */
    }
    
}

struct menuPage: View {
    @EnvironmentObject var MI: menuIndex
    
    var body: some View {
        
        VStack {
            
            Temp()
            
            HStack {
                
                Spacer()
                
                Button("Vocabulario"){
                    MI.index = 3
                }
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .cornerRadius(10)
                //.frame(width: 200, height: 50)

                Spacer()
                
                Button("Perfil"){
                    MI.index = 4
                }
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .cornerRadius(10)
                //.frame(width: 200, height: 50)
                
                Spacer()
            }

        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
