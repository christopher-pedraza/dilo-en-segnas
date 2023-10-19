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
    @State private var elementTH: THModel? = nil
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var THVM: THViewModel
    
    
    var body: some View {
        
        ZStack {
            Image("Wallpaper")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            //Color(hex: 0xD5F4FF, opacity: 1.0)
                .ignoresSafeArea()
            
            
            VStack(alignment: .center) {
                VideoView(videoID: elementTH?.id_video_segna ?? "WJfUZ8jcml0?si=j__udeKpMX1DsVRS")
                    .frame(width: 350, height: 210)
                    .padding(EdgeInsets(top: 40, leading: 20, bottom: 10, trailing: 20))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                // Ajustar el padding según lo necesites
                HStack {
                    Text(labelData.label.capitalized)
                        .font(.largeTitle).bold()
                        .foregroundColor(colorScheme == .dark ? Color("Background") : Color.black)

                    Button {action: do {
                        
                        let audioFile = labelData.audio.lowercased()
                            soundPlayer.playAudioFile(audioFile) // put in just the file name, including the file extension. Any audio file should work.
                        } // Button
                            
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
                    
                } //HStack
                
//                Image(labelData.image)
//                    .resizable()
//                    .frame(width: 200, height: 200)
//                    .padding(EdgeInsets(top: -30, leading: 0, bottom: 0, trailing: 0))
                AsyncImage(url: URL(string: elementTH?.url_icono ?? "")) { phase in
                    switch phase {
                    case .empty:
                        // Puedes mostrar un placeholder o indicador de carga aquí
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .frame(width: 200, height: 200)
                            .padding(EdgeInsets(top: -30, leading: 0, bottom: 0, trailing: 0))
                    case .failure:
                        // Puedes mostrar un indicador de error o imagen de reemplazo aquí
                        Image(systemName: "exclamationmark.triangle")
                            .resizable()
                            .frame(width: 200, height: 200)
                            .padding(EdgeInsets(top: -30, leading: 0, bottom: 0, trailing: 0))
                    @unknown default:
                        // Puedes manejar otros casos aquí
                        ProgressView()
                    }
                }
                
                NavigationLink(destination: VocabularioDataDemo()){
                    Text("Guardar")
                }
                .buttonStyle(RoundedRectButtonStyle(buttonColor: .blue))
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 40, trailing: 0))
                
            } //VStack
            .frame(maxWidth: 370) // This sets the width of the white card
            .background(Color.white) // This sets the background color of the card
            .cornerRadius(20)
            .shadow(radius: 5)
            .onAppear { // Llamar a getVideoId en onAppear
                Task {
                    elementTH = await getElementTH()
                    print(elementTH)
                }
            }
            
        } //ZStack
    }
    
    func getElementTH() async -> THModel? {
        
        let th_data = THVM.palabras //.randomElement()?.id_video_segna
        let label_palabra = labelData.label
        
        print("THVM.palabras: \(th_data)")
        print("labelData.label: \(label_palabra)")
        
        for index in 0..<th_data.count {
            let currentElement = th_data[index]
            
            // Accede a las propiedades del elemento actual
            let currentPalabra = currentElement.palabra
            let currentVideoId = currentElement.id_video_segna
            
            print("Elemento en el índice \(index):")
            print("Palabra: \(currentPalabra)")
            print("Video ID: \(currentVideoId)")
            
            if currentPalabra == label_palabra {
                print("\(label_palabra) existe en th_data.")
                print(currentElement.palabra)
                print(currentElement.id_video_segna)
                print(currentElement)
                return currentElement //.id_video_segna
                // Hacer algo con currentVideoId si es necesario
            } else {
                print("\(label_palabra) NO existe en th_data.")
            }
        }
        // Si llegamos a este punto, no se encontró una coincidencia
        return nil
    }
}

struct TranslationView_Previews: PreviewProvider {
    static var previews: some View {
        TranslationView(labelData: Classification())
    }
}

