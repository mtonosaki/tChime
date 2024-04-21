//
//  Scheduler.swift
//  tChime
//
//  Created by Manabu Tonosaki on 2024/04/05.
//

import Foundation
import UserNotifications

final public class Scheduler {
    public static let shared = Scheduler()
    private var isSetRequested = true
    private var times = Array<(time: Date, message: String)>()

    private init() { } // for singleton behavior

    public func addTime(strTime: String, message: String = "break time ☕️") {
        let f = DateFormatter()
        f.timeStyle = .short
        f.dateStyle = .none
        f.dateFormat = "HH:mm:ss"
        times.append((time: f.date(from: strTime)!, message: message))
    }

    func setRequestNextChime() {
        self.isSetRequested = true
    }

    func setNextChimeWhenRequested() {
        if(!self.isSetRequested) {
            return
        }
        self.isSetRequested = false

        let f = DateFormatter()
        f.timeStyle = .short
        f.dateStyle = .none
        f.dateFormat = "HH:mm:ss"

        var minDiff = 8640000.0
        var nextTimeMessage: (time: Date, message: String)? = nil
        let nowHms = f.string(from: Date()).split(separator: ":")
        let nowSeconds = Int(nowHms[0])! * 3600 + Int(nowHms[1])! * 60 + Int(nowHms[2])!

        for timeMessage in self.times {
            let tarHms = f.string(from: timeMessage.time).split(separator: ":")
            let tarSeconds = Int(tarHms[0])! * 3600 + Int(tarHms[1])! * 60 + Int(tarHms[2])!

            let diff = Double(tarSeconds - nowSeconds)
            if(diff > 1 && diff < minDiff) {
                minDiff = diff
                nextTimeMessage = timeMessage
            }
        }
        guard let timeMessage = nextTimeMessage else {
            print("No more schedule")
            return
        }

        let targetTimeStr = f.string(from: timeMessage.time)
        print(">> Next chime at", targetTimeStr)
        let content = UNMutableNotificationContent()
        content.title = f.string(from: timeMessage.time)
        content.subtitle = timeMessage.message
//        content.sound = UNNotificationSound.init(named: UNNotificationSoundName(rawValue: "sound.caf"))

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: minDiff, repeats: false)
        let request = UNNotificationRequest(identifier: "tChime." + targetTimeStr, content: content, trigger: trigger)

        UNUserNotificationCenter.current().requestAuthorization(options: []) { success, error in
            if success {
                UNUserNotificationCenter.current().add(request)
            } else {
                print(error?.localizedDescription ?? "Notification init error")
                // TODO: show error message in this view to be modified the permission
            }
        }
    }
}
