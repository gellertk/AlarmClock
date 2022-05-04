//
//  WorldClock+CoreDataClass.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 14.02.2022.
//
//

import Foundation
import CoreData

@objc(WorldClock)
public class WorldClock: NSManagedObject {
    
    var time: String {
        
        return dateAdded?.toHoursMinutes() ?? ""
    }
    
}
