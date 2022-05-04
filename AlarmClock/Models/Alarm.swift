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
    let repeatingTypes: [AlarmRepeatingType]
    let isRepeated: Bool
    let category: AlarmCategory
    let ringtoneId: Int?
    
    static func getAlarms() -> [Alarm] {
        return [
            Alarm(title: "Завтра утром", time: "09:30".toDate(), isEnabled: true, repeatingTypes: [], isRepeated: true, category: .main, ringtoneId: nil),
            Alarm(title: "Будильник", time: "17:15".toDate(), isEnabled: true, repeatingTypes: [], isRepeated: true, category: .other, ringtoneId: nil),
            Alarm(title: "Будильник2", time: "20:00".toDate(), isEnabled: false, repeatingTypes: [], isRepeated: true, category: .other, ringtoneId: nil),
            Alarm(title: "Будильниковский", time: "23:10".toDate(), isEnabled: false, repeatingTypes: [], isRepeated: true, category: .other, ringtoneId: nil)
        ]
    }
}
