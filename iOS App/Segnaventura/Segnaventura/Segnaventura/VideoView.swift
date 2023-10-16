//
//  VideoView.swift
//  Segnaventura
//
//  Created by Christopher Pedraza on 17/09/23.
//

import SwiftUI
import WebKit

// Template para poder crear views de videos de youtube
struct VideoView: UIViewRepresentable {
    let videoID : String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        // Toma el URL embebido usando el id del video
        guard let youtubeURL = URL(string: "https://www.youtube.com/embed/\(videoID)") else {return}
        // Para evitar que se pueda hacer scroll
        uiView.scrollView.isScrollEnabled = false
        // Carga el video
        uiView.load(URLRequest(url: youtubeURL))
    }
}
