//
//  UIColor+Extension.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 30.04.2022.
//

import UIKit

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red) / 255
        let newGreen = CGFloat(green) / 255
        let newBlue = CGFloat(blue) / 255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
    
}
