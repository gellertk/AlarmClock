//
//  Melody.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 09.05.2022.
//

import Foundation

struct Melody: Hashable {
    
    let id: Int?
    let title: String
    
    init(_ title: String) {
        self.title = title
        //self.section = section
        self.id = nil
    }
    
//    static func getMelodys() -> [Melody] {
//        //NSSound
////        return [
////            Melody(title: "Пение Птиц Весной (Звуки Природы для Релаксации и Отдыха)", section: .songs(title: "Песни", items: <#T##[String]#>)),
////            //Melody(title: "Вибрация", section: .vibration),
////
////        ]
//        return [Melody(title: <#T##String#>, section: <#T##MelodySection#>)]
//    }
    
}
