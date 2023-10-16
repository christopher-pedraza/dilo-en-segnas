//
//  AudioView.swift
//  coreML-starter
//

import SwiftUI

struct AudioView: View {
    @Environment(\.dismiss) var dismiss
    @State var soundPlayer = SoundPlayer()
    @State var storyName: String
    @State var audioName: String
    @State var storyText: String
    
    var body: some View {
        
        VStack(alignment: .center) {
            Text(storyName.capitalized)
                .font(.largeTitle)
            
            Spacer()
            
            VStack {
                Text(storyText)
                .multilineTextAlignment(.leading)
            }
            .padding()
            
            Spacer()
            
            VStack(alignment: .center) {
                

                
                HStack {
                    
                    Button(action: {

                            let audioFile = audioName.lowercased()
                            soundPlayer.playAudioFile(audioFile) // put in just the file name, including the file extension. Any audio file should work.
                        }
                    ) {
                        Image(systemName: "play.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                }
            }
            Spacer()
        }// VStack
        .frame(width: 300)
        .padding()
        
    }
}

struct AudioView_Previews: PreviewProvider {
    static var previews: some View {
        AudioView(storyName: "", audioName: "", storyText: "")
    }
}
