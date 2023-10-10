//
//  PredictiveLabelView.swift
//  coreML-starter
//

import SwiftUI

struct PredictiveLabelView: View {
    private(set) var labelData: Classification
    
    var body: some View {
        
        VStack(alignment: .center) {
            Image(labelData.image)
                .resizable()
                .frame(width: 320, height: 320)
            
            Text(labelData.label)
                .font(.system(size: 40, weight: .bold))
        }
    }
}

struct PredictiveLabelView_Previews: PreviewProvider {
    static var previews: some View {
        PredictiveLabelView(labelData: Classification())
    }
}
