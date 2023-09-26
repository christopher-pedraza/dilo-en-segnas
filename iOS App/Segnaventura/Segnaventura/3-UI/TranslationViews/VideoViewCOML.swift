import SwiftUI
import WebKit

struct VideoViewCOML: UIViewRepresentable {
    let videoURL: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let videoHTML = """
        <iframe width="560" height="315" src="https://www.youtube.com/embed/WJfUZ8jcml0?si=j__udeKpMX1DsVRS" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
        """

        uiView.loadHTMLString(videoHTML, baseURL: nil)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: VideoViewCOML

        init(_ parent: VideoViewCOML) {
            self.parent = parent
        }
    }
}
