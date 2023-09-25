//
//   VideosActivity.swift
//  Segnaventura
//
//  Created by Christopher Pedraza on 17/09/23.
//

import SwiftUI

struct VideosActivity: View {
    // Modelo con los datos del JSON para la actividad
    @EnvironmentObject var VideoVM : VideoViewModel
    // Variable para llevar un registro de la cantidad de respuestas
    // correctas que se llevan en todas las preguntas
    @State var correctAnswers : Int
    
    var body: some View {
        TabView {
            // Se itera por las partes de la actividad
            ForEach($VideoVM.videos.partes) { $parte in
                // Por cada parte, creamos una vista
                // A esta vista se le pasa el id del video, el arreglo de las
                // preguntas, una variable de estado para que cada boton actualice
                // la cantidad de respuestas correctas, y arreglo para llevar
                // registro de la cantidad de respuestas correctas por pregunta
                IndividualVideoActivity(videoID: parte.idVideo, preguntas: parte.preguntas, correctAnswers: $correctAnswers, questionCorrectAnswers: Array(repeating: 0, count: parte.preguntas.count))
            }
            // Pestaña final que despliega la cantidad de respuestas correctas y
            // deja terminar la actividad
            VideoActivityEnd(correctAnswers: $correctAnswers, maxCorrectas: VideoVM.videos.correctas)
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .onAppear(perform: downloadVideos)
    }
    
    // Funcion para descargar los datos de los videos usando el ViewModel
    func downloadVideos() {
        Task {
            do {
                try await VideoVM.getVideosData()
            } catch {
            }
        }
    }
}
