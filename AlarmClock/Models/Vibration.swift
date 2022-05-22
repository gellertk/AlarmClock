//
//  Vibration.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 22.05.2022.
//

import Foundation

class Vibration: Hashable {
    
    let id = UUID()
    let title: String
    
    init(_ title: String) {
        self.title = title
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
    }
    
    static func == (lhs: Vibration, rhs: Vibration) -> Bool {
        return lhs.id == rhs.id
    }
    
}
