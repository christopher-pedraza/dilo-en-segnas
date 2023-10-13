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
        let videoHTML =
        """
        <div style="border-radius: 30px; overflow: hidden; width: 100%; height: 100%; flex; justify-content: center; align-items: center;">
            <iframe width="100%" height="100%" src="https://www.youtube.com/embed/WJfUZ8jcml0?si=j__udeKpMX1DsVRS" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
        </div>
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
