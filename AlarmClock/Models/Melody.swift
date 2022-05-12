//
//  Melody.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 09.05.2022.
//

import Foundation

struct MelodySection: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: MelodySection, rhs: MelodySection) -> Bool {
        lhs.id == rhs.id
    }
    
    let id = UUID()
    let title: String
    let items: [CellType]
}

struct Melody: Hashable {
    
    let id: Int?
    let title: String
    
    init(_ title: String) {
        self.title = title
        self.id = nil
    }
    
}
