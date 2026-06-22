//
//  LiveWallpaperApp.swift
//  LiveWallpaper
//
//  Created by Shashvat Garg on 21/06/26.
//

import SwiftUI

@main
struct LiveWallpaperApp: App {
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
    }
}
