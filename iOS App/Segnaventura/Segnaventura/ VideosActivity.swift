//
//   VideosActivity.swift
//  Segnaventura
//
//  Created by Christopher Pedraza on 17/09/23.
//

import SwiftUI

struct VideosActivity: View {
    @EnvironmentObject var VideoVM : VideoViewModel
    
    var body: some View {
        VStack {
            Text("Titulo")
            VideoView(videoID: "BCyjT6lkAg4")
                .frame(minHeight: 0, maxHeight: UIScreen.main.bounds.height * 0.3)
                .cornerRadius(12)
                .padding(.horizontal, 24)
        }
    }
}

struct VideosActivity_Previews: PreviewProvider {
    static var previews: some View {
        VideosActivity()
    }
}
