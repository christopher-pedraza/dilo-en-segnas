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
        Color.black
            .opacity(0.3)
            .ignoresSafeArea()
            
            VStack {
                //This view displays your prediction. Make edits in PredictiveLabelView file.
                PredictiveLabelView(labelData: labelData)
                
                NavigationLink {
                    TranslationView(labelData: labelData)
                } label: {
                    Text("Confirmar")
                    
                }.buttonStyle(RoundedRectButtonStyle(buttonColor: .blue))
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: -10, trailing: 0))
                
            }
            .padding(30)


        }
        //[OPTIONAL] Change the size of the frame.
        .frame(width: 300, height: 270, alignment: .bottom)
        .cornerRadius(10)
        .padding()
        .frame(maxHeight: .infinity, alignment: .bottom)

    }
}

struct PredictionResultView_Previews: PreviewProvider {
    static var previews: some View {
        PredictionResultView(labelData: Classification())
    }
}

