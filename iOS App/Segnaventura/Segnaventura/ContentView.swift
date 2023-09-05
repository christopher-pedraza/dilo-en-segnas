//
//  ContentView.swift
//  Segnaventura
//
//  Created by Alumno on 05/09/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var VocabularioVM = VocabularioViewModel()
    
    var body: some View {
        Text("Test")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
