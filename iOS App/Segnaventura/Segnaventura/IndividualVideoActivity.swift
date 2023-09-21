//
//  IndividualVideoActivity.swift
//  Segnaventura
//
//  Created by Christopher Pedraza on 18/09/23.
//

import SwiftUI

struct IndividualVideoActivity: View {
    let videoID : String
    let preguntas : [Pregunta]
    @Binding var correctAnswers : Int
    @State var alreadyAnswered : [Bool]
    
    func saveData() {
        
    }
    
    var body: some View {
        VStack {
            VideoView(videoID: videoID)
                .frame(minHeight: 0, maxHeight: UIScreen.main.bounds.height * 0.3)
                .cornerRadius(12)
                .padding(.horizontal, 24)
            
            Form {
                ForEach(Array(preguntas.enumerated()), id: \.offset) { index, pregunta in                    
                    Section(header: Text(pregunta.pregunta)) {
                        ForEach(pregunta.respuestas, id: \.self) { respuesta in
                            VideoQuizButton(text: respuesta.respuesta, esCorrecta: respuesta.esCorrecta, index: index, correctAnswers: $correctAnswers, alreadyAnswered: $alreadyAnswered)
                        }
                    }
                }
            }
            .padding([.bottom], 40)
        }
    }
}

struct VideoQuizButton: View {
    @State private var didTap : Bool = false
    let text : String
    let esCorrecta : Bool
    let index : Int
    
    private let colorDefault : Color = Color.black
    private let colorPressed : Color = Color.black
    
    @Binding var correctAnswers : Int
    @Binding var alreadyAnswered : [Bool]
    
    var body: some View {
        Button(action: {
            self.didTap = true
            if esCorrecta {
                correctAnswers += 1
            }
        }) {
            Text(text)
                .font(.system(size: 24))
        }
        .foregroundColor(didTap ? (esCorrecta ? Color.green : Color.red) : colorDefault)
        .disabled(alreadyAnswered[index])
    }
}

/*
struct IndividualVideoActivity_Previews: PreviewProvider {
    static var previews: some View {
        IndividualVideoActivity(videoID: "Y4Yv7sHJvMU", preguntas: [Pregunta](), correctAnswers: <#Binding<Int>#>)
    }
}
*/
