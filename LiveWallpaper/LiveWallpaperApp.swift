//
//  LiveWallpaperApp.swift
//  LiveWallpaper
//
//  Created by Shashvat Garg on 21/06/26.
//

import SwiftUI

@main
struct LiveWallpaperApp: App {

    init() {
        print("APP STARTED")
    }

    var body: some Scene {

        WindowGroup {

            ContentView()
                .onAppear {

                    DispatchQueue.main.asyncAfter(
                        deadline: .now() + 0.5
                    ) {

                        WindowManager.makeBorderless()
                    }
                }
        }

        MenuBarExtra(
            "LiveWallpaper",
            systemImage: "play.rectangle"
        ) {

            Button("Choose Wallpaper") {

                WallpaperManager.shared.chooseWallpaper()
            }

            Divider()

            Button("Quit") {

                NSApplication.shared.terminate(nil)
            }
        }
    }
}
