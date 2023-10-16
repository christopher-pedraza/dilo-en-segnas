    import SwiftUI
    import AVKit

    struct VocabularioDataDemo: View {
        @EnvironmentObject var VocabularioVM: VocabularioViewModel
        @EnvironmentObject var fsm: FileSystemManager
        @State private var selectedVocabulary: Vocabulario?

        let customColor = UIColor(Color(red: 72 / 255, green: 200 / 255, blue: 254 / 255)) // Replace with your RGB values

        //Para editar la navbar de la parte superior de la pantalla
        init() {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.backgroundColor = customColor
            UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        }   

        var body: some View {
                NavigationStack {
                    VStack {
                        List(VocabularioVM.vocabulario.categorias) { categoria in
                            CategoryView(category: categoria)
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
                    .navigationTitle("Vocabulary")
                    .navigationBarTitleDisplayMode(.inline)
                    
                    .sheet(item: $selectedVocabulary) { vocabulary in
                        PopupView(vocabulary: vocabulary, videoID: vocabulary.id_video)
                    }
                }
            
            
            .navigationViewStyle(StackNavigationViewStyle())
            
        }
    }
    

    struct VocabularioDataDemo_Previews: PreviewProvider {
        static var previews: some View {
            VocabularioDataDemo()
        }
    }

//Vista de la categoria de objetos
        struct CategoryView: View {
            let category: Categorias
            @State private var showAllObjects = false //Variable que controla si
            @State private var selectedVocabulary: Vocabulario? //Variable para definir vocabulario que selecciono el usuario
            @Environment(\.horizontalSizeClass) var horizontalSizeClass

            var imageWidth: CGFloat {
                return horizontalSizeClass == .compact ? 100 : 210
            }

            var objectFontSize: CGFloat {
                return horizontalSizeClass == .compact ? 18 : 35
            }
            
            let customColor = Color(red: 72 / 255, green: 200 / 255, blue: 254 / 255)
            
            

            var body: some View {
                VStack {
                    Text(category.nombre_categoria)
                        .font(.system(size: horizontalSizeClass == .compact ? 25 : 40))
                        .font(.title)
                        .padding(8)
                        .foregroundColor(.black)
                    
                    //Limita objetos en una categoria a 6, checa si esta inclinado para definir numero de filas y  columnas
                    let maxObjectsPerRow = isLandscape ? 2 : 3
                    let objectsToDisplay = showAllObjects ? category.vocabulario.count : min(category.vocabulario.count, maxObjectsPerRow * 2)

                    LazyVGrid(columns: columns(), spacing: 0) {
                        ForEach(category.vocabulario.prefix(objectsToDisplay).indices, id: \.self) { index in
                            let vocabulario = category.vocabulario[index]
                            VStack {
                                // Check if url_imagen is empty, and use a fallback image if true
                                if vocabulario.url_imagen.isEmpty {
                                    Image("imagenObjetoVacio")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: imageWidth, height: imageWidth)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                } else {
                                    if let imageUrl = URL(string: vocabulario.url_imagen),
                                       let imageData = try? Data(contentsOf: imageUrl),
                                       let uiImage = UIImage(data: imageData) {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: imageWidth, height: imageWidth)
                                            .background(Color.white)
                                            .cornerRadius(30)
                                            .onTapGesture {
                                                selectedVocabulary = vocabulario // Set the selected vocabulary
                                            }
                                    }
                                }

                                Text(vocabulario.palabra_espagnol)
                                    .font(.system(size: objectFontSize)) // Adjust font size here
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .padding(.bottom,5)
                            }
                            
                            .contentShape(Rectangle()) // Make the whole cell tappable
                            .onTapGesture {
                                selectedVocabulary = vocabulario // Set the selected vocabulary when the cell is tapped
                            }
                        }
                    }
                    if category.vocabulario.count > 6 {
                        Button(action: {
                            showAllObjects.toggle()
                        }) {
                            Text(showAllObjects ? "Cerrar" : "Ver más")
                                .foregroundColor(Color(red: 0, green: 0, blue: 0.5))
                                .font(.system(size: horizontalSizeClass == .compact ? 18 : 30))
                        }
                        .padding(.top, 8)
                        .padding(.bottom, 8)
                    }
                }
               
                .background(customColor)
                .cornerRadius(20)
            .sheet(item: $selectedVocabulary) { vocabulary in
                PopupView(vocabulary: vocabulary, videoID: vocabulary.id_video)
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
    let videoID: String // Provide the video ID here
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
    
            HStack {
                Spacer()
                Button(action: {
                    // Close the popup when the close button is clicked
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.gray)
                        .padding()
                }
            }
            Text(vocabulary.palabra_espagnol)
                .font(.title)
                .font(.system(size: horizontalSizeClass == .compact ? 25 : 80)) // Adjust font size based on size class

            // Embed the YouTube video using VideoView
            VideoView(videoID: videoID)
                .frame(width: horizontalSizeClass == .compact ? 300 : 550, height: horizontalSizeClass == .compact ? 220 : 400) // Adjust size based on size class
                .cornerRadius(30)

            if let imageUrl = URL(string: vocabulary.url_imagen),
               let imageData = try? Data(contentsOf: imageUrl),
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: horizontalSizeClass == .compact ? 300 : 550, height: horizontalSizeClass == .compact ? 220 : 400) // Adjust size based on size class
                    
                    .cornerRadius(30)
            }
            Spacer()
        }
    }
}


