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

            // DO NOT EDIT this section. This displays the classification camera
            GeometryReader { geo in
                ZStack(alignment: .top) {
                    LiveCameraRepresentable() {
                        predictionStatus.setLivePrediction(with: $0, label: $1, confidence: $2)
                    }
                    HStack(alignment: .center) {
                        PredictionResultView(labelData: classifierViewModel.getPredictionData(label: predictionLabel))
                    } // HStack 2
                        
                }// ZStack
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
