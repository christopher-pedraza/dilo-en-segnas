//
//  IndividualVideoActivity.swift
//  Segnaventura
//
//  Created by Christopher Pedraza on 18/09/23.
//

import SwiftUI

struct IndividualVideoActivity: View {
    // @EnvironmentObject var VideoVM : VideoViewModel
    
    let videoID : String
    let preguntas : [Pregunta]
    
    func saveData() {
        
    }
    
    var body: some View {
        ScrollView {
            VideoView(videoID: videoID)
                .frame(minHeight: 0, maxHeight: UIScreen.main.bounds.height * 0.3)
                .cornerRadius(12)
                .padding(.horizontal, 24)
            
            
                ForEach(preguntas, id: \.self) { item in
                    Text(item.pregunta)
                    ForEach(item.respuestas, id: \.self) { respuesta in
                        Text(respuesta.respuesta)
                    }
                }
                Button(action: saveData) {
                    Label("Next", systemImage: "arrow.up")
                }
            }
        }
        //.padding([.bottom], 40)
    //}
}

struct IndividualVideoActivity_Previews: PreviewProvider {
    static var previews: some View {
        IndividualVideoActivity(videoID: "Y4Yv7sHJvMU", preguntas: [Pregunta]())
    }
}
