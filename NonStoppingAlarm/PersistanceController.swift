//
//  PersistanceController.swift
//  NonStoppingAlarm
//
//  Created by Shouq Turki Bin Tuwaym on 09/01/2023.
//

import Foundation
import CoreData


struct PersistenceController {
    // A singleton for our entire app to use
    static let shared = PersistenceController(inMemory: false)

    // Storage for Core Data
    let container: NSPersistentContainer

    // A test configuration for SwiftUI previews
    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)

        // Create 10 example programming languages.
        for _ in 0..<10 {
            let alarm = Alarms(context: controller.container.viewContext)
            alarm.fri = true
            alarm.time = Date()
            alarm.name = "Testing"
        }

        return controller
    }()

    // An initializer to load Core Data, optionally able
    // to use an in-memory store.
    init(inMemory: Bool = false) {
        // If you didn't name your model Main you'll need
        // to change this name below.
        container = NSPersistentContainer(name: "Model")

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
}
