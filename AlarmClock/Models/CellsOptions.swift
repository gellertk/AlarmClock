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

struct CellSection {
    let title: String
    let items: [CellData]
}

struct CellData: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: CellData, rhs: CellData) -> Bool {
        return lhs.id == rhs.id
    }
    
    let cellType: CellTypeNew
    let id: String
    var text: String
    var secondaryText: String
    let handler: (() -> ())?
    
    init(cellType: CellTypeNew, text: String, secondaryText: String, handler: @escaping () -> () ) {
        self.cellType = cellType
        self.text = text
        self.id = text
        self.secondaryText = secondaryText
        self.handler = handler
    }
    
    init(cellType: CellTypeNew, text: String, handler: @escaping () -> () ) {
        self.cellType = cellType
        self.text = text
        self.id = text
        self.handler = handler
        
        self.secondaryText = ""
    }
    
    init(cellType: CellTypeNew, text: String) {
        self.cellType = cellType
        self.text = text
        self.id = text
        self.handler = nil
        
        self.secondaryText = ""
    }
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
