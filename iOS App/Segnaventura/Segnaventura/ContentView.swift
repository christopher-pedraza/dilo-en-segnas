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
        List(VocabularioVM.vocabulario.categorias) { categoria in
            VStack {
                Text(categoria.nombre_categoria)
                
                ForEach(categoria.vocabulario) { vocabulario in
                    VStack {
                        Text(vocabulario.palabra_espagnol)
                        Text(vocabulario.url_video)
                    }
                }
            }
        }
        .task {
            do {
                try await VocabularioVM.getVocabularioData()
            } catch {
                print("Error: No se pudo obtener los datos de las fotos.")
            }
                    }
        Text("Test")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
