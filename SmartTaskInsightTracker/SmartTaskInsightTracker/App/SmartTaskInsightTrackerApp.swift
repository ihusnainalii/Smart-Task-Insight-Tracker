//
//  SmartTaskInsightTrackerApp.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

import SwiftUI

@main
struct SmartTaskInsightTrackerApp: App {
    
    let persistenceController = PersistenceController.shared
    let container = AppContainer()

    var body: some Scene {
        WindowGroup {
            AppCoordinatorView()
                .loadView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environment(\.appContainer, container)
        }
    }
}
