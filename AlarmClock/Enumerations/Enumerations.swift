//
//  InterfaceType.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 27.03.2022.
//

enum InterfaceType {
    case stopwatchInitial
    case stopwatchRunning
    case stopwatchPaused
    
    case timerInitial
    case timerRunning
    case timerPaused
}

enum TimerType: String {
    case stopwatch
    case timer
}

enum CircleButtonType {
    case startStopwatch
    case stop
    case reset
    case lapEnabled
    case lapDisabled
    
    case startTimer
    case pause
    case resume
    case cancelEnabled
    case cancelDisabled
    
    var title: String {
        switch self {
        case .startStopwatch:
            return "Старт"
        case .startTimer:
            return "Старт"
        case .stop:
            return "Стоп"
        case .lapDisabled:
            return "Круг"
        case .lapEnabled:
            return "Круг"
        case .reset:
            return "Сброс"
        case .cancelDisabled:
            return "Отмена"
        case .cancelEnabled:
            return "Отмена"
        case .pause:
            return "Пауза"
        case .resume:
            return "Дальше"
        }
    }
    
}

enum AlarmRepeatingType: String, CaseIterable {
    
    case everyMonday = "Каждый понедельник"
    case everyTuesday = "Каждый вторник"
    case everyWednesday = "Каждую среду"
    case everyThursday = "Каждый четверг"
    case everyFriday = "Каждую пятницу"
    case everySaturday = "Каждую субботу"
    case everySunday = "Каждое воскресенье"
    
    var reducing: String {
        switch self {
        case .everyMonday:
            return "Пн"
        case .everyTuesday:
            return "Вт"
        case .everyWednesday:
            return "Ср"
        case .everyThursday:
            return "Чт"
        case .everyFriday:
            return "Пт"
        case .everySaturday:
            return "Сб"
        case .everySunday:
            return "Вс"
        }
    }
    
}

enum AlarmCategory: String, CaseIterable {
    case main = "Сон | Пробуждение"
    case other = "Другие"
}

enum AlarmSettings: String, CaseIterable {
    case repeating = "Повтор"
    case title = "Название"
    case ringtone = "Мелодия"
    case isRepeated = "Повторение сигнала"
}
