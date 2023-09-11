//
//  VocabularioDataDemo.swift
//  Segnaventura
//
//  Created by Alumno on 11/09/23.
//

import SwiftUI

struct VocabularioDataDemo: View {
    @EnvironmentObject var VocabularioVM : VocabularioViewModel
    @EnvironmentObject var fsm : FileSystemManager
    
    var body: some View {
        VStack {
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
                    try fsm.save(strings: ["Test", "Test2"])
                    try await VocabularioVM.getVocabularioData()
                } catch {
                    print("Error: No se pudo obtener los datos de las fotos.")
                }
            }
            List(fsm.vocabularioAprendido, id: \.self) { item in
                Text(item)
            }
            .task {
                do {
                    fsm.vocabularioAprendido = try fsm.load()
                } catch {}
            }
        }
    }
}

struct VocabularioDataDemo_Previews: PreviewProvider {
    static var previews: some View {
        VocabularioDataDemo()
    }
}
