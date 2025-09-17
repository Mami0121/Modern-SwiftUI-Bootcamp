//
//  Bootcamp_Odevi_9App.swift
//  Bootcamp_Odevi_9
//
//  Created by Bozkurt on 17.09.2025.
//

import SwiftUI

@main
struct Bootcamp_Odevi_9App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
                    ContentView()
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
