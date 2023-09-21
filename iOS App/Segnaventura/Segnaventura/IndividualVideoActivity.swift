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
    
    func saveData() {
        
    }
    
    var body: some View {
        VStack {
            VideoView(videoID: videoID)
                .frame(minHeight: 0, maxHeight: UIScreen.main.bounds.height * 0.3)
                .cornerRadius(12)
                .padding(.horizontal, 24)
            
            Form {
                ForEach(preguntas, id: \.self) { pregunta in
                    Section(header: Text(pregunta.pregunta)) {
                        ForEach(pregunta.respuestas, id: \.self) { respuesta in
                            //Button(action: {}, label: {Text(respuesta.respuesta)})
                            VideoQuizButton(text: respuesta.respuesta, colorDefault: Color.black, colorPressed: respuesta.esCorrecta ? Color.green : Color.red)
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
    let colorDefault : Color
    let colorPressed : Color
    
    var body: some View {
        Button(action: {
            self.didTap = true
        }) {
            Text(text)
                .font(.system(size: 24))
        }
        .foregroundColor(didTap ? colorPressed : colorDefault)
    }
}


struct IndividualVideoActivity_Previews: PreviewProvider {
    static var previews: some View {
        IndividualVideoActivity(videoID: "Y4Yv7sHJvMU", preguntas: [Pregunta]())
    }
}
