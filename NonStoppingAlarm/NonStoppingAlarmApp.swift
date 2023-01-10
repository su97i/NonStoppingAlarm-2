//
//  NonStoppingAlarmApp.swift
//  NonStoppingAlarm
//
//  Created by Shouq Turki Bin Tuwaym on 03/01/2023.
//

import SwiftUI

@main
struct NonStoppingAlarmApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        
        WindowGroup {
            ListAlarms().environment(\.managedObjectContext, persistenceController.container.viewContext)

        }
    }
}
