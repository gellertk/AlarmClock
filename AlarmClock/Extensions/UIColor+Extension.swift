//
//  UIColor+Extension.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 30.04.2022.
//

import UIKit

extension UIColor {
    
    static let customBlack: UIColor = .init(red: 28, green: 28, blue: 30)
    
    static let customBlue: UIColor                    = .init(red: 8, green: 120, blue: 247)
    static let customSystemGreen: UIColor            = .init(red: 76, green: 205, blue: 107)
    
    static let customWhite: UIColor         = .init(red: 160, green: 159, blue: 164)
    static let customWhite1: UIColor             = .init(red: 51, green: 51, blue: 54)
    
    static let customGray: UIColor              = .init(red: 51, green: 51, blue: 51)
    static let customGray1: UIColor         = .init(red: 28, green: 28, blue: 30)
    static let customGray2: UIColor               = .init(red: 143, green: 142, blue: 150)

    static let customGreen: UIColor              = .init(red: 70, green: 198, blue: 107)
    static let customGreen1: UIColor             = .init(red: 9, green: 41, blue: 18)

    static let customRed: UIColor             = .init(red: 214, green: 82, blue: 73)
    static let customRed1: UIColor       = .init(red: 52, green: 14, blue: 11)
    static let customRed2: UIColor             = .init(red: 229, green: 92, blue: 88)
    //static let staticTableViewBackground: UIColor  = .init(red: 44, green: 44, blue: 47)

    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red) / 255
        let newGreen = CGFloat(green) / 255
        let newBlue = CGFloat(blue) / 255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
    
}
