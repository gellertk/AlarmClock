//
//  Alarm.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 02.05.2022.
//

import Foundation

struct Alarm: Hashable {
    let name: String
    let time: Date
    let isEnabled: Bool
    let id = UUID()
    let repeatingTypes: [AlarmRepeatingType]
    let isRepeated: Bool
    let category: AlarmCategory
    
    static func getAlarms() -> [Alarm] {
        return [
            Alarm(name: "Завтра утром", time: "09:30".toDate(), isEnabled: true, repeatingTypes: [.everyDay], isRepeated: true, category: .main),
            Alarm(name: "Будильник", time: "17:15".toDate(), isEnabled: true, repeatingTypes: [.everyDay], isRepeated: true, category: .other),
            Alarm(name: "Будильник2", time: "20:00".toDate(), isEnabled: false, repeatingTypes: [.everyDay], isRepeated: true, category: .other),
            Alarm(name: "Будильниковский", time: "23:10".toDate(), isEnabled: true, repeatingTypes: [.everyDay], isRepeated: true, category: .other)
        ]
    }
    
}
