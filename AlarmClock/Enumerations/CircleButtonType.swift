//
//  CircleButtonType.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 27.03.2022.
//

enum CircleButtonType {
    
    case start
    case stop
    case reset
    case resume
    case pause
    case lapEnabled
    case lapDisabled
    case cancelEnabled
    case cancelDisabled
    
    var buttonTitle: String {
        switch self {
        case .start:
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
