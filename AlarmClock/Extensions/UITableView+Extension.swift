//
//  UITableView+Extension.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 10.05.2022.
//

import UIKit

extension UITableView {
        
    func register<T: UITableViewCell>(_ type: T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }

}
