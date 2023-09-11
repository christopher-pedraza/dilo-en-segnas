//
//  FileManagerDemo.swift
//  Segnaventura
//
//  Created by Alumno on 11/09/23.
//

import SwiftUI

struct FileManagerDemo: View {
    @EnvironmentObject var VocabularioVM : VocabularioViewModel
    @EnvironmentObject var fsm : FileSystemManager
    
    @State var palabra_add : String = ""
    @State var palabra_rem : String = ""
    
    var body: some View {
        VStack {
            TextField("Palabra a agregar: ", text: $palabra_add)
                .border(.secondary)
                .onSubmit {
                    do {
                        try fsm.agregarPalabra(palabra: palabra_add)
                    } catch {}
                }
            
            TextField("Palabra a quitar: ", text: $palabra_rem)
                .border(.secondary)
                .onSubmit {
                    do {
                        try fsm.quitarPalabra(palabra: palabra_rem)
                    } catch {}
                }
            
            Text("PALABRAS: ")
            
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

struct FileManagerDemo_Previews: PreviewProvider {
    static var previews: some View {
        FileManagerDemo()
    }
}
