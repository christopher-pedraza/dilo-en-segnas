import SwiftUI

struct IndividualQuizActivity: View {
    let preguntasArr: PreguntasPalabrasVideosArr
    @Binding var correctAnswers: Int
    @Binding var questionCorrectAnswers: [Int]
    @Binding var currentQuestionIndex: Int
    @State var correctAnswerVideo: Bool = false
    @State var bindingTapped: Bool = false
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        var imageWidth: CGFloat {
            return horizontalSizeClass == .compact ? 45 : 100
        }
        var imageHeight: CGFloat {
            return horizontalSizeClass == .compact ? 60 : 120
        }

        var objectFontSize: CGFloat {
            return horizontalSizeClass == .compact ? 35 : 50
        }
        
        var objectRowSize: CGFloat {
            return horizontalSizeClass == .compact ? 90 : 155
        }
        
        var objectSeparation: CGFloat {
            return horizontalSizeClass == .compact ? 2 : 20
        }
        
        var objectSeparation2: CGFloat {
            return horizontalSizeClass == .compact ? 10 : 0
        }
        
        NavigationStack {
            VStack(alignment: .center, spacing: objectSeparation) {
                Spacer(minLength: 15)
                
                let randomNumber = Int.random(in: 0...1)
                
                if currentQuestionIndex < preguntasArr.preguntas.count {
                    let pregunta = preguntasArr.preguntas[currentQuestionIndex]
                    
                    if randomNumber == 0 {
                        if let videoURL = URL(string: pregunta.id_video) {
                            VideoView(videoURL: videoURL)
                                .aspectRatio(4/5, contentMode: .fit)
                                .frame(width: UIScreen.main.bounds.width - 48)
                                .cornerRadius(12)
                                .padding(.horizontal, 24)
                        } else {
                            Text("Invalid video URL")
                                .frame(width: UIScreen.main.bounds.width - 48)
                                .background(Color.gray)
                                .cornerRadius(12)
                                .padding(.horizontal, 24)
                        }
                    } else {
                        HStack(alignment: .center, spacing: 10) {
                            Text(pregunta.pregunta)
                                .font(.system(size: objectFontSize + 8, weight: .bold))
                                .foregroundStyle(Color.white)
                            
                            AsyncImage(url: URL(string: pregunta.url_icono)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .frame(width: imageWidth, height: imageHeight)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: imageWidth, height: imageHeight)
                                case .failure:
                                    Image(systemName: "xmark.circle")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: imageWidth, height: imageHeight)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        }
                    }

                    GeometryReader { geometry in
                        List(preguntasArr.preguntas.indices, id: \.self) { index in
                            if index == currentQuestionIndex {
                                ForEach(pregunta.respuestas.indices, id: \.self) { answerIndex in
                                    let respuesta = pregunta.respuestas[answerIndex]
                                    HStack(alignment: .center, spacing: 10) {
                                        QuizButton(
                                            randomNum: randomNumber,
                                            text: respuesta.respuesta_palabra,
                                            url_icono: respuesta.respuesta_icono,
                                            video_url: respuesta.respuesta_video,
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
                                        .frame(height: objectRowSize)
                                        .background(getBackgroundColor(for: answerIndex))
                                    }
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                }
                                .listRowBackground(Color.clear)
                            }
                        }
                        .listStyle(PlainListStyle())
                        .frame(width: geometry.size.width, height: geometry.size.height + 20)
                    }
                }
            }
            .background(
                Image("Wallpaper")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            )
        }
    }
}

struct QuizButton: View {
    @State private var didTap: Bool = false
    @State private var isCorrectAnswerSelected: Bool = false
    let randomNum: Int
    let text: String
    let url_icono: String
    let video_url: String
    let esCorrecta: Bool
    let numeroArr: Int
    let preguntasArr: PreguntasPalabrasVideosArr
    @Binding var correctAnswers: Int
    @Binding var questionCorrectAnswers: [Int]
    @Binding var currentQuestionIndex: Int
    var cantidadCorrectas: Int
    @Binding var correctAnswerVideo: Bool
    @Binding var bindingTapped: Bool
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        var imageWidth: CGFloat {
            return horizontalSizeClass == .compact ? 45 : 100
        }
        var imageHeight: CGFloat {
            return horizontalSizeClass == .compact ? 60 : 120
        }

