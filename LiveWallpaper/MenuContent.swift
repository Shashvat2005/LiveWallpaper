//
//  MenuContent.swift
//  LiveWallpaper
//
//  Created by Shashvat Garg on 22/06/26.
//
import SwiftUI
struct MenuContent: View {

    @ObservedObject var wallpaperManager =
        WallpaperManager.shared

    var body: some View {

        Button("Choose Wallpaper") {

            wallpaperManager.chooseWallpaper()
        }

        Divider()

        Button(
            wallpaperManager.isPaused
            ? "Resume Wallpaper"
            : "Pause Wallpaper"
        ) {

            wallpaperManager.togglePlayback()
        }

        Divider()

        Button("Quit") {

            NSApplication.shared.terminate(nil)
        }
    }
}
