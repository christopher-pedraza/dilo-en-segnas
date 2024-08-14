import SwiftUI

struct VideosActivity: View {
    @EnvironmentObject var VideoVM: VideoViewModel
    @EnvironmentObject var ARVM: ARExperience
    @State var correctAnswers: Int = 0
    @State var totalCorrectAnswers: Int = 0
    
    var body: some View {
        let customPurple = Color(red: 148 / 255, green: 0 / 255, blue: 122 / 255)

        ZStack {
            TabView {
                ForEach($VideoVM.videos.partes) { $parte in
                    IndividualVideoActivity(
                        videoURL: URL(string: parte.url_video) ?? URL(string: "https://example.com/default.mp4")!,
                        preguntas: parte.preguntas,
                        correctAnswers: $correctAnswers,
                        questionCorrectAnswers: Array(repeating: 0, count: parte.preguntas.count),
                        totalCorrectAnswers: $totalCorrectAnswers,
                        parteString: parte.nombre
                    )
                }
                VideoActivityEnd(
                    correctAnswers: $correctAnswers,
                    maxCorrectas: totalCorrectAnswers,
                    actName: "video_1"
                )
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .accentColor(customPurple)
            .onAppear {
                downloadVideos()
            }
            .background(customPurple)
        }
    }
    
    func downloadVideos() {
        Task {
            do {
                try await VideoVM.getVideosData()
                resetCount()
            } catch {
                // Handle error
            }
        }
    }
    
    func resetCount() {
        totalCorrectAnswers = 0
        correctAnswers = 0
        for parte in VideoVM.videos.partes {
            for pregunta in parte.preguntas {
                totalCorrectAnswers += pregunta.cantidadCorrectas.respuestas_video_cuestionario
            }
        }
    }
}
