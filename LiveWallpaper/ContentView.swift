import SwiftUI
import AVKit

struct ContentView: View {

    @ObservedObject var wallpaperManager =
        WallpaperManager.shared

    var body: some View {

        ZStack {

            if let player = wallpaperManager.player {

                PlayerView(player: player)
                    .ignoresSafeArea()

            } else {

                Color.clear
            }
        }
    }
}
