//
//  NonStoppingAlarmApp.swift
//  NonStoppingAlarm
//
//  Created by Shouq Turki Bin Tuwaym on 03/01/2023.
//

import SwiftUI
import CoreData

enum MyViews {
    case SettingAlarm
    case AlarmScreen
}

class NotificationManager: NSObject, ObservableObject {
    @Published var currentViewId: MyViews?

    @ViewBuilder
    func currentView(for id: MyViews) -> some View {
        switch id {
        case .SettingAlarm:
            SettingAlarm()
        case .AlarmScreen:
            AlarmScreen()
        }
    }
}

extension NotificationManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        //App is in foreground
        //do whatever you want here, for example:
        currentViewId = .SettingAlarm
        completionHandler([.sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {

        //App is in background, user has tapped on the notification
        //do whatever you want here, for example:
        currentViewId = .SettingAlarm
        completionHandler()
    }
}

@main
struct NonStoppingAlarmApp: App {
    // here we create the instances for notificationManager and persistenceControllar
    private let notificationManager = NotificationManager()
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        
        WindowGroup {
            ListAlarms()
            // here we add the environment for the next controller
                .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
                .environmentObject(notificationManager)
        }
    }
}
