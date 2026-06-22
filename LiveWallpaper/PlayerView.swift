import SwiftUI
import AVFoundation
import AppKit

struct PlayerView: NSViewRepresentable {

    let player: AVPlayer

    func makeNSView(context: Context) -> NSView {

        let view = NSView()

        let playerLayer = AVPlayerLayer(player: player)

        playerLayer.videoGravity = WallpaperManager.shared.videoGravity

        view.layer = playerLayer
        view.wantsLayer = true

        return view
    }

    func updateNSView(
        _ nsView: NSView,
        context: Context
    ) {

        guard let playerLayer =
            nsView.layer as? AVPlayerLayer
        else {
            return
        }
        playerLayer.videoGravity = WallpaperManager.shared.videoGravity

        playerLayer.player = player

        playerLayer.frame = nsView.bounds
    }
}
