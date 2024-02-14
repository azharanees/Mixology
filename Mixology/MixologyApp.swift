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

    var body: some Scene {
        WindowGroup {
           // ContentView()
             //   .environment(\.managedObjectContext, persistenceController.container.viewContext)
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
