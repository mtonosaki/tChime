//
//  Scheduler.swift
//  tChime
//
//  Created by Manabu Tonosaki on 2024/04/05.
//

import Foundation
import UserNotifications

class Scheduler {
    static private var times = Array<Date>()
    
    static public func addTime(strTime: String) {
        let f = DateFormatter()
        f.timeStyle = .short
        f.dateStyle = .none
        f.dateFormat = "HH:mm:ss"
        times.append(f.date(from: strTime)!)
    }
    
    static func setNextChime() {
        // PREPARE SAMPLE TIME COLLECTION
        let f = DateFormatter()
        f.timeStyle = .short
        f.dateStyle = .none
        f.dateFormat = "HH:mm:ss"
        
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
                        print( ">> Next chime at", tar)
                        let content = UNMutableNotificationContent()
                        content.title = f.string(from: time)
                        content.subtitle = "break time ☕️"
                        content.sound = UNNotificationSound.init(named: UNNotificationSoundName(rawValue: "sound.caf"))
                        
                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(secTar - secNow), repeats: false)
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
