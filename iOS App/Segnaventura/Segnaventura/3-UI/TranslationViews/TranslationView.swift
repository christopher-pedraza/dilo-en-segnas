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
        VStack(alignment: .center) {
            
            Spacer()
            
            Image(labelData.image)

            HStack {
                Text(labelData.label.capitalized)
                    .font(.largeTitle).bold()
                
                Button("Audio", action: {

                    let audioFile = labelData.audio.lowercased()
                        soundPlayer.playAudioFile(audioFile) // put in just the file name, including the file extension. Any audio file should work.
                    }
                )
                    .buttonStyle(RoundedRectButtonStyle(buttonColor: .blue))
                    .padding()
                
            }
            
        
            VideoViewCOML(videoURL: URL(string: "https://www.youtube.com/embed/WJfUZ8jcml0?si=j__udeKpMX1DsVRS")!)
                        .frame(width: 420, height: 360)
            Spacer()
            
        }// VStack
        .frame(width: 300)
        .padding()
    }
}

struct TranslationView_Previews: PreviewProvider {
    static var previews: some View {
        TranslationView(labelData: Classification())
    }
}
