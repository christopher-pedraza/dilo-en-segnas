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
                .frame(width:  150, height: 150)
                .padding(-20)
            
            Text(labelData.label)
                .font(.system(size: 40, weight: .bold))
                .foregroundStyle(.white)
                .padding(-4)
        }
    }
}

struct PredictiveLabelView_Previews: PreviewProvider {
    static var previews: some View {
        PredictiveLabelView(labelData: Classification())
    }
}
