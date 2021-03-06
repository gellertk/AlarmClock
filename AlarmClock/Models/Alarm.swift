//
//  Alarm.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 02.05.2022.
//

import Foundation

struct Alarm: Hashable {
    
    enum Section: String, CaseIterable {
        case main = "Сон | Пробуждение"
        case other = "Другие"
    }
    
    private let id = UUID()
    let section: Section
    var time: Date
    var title: String
    var isEnabled: Bool
    var isRepeated: Bool
    let isMainAlarm: Bool
    var melody: Melody?
    var vibration: Vibration?
    var weekDays: [Int: Bool]
    
    init(section: Section,
         title: String,
         time: Date,
         isEnabled: Bool,
         isMainAlarm: Bool,
         weekDays: [Int],
         isRepeated: Bool,
         melody: Melody? = nil,
         vibration: Vibration? = nil) {
        
        self.section = section
        self.title = title
        self.time = time
        self.isEnabled = isEnabled
        self.isRepeated = isRepeated
        self.isMainAlarm = isMainAlarm
        self.melody = melody
        self.vibration = vibration
        self.weekDays = [:]
        for index in 0...6 {
            self.weekDays[index] = weekDays.contains { $0 == index }
        }
    }
    
    static func createDefaultAlarm() -> Alarm {
        return Alarm(section: .other,
                     title: "Будильник",
                     time: Date(),
                     isEnabled: true,
                     isMainAlarm: false,
                     weekDays: [],
                     isRepeated: true,
                     melody: nil)
    }
    
    static func getAlarms() -> [Alarm] {
        return [
            Alarm(section: .main,
                  title: "Завтра утром",
                  time: "09:30".toDate(),
                  isEnabled: true,
                  isMainAlarm: true,
                  weekDays: [],
                  isRepeated: true,
                  melody: nil),
            Alarm(section: .other,
                  title: "Будильник",
                  time: "10:29".toDate(),
                  isEnabled: true,
                  isMainAlarm: false,
                  weekDays: [0, 1, 2, 3, 4, 5, 6],
                  isRepeated: true,
                  melody: nil),
            Alarm(section: .other,
                  title: "Будильник2",
                  time: "19:00".toDate(),
                  isEnabled: false,
                  isMainAlarm: false,
                  weekDays: [1, 5],
                  isRepeated: true,
                  melody: nil),
            Alarm(section: .other,
                  title: "Будильниковский",
                  time: "23:10".toDate(),
                  isEnabled: false,
                  isMainAlarm: false,
                  weekDays: [],
                  isRepeated: false,
                  melody: Melody("Пение Птиц", type: .song))
        ]
    }
    
    subscript(index: Int) -> String {
        get {
            switch index {
            case 0:
                return weekDays.toWeekDaysFormat()
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
