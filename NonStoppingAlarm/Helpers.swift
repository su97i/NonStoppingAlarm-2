//
//  Notifications.swift
//  PNU_Train_V0.2
//
//  Created by Shouq Turki Bin Tuwaym on 18/05/1444 AH.
//

import SwiftUI
//import UserNotifications
//
//

class NotificationManagerr {
    
    static let instance = NotificationManagerr()
    
    func requestAuthorization () {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
            if let error = error {
                print("Error\(error)")
            
            } else {
                print("SUCCESS")
            }
        }
    }
    
    func scheduleNotifications() {
        let content = UNMutableNotificationContent()
        content.title = "Closing soon"
        content.subtitle = "The metro is closing in 30 minutes"
        content.sound = .default
        content.badge = 1
        
        // calender
        var date = DateComponents()
        date.hour = 10
        date.minute  = 45
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}


func createDateTime(time:String) -> Date {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd HH:mm"
    return formatter.date(from: time)!
}

func getDateTime(time:Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "h:mm a"
    return formatter.string(from: time)
}
