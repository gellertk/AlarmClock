//
//  WorldClock+CoreDataProperties.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 14.02.2022.
//
//

import Foundation
import CoreData

extension WorldClock {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorldClock> {
        return NSFetchRequest<WorldClock>(entityName: "WorldClock")
    }

    @NSManaged public var city: String?
    @NSManaged public var dateAdded: Date?

}

extension WorldClock : Identifiable {

}
