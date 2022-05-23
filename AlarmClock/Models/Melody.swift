//
//  Melody.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 09.05.2022.
//

import Foundation

class Melody: Hashable {
    
    enum MelodyType {
        case ringtone
        case song
        case classicRingtone
    }
    
    let id = UUID()
    let title: String
    let type: MelodyType
    
    init(_ title: String, type: MelodyType) {
        self.title = title
        self.type = type
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
    
    static func == (lhs: Melody, rhs: Melody) -> Bool {
        return lhs.title == rhs.title
    }
    
    static func getRingtones() -> [Melody] {
        return ["Радар (по умолчанию)",
                "Апекс",
                "Вершина",
                "Вестник",
                "Волны",
                "Вступление",
                "Грезы",
                "Зыбь",
                "Иллюминация",
                "Космос",
                "Кристаллы",
                "Маяк",
                "Медленно в гору",
                "Мерцание",
                "Обрыв",
                "Отражение",
                "Перезвон",
                "Подъем",
                "Позывной",
                "Полуночник",
                "Прогулка у моря",
                "Свечение",
                "Сентя",
                "Скорей, скорей",
                "Созвездие",
                "Час потехи",
                "Шелк",
                "Электросхема"].map { Melody($0, type: .ringtone) }
    }
    
    static func getSongs() -> [Melody] {
        return ["Пение Птиц"].map { Melody($0, type: .song) }
    }
    
    static func getClassicRingtones() -> [Melody] {
        return ["Арфа",
                "Блюз",
                "Время идет",
                "Гамма",
                "Гитара",
                "Дверной звонок",
                "Клаксон",
                "Колокольный звон",
                "Ксилофон",
                "Лай",
                "Маримба",
                "Мотоцикл",
                "Пинбол",
                "Прыг-скок",
                "Робот",
                "Сверчок",
                "Сигнал тревоги",
                "Сонар",
                "Телефон",
                "Тимба",
                "Трель",
                "Утка",
                "Фантастика",
                "Фортепиано",
                "Цифровой"].map { Melody($0, type: .classicRingtone) }
    }
    
}
