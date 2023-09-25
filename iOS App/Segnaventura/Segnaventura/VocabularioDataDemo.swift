



    import SwiftUI

    struct VocabularioDataDemo: View {
        // Objeto del vocabulario (que se leyo del JSON)
        @EnvironmentObject var VocabularioVM : VocabularioViewModel
        @EnvironmentObject var fsm : FileSystemManager

        
        var body: some View {
            NavigationView {
                VStack {
                    // List with vocabulary. Iterating through categories
                    List(VocabularioVM.vocabulario.categorias) { categoria in
                        CategoryView(category: categoria)
                    }
                    .task {
                        do {
                            // Obtain vocabulary data from the API
                            try await VocabularioVM.getVocabularioData()
                        } catch {
                            print("Error: Couldn't fetch data from the API")
                        }
                    }
                }
                .navigationTitle("Vocabulary") // Set the navigation title
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .background(Color.black)
        }
    }

    struct VocabularioDataDemo_Previews: PreviewProvider {
        static var previews: some View {
            VocabularioDataDemo()
        }
    }

    struct CategoryView: View {
        let category: Categorias // Assuming 'Categorias' is your category type
        @State private var showAllObjects = false

        var body: some View {
            VStack {
                Text(category.nombre_categoria)
                    .font(.system(size: 35))
                    .font(.title)
                    .padding(8)
                    .foregroundColor(.black)

                let maxObjectsPerRow = isLandscape ? 2 : 3
                let objectsToDisplay = showAllObjects ? category.vocabulario.count : min(category.vocabulario.count, maxObjectsPerRow * 2)

                LazyVGrid(columns: columns(), spacing: 8) {
                       ForEach(category.vocabulario.prefix(objectsToDisplay)) { vocabulario in
                           VStack {
                               // Check if url_imagen is empty, and use a fallback image if true
                               if vocabulario.url_imagen.isEmpty || !vocabulario.url_imagen.contains(".com") {
                                   Image("imagenObjetoVacio")
                                       .resizable()
                                       .aspectRatio(contentMode: .fit)
                                       .frame(width: 110, height: 110)
                                       .background(Color.white)
                                       .cornerRadius(10)
                               } else {
                                   Image(vocabulario.url_imagen)
                                       .resizable()
                                       .aspectRatio(contentMode: .fit)
                                       .frame(width: 110, height: 110)
                                       .background(Color.white)
                                       .cornerRadius(10)
                               }
                               
                               Text(vocabulario.palabra_espagnol)
                                   .font(.system(size: 24))
                                   .font(.headline)
                                   .foregroundColor(.white)
                           }
                       }
                   }

                if category.vocabulario.count > maxObjectsPerRow * 2 {
                    Button(action: {
                        showAllObjects.toggle()
                    }) {
                        Text(showAllObjects ? "Show Less" : "Show More")
                            .foregroundColor(.blue)
                    }
                    .padding(.top, 8)
                }
            }
            .padding()
            .cornerRadius(120)
            .background(Color.white)
            .padding(.horizontal)
            .padding(.vertical, 8)
            .border(Color.black, width: 2)

            
        }

        func columns() -> [GridItem] {
            let columnsCount = isLandscape ? 3 : 2
            return Array(repeating: GridItem(.flexible(), spacing: 8), count: columnsCount)
        }

        var isLandscape: Bool {
            return UIDevice.current.orientation.isLandscape
        }
    }


    // Define your 'Categorias' and 'VocabularioViewModel' structs/classes as needed.
