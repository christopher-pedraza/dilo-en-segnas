//
//  VocabularioDataDemo.swift
//  Segnaventura
//
//  Christopher Pedraza Pohlenz
//

import SwiftUI

struct VocabularioDataDemo: View {
    // Objeto del vocabulario (que se leyo del JSON)
    @EnvironmentObject var VocabularioVM : VocabularioViewModel
    // Objeto que maneja los archivos del sistema
    @EnvironmentObject var fsm : FileSystemManager
    
    var body: some View {
        VStack {
            // Lista con el vocabulario. Se itera por las categorias
            List(VocabularioVM.vocabulario.categorias) { categoria in
                VStack {
                    Text(categoria.nombre_categoria)
                    
                    // Se itera por el vocabulario dentro de cada categoria
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
                    // Se obtienen los datos del vocabulario del API
                    try await VocabularioVM.getVocabularioData()
                } catch {
                    print("Error: No se pudo obtener los datos del API")
                }
            }
        }
    }
}

struct VocabularioDataDemo_Previews: PreviewProvider {
    static var previews: some View {
        VocabularioDataDemo()
    }
}
