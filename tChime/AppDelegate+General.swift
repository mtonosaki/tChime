//
//  AppDelegate.swift
//  tChime
//
//  Created by Manabu Tonosaki on 2024/03/31.
//

import SwiftUI
import UserNotifications

class AppDelegete: NSObject, NSApplicationDelegate {
    var statusBarItem: NSStatusItem!
    var popover = NSPopover()

    func applicationDidFinishLaunching(_ notification: Notification) {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        prepareScheduleNotification()
        prepareMenuBarIcon()

        Timer.scheduledTimer(withTimeInterval: 3.217, repeats: true) { timer in
            Scheduler.shared.setNextChimeWhenRequested()
        }
    }

    func prepareMenuBarIcon() {
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: MenuView())
        self.statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))

        guard let button = self.statusBarItem.button else { return }
        let image: NSImage = {
            let ratio = $0.size.height / $0.size.width
            $0.size.height = 18
            $0.size.width = 18 / ratio
            return $0
        }(NSImage(named: "MenuIcon")!)
        button.image = image
        button.action = #selector(menuButtonAction(sender:))
    }

    func applicationWillTerminate(_ notification: Notification) {
        cleanupNotification()
    }

    @objc func menuButtonAction(sender: AnyObject) {
        guard let button = self.statusBarItem.button else { return }
        if self.popover.isShown {
            self.popover.performClose(sender)
        } else {
            self.popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            self.popover.contentViewController?.view.window?.makeKey() // when tap outside then close.
        }
    }
}

