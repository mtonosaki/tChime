//
//  AppDelegate+Notification.swift
//  tChime
//
//  Created by Manabu Tonosaki on 2024/03/31.
//

import Foundation
import UserNotifications

extension AppDelegete: UNUserNotificationCenterDelegate {

    func prepareScheduleNotification() {
        // for Notification tester
        let f = DateFormatter()
        f.timeStyle = .short
        f.dateStyle = .none
        f.dateFormat = "HH:mm:ss"
        Scheduler.shared.addTime(strTime: f.string(from: Date().addingTimeInterval(5)), message: "Hello tChime world")

        Scheduler.shared.addTime(strTime: "08:45:00")
        Scheduler.shared.addTime(strTime: "10:00:00")
        Scheduler.shared.addTime(strTime: "11:00:00")
        Scheduler.shared.addTime(strTime: "11:45:00", message: "Lunch time 🍙")
        Scheduler.shared.addTime(strTime: "12:45:00", message: "Let's work !")
        Scheduler.shared.addTime(strTime: "14:00:00")
        Scheduler.shared.addTime(strTime: "15:00:00")
        Scheduler.shared.addTime(strTime: "16:00:00")
        Scheduler.shared.addTime(strTime: "17:00:00")
        Scheduler.shared.addTime(strTime: "17:35:00", message: "Closing time ⏰. Do you want to work overtime?")
        Scheduler.shared.addTime(strTime: "18:00:00")
        Scheduler.shared.addTime(strTime: "19:00:00")
        Scheduler.shared.addTime(strTime: "20:00:00")
        Scheduler.shared.addTime(strTime: "21:00:00")
    }

    // WHEN RECEIVE NOTIFICATION
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        Scheduler.shared.setRequestNextChime()
        print(">>> will present")
        completionHandler([.sound])
    }

    // DID TAPPED NOTIFICATION
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(">>> did tapped")
        completionHandler()
    }
}
