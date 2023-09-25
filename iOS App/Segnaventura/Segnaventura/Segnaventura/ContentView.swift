//
//  ContentView.swift
//  Segnaventura
//
//  Christopher Pedraza Pohlenz
//

import SwiftUI

struct ContentView: View {
    /*
    init(){
        UITabBar.appearance().backgroundColor = .blue
    }
     */
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
            }
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
