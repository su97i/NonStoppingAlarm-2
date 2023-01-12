//
//  Notifications.swift
//  PNU_Train_V0.2
//
//  Created by Shouq Turki Bin Tuwaym on 18/05/1444 AH.
//

import SwiftUI
import UIKit
import AVFoundation
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
    
    func scheduleNotifications(date: Date) {
        
        
        //        let systemSoundID: SystemSoundID = 1016
        //        AudioServicesPlaySystemSound ( systemSoundID)
        let content = UNMutableNotificationContent()
        content.title = "Alarm"
        content.subtitle = "Please wake up"
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "mixkit-warning-alarm-buzzer-991.wav"))
        content.badge = 1
        
        // calender
//        let nextTriggerDate = Calendar.current.date(byAdding: .second, value: 60, to: Date())!
        let comps = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func onTest() {
        
        let content = UNMutableNotificationContent()
        content.title = "Weekly Staff Meeting"
        content.body = "Every Tuesday at 2pm"
        // Configure the recurring date.
        let nextTriggerDate = Calendar.current.date(byAdding: .second, value: 10, to: Date())!
        let comps = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: nextTriggerDate)
        
        
        
        // Create the trigger as a repeating event.
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: comps, repeats: true)
        
        // Create the request
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                                            content: content, trigger: trigger)
        
        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if error != nil {
                // Handle any errors.
            }
        }
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

enum WeekDay: String, Codable, Hashable{
    case Sat = "Sat"
    case Sun = "Sun"
    case Mon = "Mon"
    case Tue = "Tue"
    case Wed = "Wed"
    case Thu = "Thu"
    case Fri = "Fri"
}


struct WeekDayWrapper: Codable, Hashable{
    var val: WeekDay
    var status: Bool
    var num:Int {
        switch(self.val){
            case .Sat:
                return 1
            case .Sun:
                return 2
            case .Mon:
                return 3
            case .Tue:
                return 4
            case .Wed:
                return 5
            case .Thu:
                return 6
            case .Fri:
                return 7
        }
    }
    var str:String {
        switch(self.val){
            case .Sat:
                return "Sat"
            case .Sun:
                return "Sun"
            case .Mon:
                return "Mon"
            case .Tue:
                return "Tue"
            case .Wed:
                return "Wed"
            case .Thu:
                return "Thu"
            case .Fri:
                return "Fri"
        }
    }
}
