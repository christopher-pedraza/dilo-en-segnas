//
//  VideoActivityEnd.swift
//  Segnaventura
//
//  Created by Christopher Pedraza on 21/09/23.
//

import SwiftUI

// View final de la actividad de videos
struct VideoActivityEnd: View {
    // Binding con la cantidad de respuestas correctas para llevar un registro
    @Binding var correctAnswers : Int
    // Cantidad maxima de respuestas que puede tener la actividad
    let maxCorrectas : Int
    
    var body: some View {
        ZStack{
            Color.purple
            VStack {
                Text("\(correctAnswers)/\(maxCorrectas)")
                    .font(.system(size: 70))
                    .foregroundStyle(Color.white)
                Button(action: {
                    
                }) {
                    Text("Terminar")
                        .font(.system(size: 24))
                }
                // El boton estara deshabilitado hasta que se tengan todas las respuestas
                // correctas
                .disabled(correctAnswers != maxCorrectas)
                .padding(.top, 40)
                
            }
            .background(Color.purple)
        }
    }
}
