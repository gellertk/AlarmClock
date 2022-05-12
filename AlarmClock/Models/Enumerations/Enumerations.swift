//
//  InterfaceType.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 27.03.2022.
//

import UIKit

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

enum AlarmSection: String, CaseIterable {
    case main = "Сон | Пробуждение"
    case other = "Другие"
}

enum CellType: Hashable {
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .valueCell(let options):
            hasher.combine(options)
        case .checkmarkedCell(let options):
            hasher.combine(options)
        case .switchCell(let options):
            hasher.combine(options)
        case .defaultCell(options: let options):
            hasher.combine(options)
        }
    }
    
    case defaultCell(options: DefaultCellOption)
    case valueCell(options: ValueCellOption)
    case checkmarkedCell(options: CheckmarkCellOption)
    case switchCell(options: SwitchCellOption)
}


