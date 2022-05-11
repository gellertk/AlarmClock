//
//  StaticTableView.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 10.05.2022.
//

import UIKit

class StaticTableView: UITableView {

    convenience init<T: UITableViewCell>(cellTypes: [T.Type]) {
        self.init(frame: .zero, style: .plain)
        cellTypes.forEach {
            register($0.self, forCellReuseIdentifier: $0.reuseIdentifier)
        }
        backgroundColor = .black
        separatorColor = K.Color.tableSeparator
        layer.cornerRadius = K.Numeric.defaultCornerRadius
        isScrollEnabled = false
    }

}
