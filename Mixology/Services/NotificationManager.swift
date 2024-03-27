//
//  NotificationManager.swift
//  Mixology
//
//  Created by Shashi Dev Shrestha on 2024-03-27.
//

import Foundation
import UserNotifications
import SwiftUI

class NotificationManager: ObservableObject {

    private let notificationCenter = UNUserNotificationCenter.current()

    func requestNotificationPermissions(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
            DispatchQueue.main.async {
                completion(granted)
            }
        }
    }

    func scheduleNotification(enableNotifications: Bool, notificationTime: Date) {
        
        let customReceipeCount = CoreDataManager.shared.fetchCustomRecipes().count

        guard enableNotifications else {
                 cancelNotification()
                 return
             }     
        let uuid = UUID().uuidString
        
        let content = UNMutableNotificationContent()
        content.title = "Time to take those shots"
        content.body = "You have \(customReceipeCount) custom cocktails that you need to make! Enjoy"
        
        let selectedDateComponents = Calendar.current.dateComponents([.hour, .minute], from: notificationTime)
        let hour = selectedDateComponents.hour ?? 0
        let minute = selectedDateComponents.minute ?? 0
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)
        
        notificationCenter.add(request) { error in
            if let error = error {
                print("Failed to schedule notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }
    
    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
