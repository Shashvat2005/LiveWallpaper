import SwiftUI
import AVFoundation
import AppKit

class PlayerNSView: NSView {

    let playerLayer = AVPlayerLayer()

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)

        wantsLayer = true

        layer = CALayer()
        layer?.addSublayer(playerLayer)

        playerLayer.videoGravity = .resizeAspectFill
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layout() {
        super.layout()

        playerLayer.frame = self.bounds
        
        print(bounds)
    }
}

struct PlayerView: NSViewRepresentable {

    let player: AVPlayer

    func makeNSView(context: Context) -> PlayerNSView {

        let view = PlayerNSView()

        view.playerLayer.player = player

        return view
    }

    func updateNSView(
        _ nsView: PlayerNSView,
        context: Context
    ) {

        nsView.playerLayer.player = player
        nsView.playerLayer.frame = nsView.bounds
    }
}
