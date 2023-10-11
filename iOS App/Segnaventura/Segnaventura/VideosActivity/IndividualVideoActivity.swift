//
//  IndividualVideoActivity.swift
//  Segnaventura
//
//  Created by Christopher Pedraza on 18/09/23.
//

import SwiftUI

// Vista individual de una parte de la actividad de videos
struct IndividualVideoActivity: View {
    
    // ID del video de la parte
    let videoID : String
    // Arreglo de preguntas
    let preguntas : [Pregunta]
    // Binding de la cantidad de respuestas correctas que llevamos
    @Binding var correctAnswers : Int
    // Arreglo de enteros para contar la cantidad de respuestas correctas
    // por pregunta y asi saber si ya esta o no contestada la pregunta
    @State var questionCorrectAnswers : [Int]
    // Cuenta la cantidad de respuestas correctas
    @Binding var totalCorrectAnswers: Int
    
    // Funcion sin terminar para guardar los datos para tener persistencia
    func saveData() { }
    
    var body: some View {
        VStack {
            // Video de youtube de la parte
            
            VideoView(videoID: videoID)
                .frame(minHeight: 0, maxHeight: UIScreen.main.bounds.height * 0.3)
                .cornerRadius(12)
                .padding(.horizontal, 24)
            // Preguntas
            Form {
                
                // Se itera sobre las preguntas
                ForEach(Array(preguntas.enumerated()), id: \.offset) { index, pregunta in
                    // Desplegamos la pregunta
                    Section(header: Text(pregunta.pregunta)) {
                        // Se itera sobre las respuestas de cada pregunta
                        ForEach(pregunta.respuestas, id: \.self) { respuesta in
                            // Boton customizado
                            // Se le pasa la pregunta como texto, booleano si
                            // la respuesta es correcta o no, indice de la pregunta
                            // para poder agrupar todas las respuestas de una misma
                            // pregunta, variable para poder guardar las respuestas
                            // correctas totales, arreglo para saber cuantas respuestas
                            // correctas lleva por pregunta (para esto sirve el indice)
                            // y por ultimo, la cantidad de respuestas correctas por
                            // pregunta
                            VideoQuizButton(text: respuesta.respuesta, esCorrecta: respuesta.es_correcta, index: index, correctAnswers: $correctAnswers, questionCorrectAnswers: $questionCorrectAnswers, cantidadCorrectas: pregunta.cantidadCorrectas)
                        }
                    }
                    .onAppear {
                        totalCorrectAnswers += pregunta.cantidadCorrectas
                    }
                }
            }
            .padding([.bottom], 40)
        }
    }
}

// View de boton customizado
struct VideoQuizButton: View {
    // Variable de estado para saber si ya se presiono el boton o no
    @State private var didTap : Bool = false
    let text : String
    let esCorrecta : Bool
    let index : Int
    
    // Color por defecto al inicio
    private let colorDefault : Color = Color.black
    
    @Binding var correctAnswers : Int
    @Binding var questionCorrectAnswers : [Int]
    var cantidadCorrectas: Int
    
    var body: some View {
        // Si se presiona, cambia el valor booleano de didTap y si es una respuesta
        // correcta, aumenta el contador de respuesta correctas global y por preguntas
        Button(action: {
            self.didTap = true
            if esCorrecta {
                correctAnswers += 1
                questionCorrectAnswers[index] += 1
            }
        }) {
            Text(text)
                .font(.system(size: 24))
        }
        // Dependiendo si es una respuesta correcta o no, y si ya se presiono
        // se cambia el color del boton
        .foregroundColor(didTap ? (esCorrecta ? Color.green : Color.red) : colorDefault)
        // Se deshabilita el boton cuando la pregunta ya tiene todas sus respuestas
        // correctas contestadas
        .disabled(questionCorrectAnswers[index] == cantidadCorrectas)
    }
}
