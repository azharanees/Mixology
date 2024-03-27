//
//  MixologyApp.swift
//  Mixology
//
//  Created by Azhar Anees on 2024-01-23.
//

import SwiftUI




@main
struct MixologyApp: App {

    let persistenceController = PersistenceController.shared
    let notificationManager = NotificationManager()
    let notificationDelegate = NotificationDelegate()


    var body: some Scene {
        WindowGroup {
           // ContentView()
             //   .environment(\.managedObjectContext, persistenceController.container.viewContext)
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onAppear {
                    notificationManager.requestNotificationPermissions { granted in
                        print("Notification permissions granted: \(granted)")
                    }
                    UNUserNotificationCenter.current().delegate = notificationDelegate
                }
        }
    }
}

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("Will present notification: \(notification)")
        completionHandler([.alert, .sound])
    }
}

