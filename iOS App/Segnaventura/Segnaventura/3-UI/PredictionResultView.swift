//
//  PredictionResultView.swift
//  coreML-starter
//

import SwiftUI

struct PredictionResultView: View {
    private(set) var labelData: Classification
    
    var body: some View {
        // TODO: The View that shows classification results - edit the styling below!
        
        ZStack(alignment: .top) {

        //[OPTIONAL] Edit panel background color here.
        Color.white
            .opacity(0.5)
            .ignoresSafeArea()

            VStack {
                //This view displays your prediction. Make edits in PredictiveLabelView file.
                PredictiveLabelView(labelData: labelData)
                
                NavigationLink {
                    TranslationView(labelData: labelData)
                } label: {
                    Text("Confirmar")
                        .padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                    
                }
                
            }
            .padding()


        }
        //[OPTIONAL] Change the size of the frame.
        .frame(width: 350)

    }
}

struct PredictionResultView_Previews: PreviewProvider {
    static var previews: some View {
        PredictionResultView(labelData: Classification())
    }
}

