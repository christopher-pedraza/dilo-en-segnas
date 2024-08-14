import SwiftUI
import AVKit
import WebKit

struct VideoView: UIViewRepresentable {
    let videoURL: URL
    
    func makeUIView(context: Context) -> UIView {
        if isYouTubeURL(videoURL) {
            let webView = WKWebView()
            let request = URLRequest(url: videoURL)
            webView.load(request)
            return webView
        } else {
            return PlayerUIView(frame: .zero, videoURL: videoURL)
        }
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        if let webView = uiView as? WKWebView {
            let request = URLRequest(url: videoURL)
            webView.load(request)
        } else if let playerUIView = uiView as? PlayerUIView {
            playerUIView.updateVideoURL(videoURL: videoURL)
        }
    }
    
    func isYouTubeURL(_ url: URL) -> Bool {
        return url.host?.contains("youtube.com") == true || url.host?.contains("youtu.be") == true
    }
}

class PlayerUIView: UIView {
    private let playerLayer = AVPlayerLayer()
    private var player: AVPlayer?
    
    init(frame: CGRect, videoURL: URL) {
        super.init(frame: frame)
        self.backgroundColor = .black
        setupPlayer(videoURL: videoURL)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPlayer(videoURL: URL) {
        player = AVPlayer(url: videoURL)
        playerLayer.player = player
        layer.addSublayer(playerLayer)
        player?.play()
    }
    
    func updateVideoURL(videoURL: URL) {
        player?.pause()
        player = AVPlayer(url: videoURL)
        playerLayer.player = player
        player?.play()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}
