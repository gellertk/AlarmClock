//
//  Alarm.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 02.05.2022.
//

import Foundation

struct Alarm: Hashable {
    
    var title: String
    let time: Date
    let isEnabled: Bool
    let id = UUID()
    var weekDays: [Int] {
        didSet {
            return weekDays.sort()
        }
    }
    var isRepeated: Bool
    let section: AlarmSection
    var melody: Melody?
    
    static func createDefault() -> Alarm {
        return Alarm(title: "Будильник",
                     time: Date(),
                     isEnabled: true,
                     weekDays: [],
                     isRepeated: true,
                     section: .other,
                     melody: nil)
    }
    
    static func getAlarms() -> [Alarm] {
        return [
            Alarm(title: "Завтра утром",time: "09:30".toDate(), isEnabled: true, weekDays: [], isRepeated: true, section: .main, melody: nil),
            Alarm(title: "Будильник", time: "17:15".toDate(), isEnabled: true, weekDays: [], isRepeated: true, section: .other, melody: nil),
            Alarm(title: "Будильник2", time: "20:00".toDate(), isEnabled: false, weekDays: [], isRepeated: true, section: .other, melody: nil),
            Alarm(title: "Будильниковский", time: "23:10".toDate(), isEnabled: false, weekDays: [], isRepeated: true, section: .other, melody: nil)
        ]
    }
    
    func formatedWeekDays() -> String {
        switch weekDays.count {
        case 0:
            return "Никогда"
        case 1:
            return weekDays[0].getWeekDayFullDescription()
        case 7:
            return "Каждый день"
        default:
            var weekDaysString = ""
            weekDays.forEach {
                weekDaysString = weekDaysString + " " + $0.getWeekDayReducedDescription()
            }
            return weekDaysString
        }
    }
    
    subscript(index: Int) -> String {
        get {
            switch index {
            case 0:
                return formatedWeekDays()
            case 1:
                return title
            case 2:
                return (melody?.title ?? "Нет")
            default:
                return ""
            }
        }
    }
        
    subscript(index: Int) -> Bool? {
        get {
            switch index {
            case 3:
                return isRepeated
            default:
                return nil
            }
        }
    }
  
}
