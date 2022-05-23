//
//  CellOption.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 12.05.2022.
//

import UIKit

class CellData: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: CellData, rhs: CellData) -> Bool {
        return lhs.id == rhs.id
    }
    
    let cellType: CellType
    let id: String
    var isCheckmarked: Bool
    var text: String
    var secondaryText: String
    let handler: (() -> ())?
    
    init(cellType: CellType, text: String, secondaryText: String = "", isCheckmarked: Bool = false, handler: (() -> ())? = nil ) {
        self.cellType = cellType
        self.text = text
        self.id = text
        self.secondaryText = secondaryText
        self.handler = handler
        self.isCheckmarked = isCheckmarked
    }
    
}
