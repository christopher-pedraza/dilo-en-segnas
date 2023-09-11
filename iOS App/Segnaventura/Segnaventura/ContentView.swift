//
//  ContentView.swift
//  Segnaventura
//
//  Created by Alumno on 05/09/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
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
