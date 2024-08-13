//
//  TranslationView.swift
//  coreML-nanostarter
//
//  Created by Adrián Alejandro Ramírez Cruz on 18/09/23.
//

import SwiftUI
import AVKit
import AVFoundation

struct TranslationView: View {
    private(set) var labelData: Classification
    
    @State var soundPlayer = SoundPlayer()
    @EnvironmentObject var ARVM: ARExperience
    @State private var elementTH: THModel? = nil
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var THVM: THViewModel
    
    let synthesizer = AVSpeechSynthesizer()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("Wallpaper")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .center) {
                    if let videoURLString = elementTH?.url_video, let videoURL = URL(string: videoURLString) {
                        VideoView(videoURL: videoURL)
                            .frame(width: 350, height: 210)
                            .padding(EdgeInsets(top: 40, leading: 20, bottom: 10, trailing: 20))
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    } else {
                        Text("No se pudo cargar el video")
                            .frame(width: 350, height: 210)
                            .background(Color.gray)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .padding(EdgeInsets(top: 40, leading: 20, bottom: 10, trailing: 20))
                    }
                    
                    HStack {
                        Text(labelData.label.capitalized)
                            .font(.largeTitle).bold()
                            .foregroundColor(colorScheme == .dark ? Color("Background") : Color.black)
                        
                        Button(action: {
                            let utterance = AVSpeechUtterance(string: labelData.label)
                            utterance.voice = AVSpeechSynthesisVoice(language: "es-MX")
                            synthesizer.speak(utterance)
                        }) {
                            Image(systemName: "speaker.2.fill")
                                .font(.title)
                                .foregroundColor(.black)
                        }
                    }
                    
                    AsyncImage(url: URL(string: elementTH?.url_icono ?? "")) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .frame(width: 200, height: 200)
                                .padding(EdgeInsets(top: -30, leading: 0, bottom: 0, trailing: 0))
                        case .failure:
                            Image(systemName: "exclamationmark.triangle")
                                .resizable()
                                .frame(width: 200, height: 200)
                                .padding(EdgeInsets(top: -30, leading: 0, bottom: 0, trailing: 0))
                        @unknown default:
                            ProgressView()
                        }
                    }
                    
                    NavigationLink(destination: LaunchScreenView()){
                        Text("Guardar")
                    }
                    .buttonStyle(RoundedRectButtonStyle(buttonColor: .blue))
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 40, trailing: 0))
                    
                }
                .frame(maxWidth: 370)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 5)
                .onAppear {
                    Task {
                        elementTH = await getElementTH()
                        print(elementTH)
                    }
                }
            }
        }
    }
    
    func getElementTH() async -> THModel? {
        let th_data = THVM.palabras
        let label_palabra = labelData.label
        
        for index in 0..<th_data.count {
            let currentElement = th_data[index]
            let currentPalabra = currentElement.palabra
            
            if currentPalabra == label_palabra {
                return currentElement
            }
        }
        return nil
    }
}