        var objectFontSize: CGFloat {
            return horizontalSizeClass == .compact ? 35 : 50
        }
        
        var objectFontSize2: CGFloat {
            return horizontalSizeClass == .compact ? 45 : 50
        }
        
        var objectSeparation: CGFloat {
            return horizontalSizeClass == .compact ? 10 : 25
        }
        
        var objectHeight: CGFloat {
            return horizontalSizeClass == .compact ? 10 : 25
        }
        
        var objectSpaceWidth: CGFloat {
            return horizontalSizeClass == .compact ? 100 : 120
        }
        
        var videoWidth: CGFloat {
            return horizontalSizeClass == .compact ? 0.8 : 0.62
        }
        
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
            VStack {
                if randomNum == 0 {
                    HStack(alignment: .center, spacing: objectSeparation) {
                        Spacer(minLength: 50)
                        Text(text)
                            .font(.system(size: objectFontSize - 10))
                            .foregroundColor(
                                !didTap ? Color.white :
                                (didTap && isCorrectAnswerSelected) ? Color.green :
                                (didTap && !isCorrectAnswerSelected) ? Color.red :
                                Color.white
                            )
                        
                        AsyncImage(url: URL(string: url_icono)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(width: imageWidth, height: imageHeight)
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: imageWidth, height: imageHeight)
                            case .failure:
                                Image(systemName: "xmark.circle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: imageWidth, height: imageHeight)
                            @unknown default:
                                EmptyView()
                            }
                        }
                        Spacer(minLength: 50)
                    }
                    .frame(maxWidth: .infinity)
                }
                if randomNum == 1 {
                    HStack(alignment: .center) {
                        if horizontalSizeClass != .compact {
                            Spacer(minLength: objectSpaceWidth - 20)

                            GeometryReader { geometry in
                                if let videoURL = URL(string: video_url) {
                                    VideoView(videoURL: videoURL)
                                        .aspectRatio(4/5, contentMode: .fill)
                                        .frame(width: UIScreen.main.bounds.width - 240)
                                        .cornerRadius(12)
                                        .padding(10)
                                } else {
                                    Text("Invalid video URL")
                                        .frame(maxWidth: geometry.size.width * videoWidth)
                                        .background(Color.gray)
                                        .cornerRadius(12)
                                        .padding(.vertical, 10)
                                }
                            }
                            .frame(height: UIScreen.main.bounds.height * 0.25)
                            .cornerRadius(12)
                        } else {
                            if let videoURL = URL(string: video_url) {
                                VideoView(videoURL: videoURL)
                                    .aspectRatio(4/5, contentMode: .fill)
                                    .frame(width: UIScreen.main.bounds.width - 240)
                                    .cornerRadius(12)
                                    .padding(10)
                            } else {
                                Text("Invalid video URL")
                                    .frame(minHeight: 0, maxHeight: UIScreen.main.bounds.height * 0.7)
                                    .background(Color.gray)
                                    .cornerRadius(12)
                                    .padding(.vertical, 10)
                                    .foregroundColor(.red)
                            }
                        }
                        
                        Text("Seleccionar")
                            .frame(maxHeight: UIScreen.main.bounds.height * 0.3)
                            .frame(maxWidth: 117)
                            .font(.system(size: objectFontSize2 - 27))
                            .foregroundColor(
                                !didTap ? Color.white :
                                (didTap && isCorrectAnswerSelected) ? Color.green :
                                (didTap && !isCorrectAnswerSelected) ? Color.red :
                                Color.white
                            )
                        if horizontalSizeClass != .compact {
                            Spacer(minLength: objectSpaceWidth - 40)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
    }
}

func getBackgroundColor(for answerIndex: Int) -> Color {
    switch answerIndex {
    case 0:
        return Color.blue
    case 1:
        return Color.blue
    case 2:
        return Color.blue
    case 3:
        return Color.blue
    default:
        return Color.clear
    }
}
