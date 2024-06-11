// ESTE ARCHIVO ES EL QUE MODIFICA LA FEATURE DE VOCABULARIO
// EL APARTADO DE VÍDEO MUESTRA EL VÍDEO DE LA SEÑA JUNTO A LA PALABRA
// SE PUEDE ESCUCHAR CÓMO SE PRONUNCIA LA PALABRA

import SwiftUI
import AVKit
import AVFoundation

struct VocabularioDataDemo: View {
    @EnvironmentObject var VocabularioVM: VocabularioViewModel
    @EnvironmentObject var fsm: FileSystemManager
    @EnvironmentObject var MI: menuIndex
    @State private var selectedVocabulary: Vocabulario?
    
    let customColor = UIColor(Color(red: 72 / 255, green: 200 / 255, blue: 254 / 255))
    let customColorBackground = Color(red: 205 / 255, green: 241 / 255, blue: 255 / 255)
    
    init() {
        let customColorNavBar = UIColor(Color(red: 21 / 255, green: 17 / 255, blue: 28 / 255))
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = customColorNavBar
        
        let titleFont = UIFont.systemFont(ofSize: 24, weight: .bold)
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: titleFont]
        
        navBarAppearance.backgroundEffect = nil
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List(VocabularioVM.vocabulario.categorias) { categoria in
                    CategoryView(category: categoria)
                        .listRowBackground(customColorBackground)
                }
                .task {
                    do {
                        try await VocabularioVM.getVocabularioData()
                    } catch {
                        print("Error: Couldn't fetch data from the API")
                    }
                }
                .listStyle(PlainListStyle()) // Remove list style to take full width
            }
            .frame(maxWidth: .infinity, alignment: .leading) // Make VStack take full width
            .background(customColorBackground)
            .navigationTitle("Vocabulario")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(item: $selectedVocabulary) { vocabulary in
                if let videoURL = URL(string: vocabulary.id_video_segna) {
                    PopupView(vocabulary: vocabulary, videoURL: videoURL)
                } else {
                    // Handle invalid URL case
                    Text("Invalid video URL")
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

//Vista de la categoria de objetos
struct CategoryView: View {
    @EnvironmentObject var MI: menuIndex
    let customColorVerMas = Color(red: 12 / 255, green: 153 / 255, blue: 255 / 255)
    let category: Categorias
    @State private var showAllObjects = false
    @State private var selectedVocabulary: Vocabulario?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var frameWidth: CGFloat {
        return horizontalSizeClass == .compact ? 100 : 300
    }
    
    var imageWidth: CGFloat {
        return horizontalSizeClass == .compact ? 45 : 100
    }
    var imageHeight: CGFloat {
        return horizontalSizeClass == .compact ? 60 : 120
    }
    
    var objectFontSize: CGFloat {
        return horizontalSizeClass == .compact ? 20 : 35
    }
    var objectTitleFontSize: CGFloat {
        return horizontalSizeClass == .compact ? 35 : 55
    }
    
    var objectTitlePadding: CGFloat {
        return horizontalSizeClass == .compact ? 5 : 30
    }
    
    let customColor = Color(red: 72 / 255, green: 200 / 255, blue: 254 / 255)
    let customColorObjeto = Color(red: 228 / 255, green: 228 / 255, blue: 228 / 255)
    
    var body: some View {
        ZStack {
            VStack {
                Text(category.nombre)
                    .font(.system(size: objectTitleFontSize + 4, weight: .bold))
                    .padding(.top, objectTitlePadding)
                    .padding(.leading, objectTitlePadding)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                let maxObjectsPerRow = isLandscape ? 2 : 3
                let objectsToDisplay = showAllObjects ? category.palabra.count : min(category.palabra.count, 4)
                
                LazyVGrid(columns: columns(), spacing: 0) {
                    ForEach(category.palabra.prefix(objectsToDisplay).indices, id: \.self) { index in
                        let vocabulario = category.palabra[index]
                        
                        VStack (spacing:10) {
                            if vocabulario.url_icono.isEmpty {
                                Image("imagenObjetoVacio")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: imageWidth, height: imageWidth)
                                    .background(Color.white)
                                    .cornerRadius(15)
                            } else {
                                if let imageUrl = URL(string: vocabulario.url_icono),
                                   let imageData = try? Data(contentsOf: imageUrl),
                                   let uiImage = UIImage(data: imageData) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: imageWidth, height: imageWidth)
                                        .padding(.top, 20)
                                        .onTapGesture {
                                            selectedVocabulary = vocabulario
                                        }
                                }
                            }
                            
                            Text(vocabulario.palabra)
                                .font(Font.custom("Poppins-Regular", size: objectFontSize + 3))
                                .font(.headline)
                                .foregroundColor(.black)
                                .frame(width: frameWidth)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 10)
                        }
                        .background(customColorObjeto)
                        .contentShape(Rectangle())
                        .cornerRadius(15)
                        .padding(.horizontal, 50)
                        .padding(.vertical, 13)
                        .onTapGesture {
                            selectedVocabulary = vocabulario
                        }
                    }
                }
                if category.palabra.count > 4 {
                    Button(action: {
                        showAllObjects.toggle()
                    }) {
                        Text(showAllObjects ? "Cerrar" : "Ver más")
                            .foregroundColor(customColorVerMas)
                            .font(.system(size: horizontalSizeClass == .compact ? 18 : 30))
                            .padding(.bottom, 10)
                    }
                    .padding(.top, 5)
                    .padding(.bottom, 3)
                    .padding(.horizontal, 7)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(customColorVerMas, lineWidth: 1)
                            .padding(.bottom, 7)
                    )
                }
            }
            .padding(.horizontal, 10)
            .background(Color.white)
            .cornerRadius(10)
            .sheet(item: $selectedVocabulary) { vocabulary in
                if let videoURL = URL(string: vocabulary.id_video_segna) {
                    PopupView(vocabulary: vocabulary, videoURL: videoURL)
                } else {
                    Text("Invalid video URL")
                }
            }
        }
        .padding(.horizontal, 10)
        Button("Regresar") {
            MI.index = 1
        }
    }
    
    func columns() -> [GridItem] {
        let columnsCount = isLandscape ? 3 : 2
        return Array(repeating: GridItem(.flexible(), spacing: 8), count: columnsCount)
    }
    
    var isLandscape: Bool {
        return UIDevice.current.orientation.isLandscape
    }
}

//Vista del popup cuando usuario selecciona objeto
struct PopupView: View {
    let vocabulary: Vocabulario
    let videoURL: URL
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    let synthesizer = AVSpeechSynthesizer()
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.gray)
                        .padding()
                }
            }
            VideoView(videoURL: videoURL)
                .frame(width: horizontalSizeClass == .compact ? 300 : 550, height: horizontalSizeClass == .compact ? 240 : 400)
                .cornerRadius(30)
            HStack {
                Text(vocabulary.palabra)
                    .font(.system(size: horizontalSizeClass == .compact ? 26 : 53))
                
                Button(action: {
                    let utterance = AVSpeechUtterance(string: vocabulary.palabra)
                    utterance.voice = AVSpeechSynthesisVoice(language: "es-MX")
                    synthesizer.speak(utterance)
                }) {
                    Image(systemName: "speaker.2.fill")
                        .font(.title)
                        .foregroundColor(.black)
                }
            }
            if let imageUrl = URL(string: vocabulary.url_icono),
               let imageData = try? Data(contentsOf: imageUrl),
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: horizontalSizeClass == .compact ? 300 : 550, height: horizontalSizeClass == .compact ? 220 : 400)
                    .cornerRadius(30)
            }
            Spacer()
        }
    }
}
