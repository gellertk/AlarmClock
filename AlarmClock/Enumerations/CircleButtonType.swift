//
//  CircleButtonType.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 27.03.2022.
//

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