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
        
        // PREPARE SAMPLE TIME COLLECTION
        let f = DateFormatter()
        f.timeStyle = .short
        f.dateStyle = .none
        f.dateFormat = "HH:mm:ss"
        var times = Array<Date>()
        times.append(f.date(from: "08:31:00")!)
        times.append(f.date(from: "08:45:00")!)
        times.append(f.date(from: "10:00:00")!)
        times.append(f.date(from: "11:45:00")!)
        times.append(f.date(from: "12:45:00")!)
        times.append(f.date(from: "14:00:00")!)
        times.append(f.date(from: "15:00:00")!)
        times.append(f.date(from: "16:00:00")!)
        times.append(f.date(from: "17:00:00")!)
        times.append(f.date(from: "18:00:00")!)
        times.append(f.date(from: "19:00:00")!)
        times.append(f.date(from: "20:00:00")!)
        times.append(f.date(from: "21:00:00")!)
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.sound]) { success, error in
            if success {
                for time in times {
                    let now = f.string(from: Date())
                    let hmsNow = now.split(separator: ":")
                    let secNow = Int(hmsNow[0])! * 3600 + Int(hmsNow[1])! * 60 + Int(hmsNow[2])!
                    let tar = f.string(from: time)
                    let hmsTar = tar.split(separator: ":")
                    let secTar = Int(hmsTar[0])! * 3600 + Int(hmsTar[1])! * 60 + Int(hmsTar[2])!
                    
                    if(secTar > secNow ){
                        print( String(format: "Local notification have been set at %s"), tar)
                        let content = UNMutableNotificationContent()
                        content.title = f.string(from: time)
                        content.subtitle = "break time ☕️"
                        content.sound = UNNotificationSound(named: UNNotificationSoundName("hoge"))
                        
                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(secTar - secNow), repeats: false)
                        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                        UNUserNotificationCenter.current().add(request)
                        break
                    }
                }
                print("Notification all set !!")
            } else {
                print(error?.localizedDescription ?? "Notification init error")
                // TODO: show error message in this view to be modified the permission
            }
        }

        prepareMenuBarIcon()
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

