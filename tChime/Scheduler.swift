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

    func setNextChime() {
        if(!self.isSetRequested) {
            return
        }
        self.isSetRequested = false

        let f = DateFormatter()
        f.timeStyle = .short
        f.dateStyle = .none
        f.dateFormat = "HH:mm:ss"

        UNUserNotificationCenter.current().requestAuthorization(options: [.sound]) { success, error in
            if success {
                for timeMessage in self.times {
                    let nowHms = f.string(from: Date()).split(separator: ":")
                    let nowSeconds = Int(nowHms[0])! * 3600 + Int(nowHms[1])! * 60 + Int(nowHms[2])!
                    let tarHms = f.string(from: timeMessage.time).split(separator: ":")
                    let tarSeconds = Int(tarHms[0])! * 3600 + Int(tarHms[1])! * 60 + Int(tarHms[2])!

                    if(tarSeconds > nowSeconds) {
                        print(">> Next chime at", tarHms.joined(separator: ":"))
                        let content = UNMutableNotificationContent()
                        content.title = f.string(from: timeMessage.time)
                        content.subtitle = timeMessage.message
                        content.sound = UNNotificationSound.init(named: UNNotificationSoundName(rawValue: "sound.caf"))

                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(tarSeconds - nowSeconds), repeats: false)
                        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                        UNUserNotificationCenter.current().add(request)
                        break
                    }
                }
            } else {
                print(error?.localizedDescription ?? "Notification init error")
                // TODO: show error message in this view to be modified the permission
            }
        }
    }
}
