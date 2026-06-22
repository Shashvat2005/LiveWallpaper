import SwiftUI
import AVKit

struct ContentView: View {
    
//    @State private var player: AVQueuePlayer?
    @State private var player: AVPlayer?
//    private var looper: AVPlayerLooper?
    
    var body: some View {

        ZStack {

            if let player {

                PlayerView(player: player)
                    .ignoresSafeArea()
            }
        }
        .onAppear {

            if player == nil {
                loadWallpaper()
            }
        }
    }
    
    func loadWallpaper() {
        
        guard let url = Bundle.main.url(
            forResource: "fixed",
            withExtension: "mp4"
        ) else {
            print("Video not found")
            return
        }
        
        Task {
            
            let asset = AVURLAsset(url: url)
            
            do {
                
                let playable = try await asset.load(.isPlayable)
                
                print("Playable:", playable)
                
                let item = AVPlayerItem(asset: asset)
                
                player = AVPlayer(playerItem: item)
                
                player?.play()
                
                NotificationCenter.default.addObserver(
                    forName: .AVPlayerItemDidPlayToEndTime,
                    object: item,
                    queue: .main
                ) { _ in

                    print("LOOP")

                    self.player?.seek(to: .zero)
                    self.player?.play()
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    print("TimeControl:",
                          self.player?.timeControlStatus.rawValue ?? -1)

                    print("ItemStatus:",
                          self.player?.currentItem?.status.rawValue ?? -1)

                    print("Error:",
                          self.player?.currentItem?.error as Any)
                }
                
            } catch {
                
                print("Error:", error)
            }
            
            
                
        }
    }
}
