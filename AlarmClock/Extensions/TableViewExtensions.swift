//
//  TableViewExtensions.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 07.03.2022.
//

import UIKit

extension UITableView {
    
    func addTableHeaderViewLine() {
        self.tableHeaderView = {
            let line = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 1 / UIScreen.main.scale))
            line.backgroundColor = self.separatorColor
            return line
        }()
    }
    
}
