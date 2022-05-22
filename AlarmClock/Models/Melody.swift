//
//  Melody.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 09.05.2022.
//

import Foundation

class Melody: Hashable {
    
    let id = UUID()
    let title: String
    
    init(_ title: String) {
        self.title = title
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
    }
    
    static func == (lhs: Melody, rhs: Melody) -> Bool {
        return lhs.id == rhs.id
    }
    
}
