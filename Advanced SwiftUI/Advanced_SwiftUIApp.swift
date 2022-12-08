//
//  Advanced_SwiftUIApp.swift
//  Advanced SwiftUI
//
//  Created by William Souef on 08/12/2022.
//

import SwiftUI

@main
struct Advanced_SwiftUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
