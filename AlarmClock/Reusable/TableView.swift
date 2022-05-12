//
//  StaticTableView.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 10.05.2022.
//

import UIKit

class TableView: UITableView {

    convenience init<T: UITableViewCell>(cellTypes: [T.Type], isScrollEnabled: Bool = true) {
        self.init(frame: .zero, style: .insetGrouped)
        cellTypes.forEach {
            register($0.self, forCellReuseIdentifier: $0.reuseIdentifier)
        }
        backgroundColor = K.Color.disabledBackground
        separatorColor = K.Color.tableSeparator
        layer.cornerRadius = K.Numeric.defaultCornerRadius
        self.isScrollEnabled = isScrollEnabled
    }

}
