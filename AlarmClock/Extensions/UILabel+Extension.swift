//
//  UILabel+Extension.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 25.05.2022.
//

import UIKit

extension UILabel {
    
    func configure(text: String, leadingImage image: UIImage) {
        let imagePart = NSTextAttachment(image: image)
        let attachmentString = NSAttributedString(attachment: imagePart)
        let completeText = NSMutableAttributedString(string: "")
        completeText.append(attachmentString)
        let textAfterIcon = NSAttributedString(string: text)
        completeText.append(textAfterIcon)
        self.attributedText = completeText
    }
    
    
}
