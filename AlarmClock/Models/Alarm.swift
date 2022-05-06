//
//  Alarm.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 02.05.2022.
//

import Foundation

struct Alarm: Hashable {
    
    let title: String
    let time: Date
    let isEnabled: Bool
    let id = UUID()
    var repeatingWeekDays: [Int] {
        didSet {
            return repeatingWeekDays.sort()
        }
    }
    let isRepeated: Bool
    let category: AlarmCategory
    let ringtoneId: Int?
    
    static func createDefault() -> Alarm {
        return Alarm(title: "Будильник",
                     time: Date(),
                     isEnabled: true,
                     repeatingWeekDays: [],
                     isRepeated: true,
                     category: .other,
                     ringtoneId: nil)
    }
    
    static func getAlarms() -> [Alarm] {
        return [
            Alarm(title: "Завтра утром",time: "09:30".toDate(), isEnabled: true, repeatingWeekDays: [], isRepeated: true, category: .main, ringtoneId: nil),
            Alarm(title: "Будильник", time: "17:15".toDate(), isEnabled: true, repeatingWeekDays: [], isRepeated: true, category: .other, ringtoneId: nil),
            Alarm(title: "Будильник2", time: "20:00".toDate(), isEnabled: false, repeatingWeekDays: [], isRepeated: true, category: .other, ringtoneId: nil),
            Alarm(title: "Будильниковский", time: "23:10".toDate(), isEnabled: false, repeatingWeekDays: [], isRepeated: true, category: .other, ringtoneId: nil)
        ]
    }
    
    func getRepeatingDays() -> String {
        switch repeatingWeekDays.count {
        case 0:
            return "Никогда"
        case 1:
            return repeatingWeekDays[0].getWeekDayFullDescription()
        case 7:
            return "Каждый день"
        default:
            var repeatingString = ""
            repeatingWeekDays.forEach {
                repeatingString = repeatingString + " " + $0.getWeekDayReducedDescription()
            }
            return repeatingString
        }
    }
  
}
