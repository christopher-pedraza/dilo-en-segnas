import SwiftUI

struct IndividualVideoActivity: View {
    let videoID: String
    let preguntas: [Pregunta]
    @Binding var correctAnswers: Int
    @State var questionCorrectAnswers: [Int]
    @Binding var totalCorrectAnswers: Int

    func saveData() {}

    var body: some View {
        let customPurple = Color(red: 148 / 255, green: 0 / 255, blue: 122 / 255)

        VStack {
            VideoView(videoID: videoID)
                .frame(minHeight: 0, maxHeight: UIScreen.main.bounds.height * 0.3)
                .cornerRadius(12)
                .padding(.horizontal, 24)

            List {
                ForEach(Array(preguntas.enumerated()), id: \.offset) { questionIndex, pregunta in
                    Section(header: Text(pregunta.pregunta)) {
                        ForEach(pregunta.respuestas.indices, id: \.self) { optionIndex in
                            VideoQuizButton(
                                text: pregunta.respuestas[optionIndex].respuesta,
                                esCorrecta: pregunta.respuestas[optionIndex].es_correcta,
                                questionIndex: questionIndex,
                                optionIndex: optionIndex,
                                cantidadCorrectas: pregunta.cantidadCorrectas.respuestas_video_cuestionario,
                                correctAnswers: $correctAnswers,
                                questionCorrectAnswers: $questionCorrectAnswers
                            )
                        }
                    }
                }
                .listRowBackground(customPurple)
            }
            .listStyle(PlainListStyle())
            .background(customPurple)
            .padding([.bottom], 40)
        }
        .background(Image("Wallpaper")
                        .resizable()
                        .aspectRatio(contentMode: .fill))
    }
}

struct VideoQuizButton: View {
    @State private var didTap: Bool = false
    let text: String
    let esCorrecta: Bool
    let questionIndex: Int
    let optionIndex: Int
    var cantidadCorrectas: Int
    @Binding var correctAnswers: Int
    @Binding var questionCorrectAnswers: [Int]

    let buttonColors: [Color] = [Color.orange, Color.yellow, Color.red, Color.blue] // Customize as needed

    var body: some View {
        Button(action: {
            self.didTap = true
            if esCorrecta {
                correctAnswers += 1
                questionCorrectAnswers[questionIndex] += 1
            }
        }) {
            Text(text)
                .font(.system(size: 24))
                .frame(maxWidth: .infinity)
                .padding()
                .background(didTap ? (esCorrecta ? Color.green : Color.red) : buttonColors[optionIndex % buttonColors.count]) // Cycle through buttonColors for each question
                .foregroundColor(.white)
                .cornerRadius(12)
        }
        .disabled(questionCorrectAnswers[questionIndex] == cantidadCorrectas)
    }
}
