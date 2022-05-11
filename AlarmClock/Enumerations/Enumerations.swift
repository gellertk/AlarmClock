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

enum AlarmSetting: String, CaseIterable {
    
    case weekDays = "Повтор"
    case title = "Название"
    case melody = "Мелодия"
    case isRepeated = "Повторение сигнала"
    
    var cellType: UITableViewCell.Type {
        switch self {
        case .weekDays, .title, .melody:
            return DefaultTableViewCell.self
        case .isRepeated:
            return SwitchTableViewCell.self
        }
    }
    
}

enum MelodySection: CaseIterable, Hashable {
    
    static var allCases: [MelodySection] {
        return [.vibration(items: ["Вибрация"]),
                .shop(title: "МАГАЗИН", items: ["Магазин звуков"]),
                .song(title: "ПЕСНИ", items: [Melody("Пенис Птиц Весной (звуки природы)"),
                                               Melody("Выбор песни")]),
                .ringtone(title: "РИНГТОНЫ", items: [Melody("Радар (по умолчанию)"),
                                                      Melody("Апекс"),
                                                      Melody("Вершина"),
                                                      Melody("Вестник"),
                                                      Melody("Волны"),
                                                      Melody("Вступление"),
                                                      Melody("Грезы"),
                                                      Melody("Зыбь"),
                                                      Melody("Иллюминация"),
                                                      Melody("Космос"),
                                                      Melody("Кристаллы"),
                                                      Melody("Маяк"),
                                                      Melody("Медленно в гору"),
                                                      Melody("Мерцание")]),
                .no(items: ["Нет"])
        ]
    }
    
    case vibration(
        items: [String]
    )
    case shop(
        title: String,
        items: [String]
    )
    case song(
        title: String,
        items: [Melody]
    )
    case ringtone(
        title: String,
        items: [Melody]
    )
    case no(
        items: [String]
    )
}
