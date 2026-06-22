import Foundation
import AVFoundation
import AppKit
import Combine
import ServiceManagement

enum WallpaperMode: String {

    case fill
    case fit
    case stretch
}

@MainActor
class WallpaperManager: ObservableObject {

    static let shared = WallpaperManager()
    private let wallpaperKey = "wallpaperBookmark"

    @Published var player: AVPlayer?
    @Published var isPaused = false
    @Published var launchAtLogin = false
    @Published var videoGravity: AVLayerVideoGravity = .resizeAspectFill
    @Published var wallpaperMode: WallpaperMode = .fill
    @Published var currentWallpaperName = "None"

    private init() {

        launchAtLogin =
            SMAppService.mainApp.status == .enabled
        
        loadSavedWallpaper()
    }
    
    func loadSavedWallpaper() {
        guard let bookmark =
            UserDefaults.standard.data(
                forKey: wallpaperKey
            )
        else {
            print("No saved wallpaper")
            return
        }

        do {

            var stale = false

            let url = try URL(
                resolvingBookmarkData: bookmark,
                options: [],
                relativeTo: nil,
                bookmarkDataIsStale: &stale
            )
            print("Loading:", url.path)
            print("Exists:", FileManager.default.fileExists(atPath: url.path))

            print("Restored:", url.path)

            loadWallpaper(from: url)

        } catch {

            print("Bookmark load failed:", error)
        }
    }

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
            
            do {

                let bookmark = try url.bookmarkData(
                    options: [],
                    includingResourceValuesForKeys: nil,
                    relativeTo: nil
                )

                UserDefaults.standard.set(
                    bookmark,
                    forKey: wallpaperKey
                )

                print("Bookmark saved")

            } catch {

                print("Bookmark save failed:", error)
            }

            loadWallpaper(from: url)
        }
    }

    func loadWallpaper(from url: URL) {

        print("Loading:", url.path)

        currentWallpaperName = url.lastPathComponent
        
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
    
    func toggleLaunchAtLogin() {

        do {

            if launchAtLogin {

                try SMAppService.mainApp.unregister()

            } else {

                try SMAppService.mainApp.register()
            }

            launchAtLogin.toggle()

        } catch {

            print("Launch at login error:", error)
        }
    }
    
    func setVideoGravity(
        _ gravity: AVLayerVideoGravity
    ) {

        videoGravity = gravity
    }
    
    func setWallpaperMode(
        _ mode: WallpaperMode
    ) {

        wallpaperMode = mode

        switch mode {

        case .fill:
            videoGravity = .resizeAspectFill

        case .fit:
            videoGravity = .resizeAspect

        case .stretch:
            videoGravity = .resize
        }
    }
}
