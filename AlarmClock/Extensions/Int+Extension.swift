//
//  Int+Extension.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 06.05.2022.
//

import Foundation

extension Int {
    
    func getWeekDayFullDescription() -> String {
        switch self {
        case 0:
            return "Каждый понедельник"
        case 1:
            return "Каждый вторник"
        case 2:
            return "Каждую среду"
        case 3:
            return "Каждый четверг"
        case 4:
            return "Каждую пятницу"
        case 5:
            return "Каждую субботу"
        case 6:
            return "Каждое воскресенье"
        default:
            return ""
        }
    }
    
    func getWeekDayReducedDescription() -> String {
        switch self {
        case 0:
            return "Пн"
        case 1:
            return "Вт"
        case 2:
            return "Ср"
        case 3:
            return "Чт"
        case 4:
            return "Пт"
        case 5:
            return "Сб"
        case 6:
            return "Вс"
        default:
            return ""
        }
    }
    
}

