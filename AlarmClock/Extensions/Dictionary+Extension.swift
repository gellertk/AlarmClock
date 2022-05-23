//
//  Dictionary+Extension.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 23.05.2022.
//

import Foundation

extension Dictionary where Key == Int, Value == Bool {
    
    func toWeekDaysFormat() -> String {
        let setted = self.filter { $0.value }.sorted(by: { $0.key < $1.key })
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
    
}
