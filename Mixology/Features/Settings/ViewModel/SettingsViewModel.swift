//
//  SettingsViewModel.swift
//  Mixology
//
//  Created by Shashi Dev Shrestha on 2024-03-25.
//

import SwiftUI
import CoreData

// ViewModel for Settings
class SettingsViewModel: ObservableObject {
    @Published var enableNotifications = false
    
    @Published var selectedDateTime = Date()
    
    private let coreDataManager: CoreDataManager
    private let notificationManager: NotificationManager


    
    init(coreDataManager: CoreDataManager = CoreDataManager.shared, notificationManager: NotificationManager = NotificationManager()) {
        self.coreDataManager = coreDataManager
        self.notificationManager = notificationManager
        loadSettings()
    }
    
    
    func loadSettings() {
        let settings = coreDataManager.fetchSettings()
        if let existingSettings = settings.first {
            enableNotifications = existingSettings.enableNotification
            selectedDateTime = existingSettings.dateTime ?? Date()
        }
    }
    
    func saveSettings() {
        coreDataManager.updateSettings(self)
        if enableNotifications {
            notificationManager.scheduleNotification(enableNotifications: enableNotifications, notificationTime: selectedDateTime)
        }
        else {
            notificationManager.cancelNotification()
         }
    }
    
}
