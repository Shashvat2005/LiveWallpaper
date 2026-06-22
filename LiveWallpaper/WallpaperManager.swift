import Foundation
import AVFoundation
import AppKit
import Combine

@MainActor
class WallpaperManager: ObservableObject {

    static let shared = WallpaperManager()

    @Published var player: AVPlayer?
    @Published var isPaused = false

    private init() {}

    func chooseWallpaper() {

        let panel = NSOpenPanel()

        panel.allowedContentTypes = [
            .mpeg4Movie,
            .quickTimeMovie
        ]

        panel.allowsMultipleSelection = false

        if panel.runModal() == .OK {

            guard let url = panel.url else {
                return
            }

            loadWallpaper(from: url)
        }
    }

    func loadWallpaper(from url: URL) {

        print("Loading:", url.path)

        let item = AVPlayerItem(url: url)

        let player = AVPlayer(playerItem: item)

        self.player = player

        player.play()

        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: item,
            queue: .main
        ) { _ in

            player.seek(to: .zero)
            player.play()

            print("LOOP")
        }
    }
    
    func togglePlayback() {

        guard let player else {
            return
        }

        if isPaused {

            player.play()

        } else {

            player.pause()
        }

        isPaused.toggle()
    }
}
