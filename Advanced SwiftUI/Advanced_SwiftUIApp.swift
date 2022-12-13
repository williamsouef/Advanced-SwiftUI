//
//  Advanced_SwiftUIApp.swift
//  Advanced SwiftUI
//
//  Created by William Souef on 08/12/2022.
//

import SwiftUI
import Firebase

@main
struct Advanced_SwiftUIApp: App {
    let persistenceController = PersistenceController.shared

    init() {
        FirebaseApp.configure()
    }
    
    
    
    var body: some Scene {
        WindowGroup {
            SignupView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
