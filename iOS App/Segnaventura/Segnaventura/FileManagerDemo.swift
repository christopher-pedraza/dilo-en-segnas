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
            // Textfield para obtener una palabra a agregar y pasarla a la funcion
            // de FileSystemManager para agregarla al archivo
            TextField("Palabra a agregar: ", text: $palabra_add)
                .border(.secondary)
                .onSubmit {
                    do {
                        // Agrega la palabra al arreglo y al archivo
                        try fsm.agregarPalabra(palabra: palabra_add)
                    } catch {}
                }
            
            // Textfield para obtener una palabra a eliminar y pasarla a la funcion
            // de FileSystemManager para removerla del archivo
            TextField("Palabra a quitar: ", text: $palabra_rem)
                .border(.secondary)
                .onSubmit {
                    do {
                        // Elimina la palabra del arreglo y del archivo
                        try fsm.quitarPalabra(palabra: palabra_rem)
                    } catch {}
                }
            
            Text("PALABRAS: ")
            // Despliega las palabras guardadas en el arreglo
            List(fsm.vocabularioAprendido, id: \.self) { item in
                Text(item)
            }
            .task {
                do {
                    // Lee el archivo para actualizar el arreglo
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
