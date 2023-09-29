//
//  TranslationView.swift
//  coreML-nanostarter
//
//  Created by Adrián Alejandro Ramírez Cruz on 18/09/23.
//

import SwiftUI
import AVKit

struct TranslationView: View {
    private(set) var labelData: Classification
    @State var soundPlayer = SoundPlayer()
    
    
    var body: some View {
        ZStack {
            Color(hex: 0xD5F4FF, opacity: 1.0)
                .ignoresSafeArea()
            
            VStack(alignment: .center) {
                
                VideoViewCOML(videoURL: URL(string: "https://www.youtube.com/embed/WJfUZ8jcml0?si=j__udeKpMX1DsVRS")!)
                    .frame(width: 320, height: 160)
                    .padding(EdgeInsets(top: 40, leading: 0, bottom: 10, trailing: 0))
                
                HStack {
                    Text(labelData.label.capitalized)
                        .font(.largeTitle).bold()

                    Button {action: do {
                        
                        let audioFile = labelData.audio.lowercased()
                            soundPlayer.playAudioFile(audioFile) // put in just the file name, including the file extension. Any audio file should work.
                        }
                            
                    } label: {
                        Image("audioIcon")
                    }
                    
//                    Button("Audio", action: {
//
//                        let audioFile = labelData.audio.lowercased()
//                            soundPlayer.playAudioFile(audioFile) // put in just the file name, including the file extension. Any audio file should work.
//                        }
//                    )
//                        .buttonStyle(RoundedRectButtonStyle(buttonColor: .blue))
//                        .padding()
                    
                }
                
                Image(labelData.image)
                    .resizable()
                    .frame(width: 200, height: 200)
                    .padding(EdgeInsets(top: -30, leading: 0, bottom: 0, trailing: 0))
                
                NavigationLink(destination: VocabularioDataDemo()){
                    Text("Guardar")
                }
                .buttonStyle(RoundedRectButtonStyle(buttonColor: .blue))
                .padding(EdgeInsets(top: -30, leading: 0, bottom: 30, trailing: 0))
                
            }// VStack
//            .padding()
            .frame(maxWidth: 370) // This sets the width of the white card
            .background(Color.white) // This sets the background color of the card
            .cornerRadius(20)
        }
    }
}

struct TranslationView_Previews: PreviewProvider {
    static var previews: some View {
        TranslationView(labelData: Classification())
    }
}
