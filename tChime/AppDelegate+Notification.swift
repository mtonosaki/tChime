//
//  AppDelegate+Notification.swift
//  tChime
//
//  Created by Manabu Tonosaki on 2024/03/31.
//

import Foundation
import UserNotifications

extension AppDelegete : UNUserNotificationCenterDelegate {
    
    // WHEN RECEIVE NOTIFICATION
    func userNotificationCenter( _ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print(">>> will present")
        completionHandler([.sound])
    }
    
    // DID TAPPED NOTIFICATION
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(">>> did tapped")
        completionHandler()
    }
}
