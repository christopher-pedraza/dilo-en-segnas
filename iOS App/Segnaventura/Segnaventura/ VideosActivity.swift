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
        NavigationStack {
            List(VideoVM.videos.partes, id: \.self) { parte in
                NavigationLink(parte.idVideo, parte.preguntas)
            }
            .navigationDestination(for: IndividualVideoActivity.self) { parte in
                IndividualVideoActivity(videoID: parte.videoID, preguntas: parte.preguntas)
            }
        }
        .task {
            do {
                try await VideoVM.getVideosData()
            } catch {
                print("Error: No se pudo obtener los datos del API")
            }
        }
    }
}

struct VideosActivity_Previews: PreviewProvider {
    static var previews: some View {
        VideosActivity()
    }
}
