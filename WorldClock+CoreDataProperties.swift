//
//  WorldClock+CoreDataProperties.swift
//  
//
//  Created by Кирилл  Геллерт on 12.06.2022.
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
    @NSManaged public var hourDifference: Int16

}
