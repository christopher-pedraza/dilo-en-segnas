//
//   VideosActivity.swift
//  Segnaventura
//
//  Created by Christopher Pedraza on 17/09/23.
//

import SwiftUI

struct VideosActivity: View {
    @EnvironmentObject var VideoVM : VideoViewModel
    @State var correctAnswers : Int
    
    var body: some View {
        TabView {
            ForEach($VideoVM.videos.partes) { $parte in
                IndividualVideoActivity(videoID: parte.idVideo, preguntas: parte.preguntas, correctAnswers: $correctAnswers, questionCorrectAnswers: Array(repeating: 0, count: parte.preguntas.count))
            }
            VideoActivityEnd(correctAnswers: $correctAnswers, maxCorrectas: VideoVM.videos.correctas)
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .onAppear(perform: downloadVideos)
    }
    
    func downloadVideos() {
        Task {
            do {
                try await VideoVM.getVideosData()
            } catch {
            }
        }
    }
}

/*
struct VideosActivity_Previews: PreviewProvider {
    static var previews: some View {
        VideosActivity(correctAnswers: <#Int#>)
    }
}
*/
