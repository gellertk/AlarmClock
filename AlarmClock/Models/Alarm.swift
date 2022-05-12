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
    private let id = UUID()
    var weekDays: [Int: Bool]
    var isRepeated: Bool
    let section: AlarmSection
    var melody: Melody?
    
    init(title: String, time: Date, isEnabled: Bool, weekDays: [Int], isRepeated: Bool, section: AlarmSection, melody: Melody?) {
        self.title = title
        self.time = time
        self.isEnabled = isEnabled
        self.isRepeated = isRepeated
        self.section = section
        self.melody = melody
        self.weekDays = [:]
        for index in 0...6 {
            self.weekDays[index] = weekDays.contains { $0 == index }
        }
    }
    
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
            Alarm(title: "Завтра утром", time: "09:30".toDate(), isEnabled: true, weekDays: [], isRepeated: true, section: .main, melody: nil),
            Alarm(title: "Будильник", time: "17:15".toDate(), isEnabled: true, weekDays: [], isRepeated: true, section: .other, melody: nil),
            Alarm(title: "Будильник2", time: "20:00".toDate(), isEnabled: false, weekDays: [], isRepeated: true, section: .other, melody: nil),
            Alarm(title: "Будильниковский", time: "23:10".toDate(), isEnabled: false, weekDays: [], isRepeated: true, section: .other, melody: nil)
        ]
    }
    
    func formatedWeekDays() -> String {
        let setted = weekDays.filter { $0.value }.sorted(by: {$0.key < $1.key})
        switch setted.count {
        case 0:
            return "Никогда"
        case 1:
            return setted.first?.key.toWeekDayFullString() ?? ""
        case 7:
            return "Каждый день"
        default:
            var weekDaysString = ""
            setted.forEach {
                weekDaysString = weekDaysString + " " + $0.key.toWeekDayReducedString()
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
