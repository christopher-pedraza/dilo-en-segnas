import SwiftUI

struct IndividualQuizActivity: View {
    
    let preguntasArr: PreguntasPalabrasVideosArr
    @Binding var correctAnswers: Int
    @Binding var questionCorrectAnswers: [Int]
    @Binding var currentQuestionIndex: Int
    @State var correctAnswerVideo: Bool = false
    @State var bindingTapped: Bool = false
    
    
    
    

    var body: some View {
        NavigationView{
            
            VStack {
                let randomNumber = Int.random(in: 0...1)
                
                if (currentQuestionIndex < preguntasArr.preguntas.count) {
                    if randomNumber == 0 {
                        VideoView(videoID: preguntasArr.preguntas[currentQuestionIndex].id_video)
                            .frame(minHeight: 0, maxHeight: UIScreen.main.bounds.height * 0.3)
                            .cornerRadius(12)
                            .padding(.horizontal, 24)
                    }
                    
                    if randomNumber == 1 {
                        Text(preguntasArr.preguntas[currentQuestionIndex].pregunta)
                            .font(.system(size: 35))
                    }
                    
                    if randomNumber == 0 {
                        let pregunta = preguntasArr.preguntas[currentQuestionIndex]
                        GeometryReader { geometry in
                            List(preguntasArr.preguntas.indices, id: \.self) { index in
                                if index == currentQuestionIndex {
                                    let pregunta = preguntasArr.preguntas[currentQuestionIndex]
                                    ForEach(pregunta.respuestas.indices, id: \.self) { answerIndex in
                                        let respuesta = pregunta.respuestas[answerIndex]
                                        HStack {
                                            QuizButton(
                                                randomNum: randomNumber,
                                                text: respuesta.respuesta_palabra,
                                                video_id: respuesta.respuesta_video,
                                                esCorrecta: respuesta.esCorrecta,
                                                numeroArr: preguntasArr.preguntas.count,
                                                preguntasArr: preguntasArr,
                                                correctAnswers: $correctAnswers,
                                                questionCorrectAnswers: $questionCorrectAnswers,
                                                currentQuestionIndex: $currentQuestionIndex,
                                                cantidadCorrectas: pregunta.cantidadCorrectas,
                                                correctAnswerVideo: $correctAnswerVideo,
                                                bindingTapped: $bindingTapped
                                            )
                                            .frame(height: 90)
                                            .background(getBackgroundColor(for: answerIndex))
                                            
                                        }
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                    }
                                    .listRowBackground(Color.clear)
                                }
                            }.listStyle(PlainListStyle())
                                .frame(width: geometry.size.width, height: geometry.size.height)
                        }
                    }
                    
                    if randomNumber == 1 {
                        let pregunta = preguntasArr.preguntas[currentQuestionIndex]
                        Text(pregunta.pregunta)
                            .font(.system(size: 35))
                        
                        List(preguntasArr.preguntas.indices, id: \.self) { index in
                            if index == currentQuestionIndex {
                                let pregunta = preguntasArr.preguntas[currentQuestionIndex]
                                ForEach(pregunta.respuestas.indices, id: \.self) { answerIndex in
                                    let respuesta = pregunta.respuestas[answerIndex]
                                    HStack {
                                        QuizButton(
                                            randomNum: randomNumber,
                                            text: respuesta.respuesta_palabra,
                                            video_id: respuesta.respuesta_video,
                                            esCorrecta: respuesta.esCorrecta,
                                            numeroArr: preguntasArr.preguntas.count,
                                            preguntasArr: preguntasArr,
                                            correctAnswers: $correctAnswers,
                                            questionCorrectAnswers: $questionCorrectAnswers,
                                            currentQuestionIndex: $currentQuestionIndex,
                                            cantidadCorrectas: pregunta.cantidadCorrectas,
                                            correctAnswerVideo: $correctAnswerVideo,
                                            bindingTapped: $bindingTapped
                                        )
                                        .frame(height: 108)
                                        .padding(.all, 10)
                                        .background(getBackgroundColor(for: answerIndex))
                                    }
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                }
                                .listRowBackground(Color.clear)
                            }
                        }.listStyle(PlainListStyle())
                    }
                }
            }
            .background(Image("Wallpaper") // Replace "wallpaper" with the name of your asset
                .resizable()
                .aspectRatio(contentMode: .fill))
        }
    }
}

struct QuizButton: View {
    @State private var didTap: Bool = false
    @State private var isCorrectAnswerSelected: Bool = false
    let randomNum: Int
    let text: String
    let video_id: String
    let esCorrecta: Bool
    let numeroArr: Int
    let preguntasArr: PreguntasPalabrasVideosArr
    @Binding var correctAnswers: Int
    @Binding var questionCorrectAnswers: [Int]
    @Binding var currentQuestionIndex: Int
    var cantidadCorrectas: Int
    @Binding var correctAnswerVideo: Bool
    @Binding var bindingTapped: Bool

    var body: some View {
        Button(action: {
            self.didTap = true
            bindingTapped = true
            if esCorrecta {
                isCorrectAnswerSelected = true
                correctAnswerVideo = true
                correctAnswers += 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                    questionCorrectAnswers[currentQuestionIndex] += 1
                    if currentQuestionIndex < preguntasArr.preguntas.count {
                        currentQuestionIndex += 1
                    }
                    isCorrectAnswerSelected = true
                }
            }
        }) {
            if randomNum == 0 {
                Text(text)
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 27))
                    .foregroundColor(
                        !didTap ? Color.white :
                            (didTap && isCorrectAnswerSelected) ? Color.green :
                            (didTap && !isCorrectAnswerSelected) ? Color.red :
                            Color.white
                    )
            }
            if randomNum == 1 {
                HStack {
                    VideoView(videoID: video_id)
                        .frame(minHeight: 0, maxHeight: UIScreen.main.bounds.height)
                        .cornerRadius(12)
                    Text("Seleccionar")
                        .font(.system(size: 20))
                        .foregroundColor(
                            !didTap ? Color.white :
                                (didTap && isCorrectAnswerSelected) ? Color.green :
                                (didTap && !isCorrectAnswerSelected) ? Color.red :
                                Color.white
                        )
                }
            }
        }
    }
}

func getBackgroundColor(for answerIndex: Int) -> Color {
    switch answerIndex {
    case 0:
        return Color.orange
    case 1:
        return Color.yellow
    case 2:
        return Color.red
    case 3:
        return Color.blue
    default:
        return Color.clear
    }
}
