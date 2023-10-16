import Foundation

// Modelo general que contains a list of the vocabulary categories
struct VocabularioModel: Decodable, Identifiable {
    var id = UUID()
    var categorias: [Categorias] = [Categorias]()
    
    enum CodingKeys: String, CodingKey {
        case categorias
    }
}

// Categories of the vocabulary.
// Identified by their id and name
// Contains a list of vocabulary items
struct Categorias: Decodable, Identifiable {
    var id = UUID()
    var id_isla: Int = 0 // Change the data type to Int
    var nombre: String = ""
    var palabra: [Vocabulario] = [Vocabulario]()
    
    enum CodingKeys: String, CodingKey {
        case id_isla
        case nombre
        case palabra
    }
}

// Vocabulary
// Identified by its id
// Contains other data such as the Spanish word and URLs to audio, video, and image
struct Vocabulario: Decodable, Identifiable {
    var id = UUID()
    var id_palabra: Int = 0 // Change the data type to Int
    var palabra: String = ""
    var id_video_segna: String = ""
    var url_icono: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id_palabra
        case palabra
        case id_video_segna
        case url_icono
    }
}
