import AppKit

class WindowManager {

    static func makeBorderless() {

        guard let window = NSApplication.shared.windows.first else {
            return
        }

        guard let screen = NSScreen.main else {
            return
        }
        print("Window level:", window.level.rawValue)
        print("Window frame:", window.frame)

        window.level = NSWindow.Level(
            rawValue: Int(CGWindowLevelForKey(.desktopWindow))
        )
        window.orderBack(nil)

        window.styleMask = [.borderless]
        window.backgroundColor = .clear
        window.isOpaque = false
        window.titleVisibility = .hidden
        window.titlebarAppearsTransparent = true
        window.hasShadow = false
        window.ignoresMouseEvents = true

        window.setFrame(
            screen.frame,
            display: true
        )
        
        
    }
}
