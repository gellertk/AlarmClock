//
//  CellOption.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 12.05.2022.
//

import UIKit

struct DefaultCellOption: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: DefaultCellOption, rhs: DefaultCellOption) -> Bool {
        return lhs.id == rhs.id
    }
    
    let text: String
    let id = UUID()
    let textColor: UIColor
    let handler: (() -> ())
}

struct ValueCellOption: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: ValueCellOption, rhs: ValueCellOption) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id = UUID()
    var text: String
    var secondaryText: String
    let handler: (() -> ())
}

struct CheckmarkCellOption: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: CheckmarkCellOption, rhs: CheckmarkCellOption) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id = UUID()
    var text: String
    var isCheckmarkLeft: Bool
    var isCheckmarked: Bool
    let handler: (() -> ())?
}

struct SwitchCellOption: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(text)
    }
    
    static func == (lhs: SwitchCellOption, rhs: SwitchCellOption) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id = UUID()
    let text: String
    var isOn: Bool
    let handler: (() -> ())
}
