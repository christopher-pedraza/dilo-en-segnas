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
    @EnvironmentObject var PalabrasVideosVM: PalabraVideosViewModel
    // Variable para llevar un registro de la cantidad de respuestas
    // correctas que se llevan en todas las preguntas
    
    //  let videoID: String
    @State private var correctAnswers: Int = 0
    @State private var questionCorrectAnswers: [Int] = []
    
    
    var body: some View {
        
        TabView {
            
            // Se itera por las partes de la actividad
            ForEach(PalabrasVideosVM.palabras) { palabra in
                
                
                let questions = generateQuestionsForPalabra(palabra)
                
                // Por cada parte, creamos una vista
                // A esta vista se le pasa el id del video, el arreglo de las
                // preguntas, una variable de estado para que cada boton actualice
                // la cantidad de respuestas correctas, y arreglo para llevar
                // registro de la cantidad de respuestas correctas por pregunta
                IndividualVideoActivity(videoID: palabra.id_video_segna, preguntas: generateQuestionsForPalabra(palabra), correctAnswers: $correctAnswers, questionCorrectAnswers: Array(repeating: 0, count: questions.count))
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
                try await PalabrasVideosVM.getPalabrasVideos()
            } catch {
            }
        }
    }

    
    func generateQuestionsForPalabra(_ palabra: PalabrasVideosModel) -> [Pregunta] {
        var questions = [Pregunta]()
        
        // Shuffle the availablePalabras to randomize the order
        var availablePalabras = PalabrasVideosVM.palabras.shuffled()
        
        for _ in 0..<3 {
            // Ensure we have enough palabras for incorrect answers
            guard availablePalabras.count >= 4 else {
                break
            }
            
            // Create a Respuesta instance for the correct answer
            let correctAnswer = Respuesta(respuesta: palabra.palabra, esCorrecta: true)
            
            // Take three palabras as incorrect answers
            var incorrectAnswers = Array(availablePalabras.prefix(3))
            
            // If the correct answer is in the incorrect answers, replace it with a random palabra
            if let index = incorrectAnswers.firstIndex(where: { $0.palabra == palabra.palabra }) {
                incorrectAnswers[index] = availablePalabras[3]
            }
            
            // Remove the selected palabras from availablePalabras
            availablePalabras = Array(availablePalabras.dropFirst(4))
            
            // Create Respuesta instances for the incorrect answers
            let incorrectRespuestas = incorrectAnswers.map { Respuesta(respuesta: $0.palabra, esCorrecta: false) }
            
            // Combine the correct and incorrect answers
            var allAnswers = incorrectRespuestas
            allAnswers.append(correctAnswer)
            
            // Shuffle the answers to randomize their order
            let shuffledAnswers = allAnswers.shuffled()
            
            // Create the question with the shuffled answers, using the palabra object itself
            let pregunta = Pregunta(pregunta: palabra.palabra, cantidadCorrectas: 1, respuestas: shuffledAnswers)

            questions.append(pregunta)
        }
        
        //questions.shuffle()
        return questions
    }


}
