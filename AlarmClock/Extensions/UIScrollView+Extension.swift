//
//  UIScrollViewExtension.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 03.04.2022.
//

import UIKit

extension UIScrollView  {
    
    func stopDecelerating() {
        let contentOffset = self.contentOffset
        self.setContentOffset(contentOffset, animated: false)
    }
}
