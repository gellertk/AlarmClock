//
//  WorldClock+CoreDataClass.swift
//  
//
//  Created by Кирилл  Геллерт on 12.06.2022.
//
//

import Foundation
import CoreData

@objc(WorldClock)
public class WorldClock: NSManagedObject {

    var time: String {
        guard let dateAdded = dateAdded else {
            return ""
        }
        
        let currentDate = Calendar.current.date(
          byAdding: .hour,
          value: Int.random(in: -5...5),
          to: dateAdded)
        
        return currentDate?.toHoursMinutes() ?? ""
    }
    
    static let defaultCities = [
        "Москва",
        "Калининград",
        "Омск",
        "Екатеринбург"
    ]
    
    static func getSystemWorldClock() -> [String: [String]] {
        var systemWorldClock: [String: [String]] = [:]
        
        TimeZone.knownTimeZoneIdentifiers.forEach { timeZone in
            
            if let timeZone = TimeZone(identifier: timeZone)?.localizedName(for: .shortGeneric,
                                                                            locale: Locale(identifier: "ru_RU")),
               let citySubstring = timeZone.split(separator: "/").last {
                
                let city = String(citySubstring) + ", США"
                let firstLetter = String(city.prefix(1))
                if systemWorldClock[firstLetter] != nil {
                    if systemWorldClock[firstLetter]?.contains(city) == false {
                        systemWorldClock[firstLetter]?.append(city)
                    }
                } else {
                    let cityArray = [city]
                    systemWorldClock[firstLetter] = cityArray
                }
                
            }
            
        }
        
        return systemWorldClock
    }
    
}
