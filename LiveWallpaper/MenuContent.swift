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

        Divider()

        Text("Wallpaper Mode")

        Button(
            wallpaperManager.wallpaperMode == .fill
            ? "✓ Fill Screen"
            : "Fill Screen"
        ) {

            wallpaperManager.setWallpaperMode(.fill)
        }

        Button(
            wallpaperManager.wallpaperMode == .fit
            ? "✓ Fit Screen"
            : "Fit Screen"
        ) {

            wallpaperManager.setWallpaperMode(.fit)
        }

        Button(
            wallpaperManager.wallpaperMode == .stretch
            ? "✓ Stretch"
            : "Stretch"
        ) {

            wallpaperManager.setWallpaperMode(.stretch)
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
        
        Toggle(
            "Launch at Login",
            isOn: Binding(
                get: {
                    wallpaperManager.launchAtLogin
                },
                set: { _ in
                    wallpaperManager.toggleLaunchAtLogin()
                }
            )
        )

        Divider()

        Button("Quit") {

            NSApplication.shared.terminate(nil)
        }
    }
}
