//
//  UITableViewCell+Extension.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 10.06.2022.
//

import UIKit

extension UITableViewCell {
    
    static var reuseIdentifier: String {
        String(describing: self)
    }

    var reuseIdentifier: String {
        type(of: self).reuseIdentifier
    }
}
