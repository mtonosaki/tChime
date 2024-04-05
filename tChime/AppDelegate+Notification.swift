//
//  AppDelegate+Notification.swift
//  tChime
//
//  Created by Manabu Tonosaki on 2024/03/31.
//

import Foundation
import UserNotifications

extension AppDelegete : UNUserNotificationCenterDelegate {
    
    func prepareScheduleNotification() {
        // ------------------ FOR SPIKE
        let f = DateFormatter()
        f.timeStyle = .short
        f.dateStyle = .none
        f.dateFormat = "HH:mm:ss"
        let str = f.string(from: Date().addingTimeInterval(2))
        Scheduler.addTime(strTime: str)
        // --------------------------
        
        Scheduler.addTime(strTime: "08:45:00" )
        Scheduler.addTime(strTime: "10:00:00" )
        Scheduler.addTime(strTime: "11:45:00" )
        Scheduler.addTime(strTime: "12:45:00" )
        Scheduler.addTime(strTime: "14:00:00" )
        Scheduler.addTime(strTime: "15:00:00" )
        Scheduler.addTime(strTime: "16:00:00" )
        Scheduler.addTime(strTime: "17:00:00" )
        Scheduler.addTime(strTime: "18:00:00" )
        Scheduler.addTime(strTime: "19:00:00" )
        Scheduler.addTime(strTime: "20:00:00" )
        Scheduler.addTime(strTime: "21:00:00" )
        Scheduler.setNextChime()
    }
    
    // WHEN RECEIVE NOTIFICATION
    func userNotificationCenter( _ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        Scheduler.setNextChime()
        print(">>> will present")
        completionHandler([.sound])
    }
    
    // DID TAPPED NOTIFICATION
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(">>> did tapped")
        completionHandler()
    }
}
