//
//  VideoQuizButton.swift
//  Segnaventura
//
//  Created by Christopher Pedraza on 20/09/23.
//

import SwiftUI

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
        //.frame(width: 300, height: 75, alignment: .center)
        //.padding(.all, 20)
        //.background(didTap ? colorPressed : colorDefault)
        .foregroundColor(didTap ? colorPressed : colorDefault)
    }
}

struct VideoQuizButton_Previews: PreviewProvider {
    static var previews: some View {
        VideoQuizButton(text: "Custom Button", colorDefault: Color.blue, colorPressed: Color.yellow)
    }
}
