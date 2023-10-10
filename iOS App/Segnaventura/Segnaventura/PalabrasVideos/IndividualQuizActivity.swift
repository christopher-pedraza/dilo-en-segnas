//
//  IndividualVideoActivity.swift
//  Segnaventura
//
//  Created by Christopher Pedraza on 18/09/23.
//

import SwiftUI

// Vista individual de una parte de la actividad de videos
// Vista individual de una parte de la actividad de preguntas
struct IndividualQuizActivity: View {
    
    //let videoID: String
    let preguntasArr: PreguntasPalabrasVideosArr
    @Binding var correctAnswers: Int
    @Binding var questionCorrectAnswers: [Int]
    @Binding var currentQuestionIndex: Int // Binding for tracking the current question
    
    var body: some View {
        VStack {
            
            // Video de youtube de la parte
            if (currentQuestionIndex < preguntasArr.preguntas.count){
                
                
                VideoView(videoID: preguntasArr.preguntas[currentQuestionIndex].id_video)
                    .frame(minHeight: 0, maxHeight: UIScreen.main.bounds.height * 0.3)
                    .cornerRadius(12)
                    .padding(.horizontal, 24)
                
                // Display the current question
                
                if currentQuestionIndex < preguntasArr.preguntas.count {
                    let pregunta = preguntasArr.preguntas[currentQuestionIndex]
                    Text(pregunta.pregunta)
                    
                    // Iterate over the answers for the current question
                    List(preguntasArr.preguntas.indices, id: \.self) { index in
                        if index == currentQuestionIndex {
                            // Display answers for the current question
                            let pregunta = preguntasArr.preguntas[currentQuestionIndex]
                            ForEach(pregunta.respuestas.indices, id: \.self) { answerIndex in
                                let respuesta = pregunta.respuestas[answerIndex]
                                QuizButton(
                                    text: respuesta.respuesta,
                                    esCorrecta: respuesta.esCorrecta,
                                    numeroArr: preguntasArr.preguntas.count ,
                                    preguntasArr: preguntasArr,
                                    correctAnswers: $correctAnswers,
                                    questionCorrectAnswers: $questionCorrectAnswers,
                                    currentQuestionIndex: $currentQuestionIndex,
                                    cantidadCorrectas: pregunta.cantidadCorrectas
                                )
                            }
                        }
                    }
                    
                }
                
            }
        }
    }
}


// View de boton customizado
struct QuizButton: View {
    // Variable de estado para saber si ya se presiono el boton o no
    @State private var didTap : Bool = false
    @State private var isCorrectAnswerSelected : Bool = false
    let text : String
    let esCorrecta : Bool
    let numeroArr : Int
    let preguntasArr: PreguntasPalabrasVideosArr
  //  let questionIndex : Int // Use questionIndex instead of index
    
    // Color por defecto al inicio
    private let colorDefault : Color = Color.black
    
    @Binding var correctAnswers : Int
    @Binding var questionCorrectAnswers : [Int]
    @Binding var currentQuestionIndex: Int
    var cantidadCorrectas: Int
    
    var body: some View {
        // Si se presiona, cambia el valor booleano de didTap y si es una respuesta
        // correcta, aumenta el contador de respuesta correctas global y por preguntas
        Button(action: {
            self.didTap = true
            if esCorrecta {
                isCorrectAnswerSelected = true
                print(numeroArr)
                correctAnswers += 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                           // Introduce a delay of 0.5 seconds before changing the current question
                           questionCorrectAnswers[currentQuestionIndex] += 1
                           if currentQuestionIndex < preguntasArr.preguntas.count {
                               currentQuestionIndex += 1
                           }
                           isCorrectAnswerSelected = true
                       }
                   }
                
                
        }) {
            
            Text(text)
                .font(.system(size: 24))
                .foregroundColor(
                            isCorrectAnswerSelected ? Color.green :
                                Color.gray
                        )
        }
        // Dependiendo si es una respuesta correcta o no, y si ya se presiono
        // se cambia el color del boton
        
        // Se deshabilita el boton cuando la pregunta ya tiene todas sus respuestas
        // correctas contestadas
        //.disabled(questionCorrectAnswers[questionIndex] == cantidadCorrectas) // Use questionIndex
    }
}

