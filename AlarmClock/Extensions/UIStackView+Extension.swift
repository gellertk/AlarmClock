//
//  UIView+Extension.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 17.04.2022.
//

import UIKit

extension UIStackView {
    
    convenience init(arrangedSubviews: [UIView],
                     axis: NSLayoutConstraint.Axis,
                     spacing: CGFloat,
                     distribution: UIStackView.Distribution) {
        
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        self.distribution = distribution
    }
    
}
