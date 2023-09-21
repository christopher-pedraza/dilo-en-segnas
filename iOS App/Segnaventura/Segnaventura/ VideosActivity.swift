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
        if VideoVM.isLoading && VideoVM.videos.partes.isEmpty {
            ProgressView()
        }
        else {
            TabView {
                ForEach($VideoVM.videos.partes) { $parte in
                    IndividualVideoActivity(videoID: parte.idVideo, preguntas: parte.preguntas)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .onAppear(perform: downloadVideos)
        }
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

struct VideosActivity_Previews: PreviewProvider {
    static var previews: some View {
        VideosActivity()
    }
}

