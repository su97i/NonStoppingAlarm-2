//
//  Alarms+CoreDataProperties.swift
//  NonStoppingAlarm
//
//  Created by Shouq Turki Bin Tuwaym on 09/01/2023.
//
//

import Foundation
import CoreData


extension Alarms {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Alarms> {
        return NSFetchRequest<Alarms>(entityName: "Alarms")
    }

    @NSManaged public var name: String?
    @NSManaged public var time: Date?
    @NSManaged public var sun: Bool
    @NSManaged public var mon: Bool
    @NSManaged public var tue: Bool
    @NSManaged public var wed: Bool
    @NSManaged public var thu: Bool
    @NSManaged public var fri: Bool
    @NSManaged public var sat: Bool
    @NSManaged public var problem_type: String?
    @NSManaged public var vibration: Bool
    @NSManaged public var snooze: Bool

}
