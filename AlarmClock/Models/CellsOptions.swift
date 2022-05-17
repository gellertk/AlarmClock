//
//  CellOption.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 12.05.2022.
//

import UIKit

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
    
    let cellType: CellType
    let id: String
    var isChekmarked: Bool
    var text: String
    var secondaryText: String
    let handler: (() -> ())?
    
    init(cellType: CellType, text: String, secondaryText: String, handler: @escaping () -> () ) {
        self.cellType = cellType
        self.text = text
        self.id = text
        self.secondaryText = secondaryText
        self.handler = handler
        self.isChekmarked = false
    }
    
    init(cellType: CellType, text: String, handler: @escaping () -> () ) {
        self.cellType = cellType
        self.text = text
        self.id = text
        self.handler = handler
        self.isChekmarked = false
        
        self.secondaryText = ""
    }
    
    init(cellType: CellType, text: String) {
        self.cellType = cellType
        self.text = text
        self.id = text
        self.isChekmarked = false
        
        self.handler = nil
        self.secondaryText = ""
    }
    
    init(cellType: CellType, text: String, isCheckmarked: Bool) {
        self.cellType = cellType
        self.text = text
        self.id = text
        self.isChekmarked = isCheckmarked
        
        self.handler = nil
        self.secondaryText = ""
    }
}
