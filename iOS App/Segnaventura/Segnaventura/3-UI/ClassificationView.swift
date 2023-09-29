//
//  ClassificationView.swift
//  coreML-starter
//
//
//

import SwiftUI

struct ClassificationView: View {
    @EnvironmentObject var predictionStatus: PredictionStatus
    @StateObject var classifierViewModel = ClassifierViewModel()
    
    var body: some View {
        let predictionLabel = predictionStatus.topLabel
        ZStack {
            
            //[OPTIONAL] Edit background color here.
//            Color.blue
//                .opacity(0.5)
//                .ignoresSafeArea()

            // DO NOT EDIT this section. This displays the classification camera
            GeometryReader { geo in
                HStack(alignment: .top) {
                    LiveCameraRepresentable() {
                        predictionStatus.setLivePrediction(with: $0, label: $1, confidence: $2)
                    }
                    
                    PredictionResultView(labelData: classifierViewModel.getPredictionData(label: predictionLabel))
                    
                }// HStack
                .onAppear(perform: classifierViewModel.loadJSON)
                .frame(width: geo.size.width)
            }
        }
    }
}

struct ClassificationView_Previews: PreviewProvider {
    static var previews: some View {
        ClassificationView()
    }
}
